//
//  NoteViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/02.
//

import UIKit

final class NoteViewController: UIViewController {
    
    @IBOutlet weak var noteTextView: UITextView!
    private let noteNetworkingManager = NoteNetworkingManager()
    weak var coordinator: PhotoNoteCoordinator?
    static let contentTextKey = "contentText"
    private var contentText: NoteText = ""
    private var existingText = ""
    private var photos: [NoteImage]
    
    init(coordinator: PhotoNoteCoordinator, with text: NoteText, and photos: [NoteImage]) {
        self.coordinator = coordinator
        self.existingText = text
        self.photos = photos
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        showTagRecommendation()
    }
    
    @objc func tagTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.title(for: .normal) else { return }
        DispatchQueue.main.async {
            self.contentText += buttonTitle
            self.noteTextView.text += buttonTitle
        }
    }
    
    private func showTagRecommendation() {
        
        fetchTagRecommendation { tagSuggestions in
            for tag in tagSuggestions {
                let tagButton =  self.tagButton(title: "#\(tag)")
                self.tagStackView.addArrangedSubview(tagButton)
            }
            let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            scrollView.contentSize = CGSize(width: self.tagStackView.frame.width, height: self.tagStackView.frame.height)
            scrollView.addSubview(self.tagStackView)
            scrollView.sizeToFit()
            self.noteTextView.inputAccessoryView = scrollView
        }
        
    }
    
    private func fetchTagRecommendation( completionHandler: @escaping ([TagName]) -> Void) {
        noteNetworkingManager.fetchTagRecommendation(images: photos) { tagSuggestion in
            var tagSuggestions: [TagName] = []
            tagSuggestions.append(contentsOf: tagSuggestion.tagsEn)
            tagSuggestions.append(contentsOf: tagSuggestion.tagsKr)
            completionHandler(tagSuggestions)
        }
    }
    
    private func setupView() {
        noteTextView.text = contentText
        noteTextView.text = existingText
        noteTextView.becomeFirstResponder()
        noteTextView.keyboardAppearance = .dark
        setupNoteTextView()
    }
    
    private func setupNoteTextView() {
        noteTextView.delegate = self
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        sendNotification()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func sendNotification() {
        let dataToSend = [NoteViewController.contentTextKey: contentText]
        NotificationCenter.default.post(name: .writeNote,
                                        object: nil,
                                        userInfo: dataToSend)
    }
    
}

extension NoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        contentText = textView.text // save content text string value for passing data
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        contentText = textView.text
    }
    func textViewDidChange(_ textView: UITextView) {
        contentText = textView.text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let maximumCount = 500
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= maximumCount
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
}

extension NoteViewController {
    private var tagStackView: UIStackView {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        stackView.axis = .horizontal
        stackView.sizeToFit()
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.backgroundColor = .lightGray
        stackView.contentMode = .scaleToFill
        stackView.clipsToBounds = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func tagButton(title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("#\(title)", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: button.intrinsicContentSize.width + 18, height: 50)
        button.addTarget(self, action: #selector(self.tagTapped), for: .touchUpInside)
        self.tagStackView.addArrangedSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
