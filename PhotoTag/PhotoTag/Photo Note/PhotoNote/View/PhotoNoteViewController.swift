//
//  PhotoNoteViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit
import YPImagePicker

enum NoteState {
    case creating, reading
}

class PhotoNoteViewController: UIViewController {
    
    weak var coordinator: PhotoNoteCoordinator?
    let viewModel: PhotoNoteViewModel
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var imageHorizontalScrollView: UIScrollView!
    private var noteState: NoteState
    
    init(coordinator: PhotoNoteCoordinator,
         viewModel: PhotoNoteViewModel,
         isCreating: NoteState,
         selectedImages: [NoteImage]) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.noteState = isCreating
        self.viewModel.updateSelectedImages(with: selectedImages)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
        setupView()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentNoteWritingScene))
        noteTextView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        switch noteState {
        case .creating: viewModel.saveNewNote {
            DispatchQueue.main.async { self.presentAlert() }
        }
        case .reading: viewModel.editNote {
            DispatchQueue.main.async { self.presentAlert() }
        }
        }
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moreButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Action", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete button")
            self.viewModel.deleteNote { success in
                if success ?? false { DispatchQueue.main.async { self.presentAlert() }}}
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true)
        
    }
    
    private func setupView() {
        setupButtons()
        noteTextView.isEditable = false
        imageHorizontalScrollView.delegate = self
        setupPageControl()
        presentNoteViewForWriting()
        if noteState == .creating {
            displayPhotos()
        }
        displayDate()
        
    }
    
    private func presentNoteViewForWriting() {
        switch noteState {
        case .creating: presentNoteWritingScene()
        case .reading: presentNoteViewForReading()
        }
    }
    
    private func presentNoteViewForReading() {
        viewModel.fetchNoteContent { photoNote in
            self.viewModel.noteId.value = photoNote.noteID
            self.viewModel.storeFetchedNote(photoNote: photoNote)
            self.viewModel.noteContentText.value = photoNote.rawMemo
            DispatchQueue.main.async {
                self.dateLabel.text = "\(photoNote.created)"
                    .components(separatedBy: "T").first!
                self.noteTextView.text = photoNote.rawMemo }
            self.highlightTag(in: photoNote)
        }
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(saveNoteText), name: .writeNote, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(allImagesAreFetched), name: .noteImages, object: nil)
    }
    
    private func filterTags(content: String) {
        if !content.contains("#") {
            let noTagText = " #noTag"
            self.viewModel.noteContentText.value += noTagText
        }
    }
    
    private func setupButtons() {
        moreButton.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
    }
    
    private func displayDate() {
        DispatchQueue.main.async {
            if self.viewModel.date == nil { self.dateLabel.isHidden = true } }
    }
    
    @objc private func presentNoteWritingScene() {
        coordinator?.navigateToWritePhotoNote(with: noteContentText)
    }
    
    @objc func saveNoteText(_ notification: Notification) {
        guard let content =
                notification.userInfo?[NoteViewController.contentTextKey] as? String else { return }
        viewModel.noteContentText.value = content // save passed text
        filterTags(content: content)
        updateTextViewWithText()
    }
    
    private func updateTextViewWithText() {
        DispatchQueue.main.async { self.noteTextView.text = self.viewModel.noteContentText.value }
    }
    
    // receive notification after fetching all images
    @objc private func allImagesAreFetched(_ notification: Notification) {
        self.displayPhotos()
    }
    
    private func highlightTag(in note: PhotoNote) {
        let tags = note.tags.map({"#\($0)"})
        DispatchQueue.main.async {
            guard let labelText = self.noteTextView.text else { return }
            let attributedStr = NSMutableAttributedString(string: labelText)
            for tag in tags {
                
                attributedStr.addAttribute(.foregroundColor, value: UIColor.keyColorInLightMode, range: (labelText as NSString).range(of: "\(tag)"))
            }
            self.noteTextView.attributedText = attributedStr
        }
    }
}

// display images
extension PhotoNoteViewController {
    private func displayPhotos() {
        for i in 0..<viewModel.selectedImages.value.count {
            
            if i == 0 {
                DispatchQueue.main.async {
                    let xPosition = self.view.frame.width * CGFloat(i)
                    self.firstImageView.image = self.viewModel.selectedImages.value[i]
                    self.firstImageView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.imageStackView.frame.height)
                    self.imageHorizontalScrollView.contentSize.width = self.view.frame.width * CGFloat(1+i)
                }
                
            } else {
                
                DispatchQueue.main.async {
                    let imageView = self.newImageView()
                    imageView.image = self.viewModel.selectedImages.value[i]
                    
                    self.imageStackView.addArrangedSubview(imageView)
                    imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
                    let xPosition = self.view.frame.width * CGFloat(i)
                    imageView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.imageStackView.frame.height)
                    self.imageHorizontalScrollView.contentSize.width = self.view.frame.width * CGFloat(1+i) }
            }
        }
        DispatchQueue.main.async { self.view.bringSubviewToFront(self.imagePageControl) }
    }
    
    private func setupPageControl() {
        imagePageControl.numberOfPages = viewModel.selectedImages.value.count
        imagePageControl.currentPage = 0
    }
}

extension PhotoNoteViewController {
    private func newImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}

extension PhotoNoteViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = round(imageHorizontalScrollView.contentOffset.x / self.view.frame.width)
        imagePageControl.currentPage = Int(CGFloat(currentPage))
        scrollView.contentOffset.y = -scrollView.contentInset.top // block vertical scrolling
    }
}

extension PhotoNoteViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}

extension PhotoNoteViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presentNoteWritingScene()
    }
}

extension PhotoNoteViewController: AlertPresentable {
    var alertComponents: AlertComponents {
        let action = AlertActionComponent(title: "OK", handler: { _ in
            self.coordinator?.navigateToPhotoNoteList()
        })
        let alertComponents = AlertComponents(title: "Save! ✨", message: "Your behavior has been applied.", actions: [action])
        return alertComponents
    }
}
