//
//  NoteViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/02.
//

import UIKit

protocol PassNoteDelegate: class {
    func passNoteText(content: String)
}

class NoteViewController: UIViewController {
    
    weak var delegate: PassNoteDelegate?
    private var contentText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        setupNavigationBar()
        setupNoteTextView()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.setLeftBarButton(cancelButton, animated: true)
        self.navigationItem.setRightBarButton(saveButton, animated: true)
    }
    
    private func setupNoteTextView() {
        noteTextView.delegate = self
        self.view.addSubview(noteTextView)
        noteTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        noteTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        noteTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        noteTextView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        // pass data to photo note view
        delegate?.passNoteText(content: contentText)
    }
}

extension NoteViewController {
    private var noteTextView: UITextView {
        let textView = UITextView()
        return textView
    }
    
    private var cancelButton: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
    }
    
    private var saveButton: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
}

extension NoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        // save content text string value for passing data
        contentText = textView.text
    }
    
    override func didChangeValue(forKey key: String) {
        // dealing with hashtag
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // keyboard
    }
}
