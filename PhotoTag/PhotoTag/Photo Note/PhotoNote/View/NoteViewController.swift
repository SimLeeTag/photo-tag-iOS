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

final class NoteViewController: UIViewController {
    
    @IBOutlet weak var noteTextView: UITextView!
    weak var delegate: PassNoteDelegate?
    weak var coordinator: PhotoNoteCoordinator?
    private var contentText: String = ""
    
    init(coordinator: PhotoNoteCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        setupNoteTextView()
    }
    
    private func setupNoteTextView() {
        noteTextView.delegate = self
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        delegate?.passNoteText(content: contentText)
        self.dismiss(animated: true, completion: nil)
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
