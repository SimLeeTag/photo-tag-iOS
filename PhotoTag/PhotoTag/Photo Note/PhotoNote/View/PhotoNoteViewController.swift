//
//  PhotoNoteViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit
import YPImagePicker

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
    private var isCreating: Bool
    private var noteContentText: String = ""
    private let noteNetworkManager = NoteNetworkingManager()
    
    init(coordinator: PhotoNoteCoordinator, viewModel: PhotoNoteViewModel, isCreating: Bool) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.isCreating = isCreating
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNotification()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentNoteWritingScene))
        noteTextView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        // request to save data to API
        noteNetworkManager.createNote(with: noteContentText, images: viewModel.selectedImages) { success in
            if success {
                DispatchQueue.main.async {
                    self.presentAlert()
                }
            } else {
                print("failed")
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        coordinator?.navigateToPhotoNoteList()
    }
    
    private func setupView() {
        setupButtons()
        noteTextView.isEditable = false
        imageHorizontalScrollView.delegate = self
        setupPageControl()
        displayPhotos()
        displayDate()
        if isCreating {
            presentNoteWritingScene()
        }
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(saveNoteText), name: .writeNote, object: nil)
    }
    
    private func filterTags(content: String) {
        if !content.contains("#") {
            let noTagText = " #noTag"
            self.noteContentText += noTagText
        }
    }
    
    private func setupButtons() {
        moreButton.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
    }
    
    private func displayDate() {
        if viewModel.date == nil {
            dateLabel.isHidden = true
        }
    }
    
    private func displayPhotos() {
        
        for i in 0..<viewModel.selectedImages.count {
            
            let xPosition = self.view.frame.width * CGFloat(i)
            
            if i == 0 {
                firstImageView.image = viewModel.selectedImages[i]
                firstImageView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.imageStackView.frame.height)
                
                imageHorizontalScrollView.contentSize.width = self.view.frame.width * CGFloat(1+i)
            } else {
                
                let imageView = newImageView()
                imageView.image = viewModel.selectedImages[i]
                
                imageStackView.addArrangedSubview(imageView)
                imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
                
                imageView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.imageStackView.frame.height)
                imageHorizontalScrollView.contentSize.width = self.view.frame.width * CGFloat(1+i)
            }
        }
        self.view.bringSubviewToFront(imagePageControl)
    }
    
    private func setupPageControl() {
        imagePageControl.numberOfPages = viewModel.selectedImages.count
        imagePageControl.currentPage = 0
    }
    
    @objc private func presentNoteWritingScene() {
        if isCreating {
            coordinator?.navigateToWritePhotoNote(with: noteContentText)
        }
    }
    @objc func saveNoteText(_ notification: Notification) {
        guard let content = notification.userInfo?[NoteViewController.contentTextKey] as? String else { return }
        noteContentText = content // save passed text
        filterTags(content: content)
        updateTextViewWithText()
    }
    
    private func updateTextViewWithText() {
        DispatchQueue.main.async {
            self.noteTextView.text = self.noteContentText
        }
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
        let alertComponents = AlertComponents(title: "New Note! ✨", message: "New note has been created", actions: [action])
        return alertComponents
    }
}
