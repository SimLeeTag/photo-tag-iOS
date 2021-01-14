//
//  NoteViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/02.
//

import UIKit

final class NoteViewController: UIViewController {
    
    @IBOutlet weak var noteTextView: UITextView!
    weak var coordinator: PhotoNoteCoordinator?
    static let contentTextKey = "contentText"
    private var contentText: String = ""
    private var existingText = ""
    
    init(coordinator: PhotoNoteCoordinator, with text: String) {
        self.coordinator = coordinator
        self.existingText = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        noteTextView.text = contentText
        noteTextView.text = existingText
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
        let maximumCount = 1000
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= maximumCount
    }
}
