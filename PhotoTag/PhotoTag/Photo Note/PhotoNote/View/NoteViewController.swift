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
        noteTextView.becomeFirstResponder() // open keyboard
        setupNoteTextView()
    }
    
    private func setupNoteTextView() {
        noteTextView.delegate = self
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        sendNotification()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func sendNotification() {
        let dataToSend = [NoteViewController.contentTextKey : contentText]
        NotificationCenter.default.post(name: .writeNote, object: nil, userInfo: dataToSend)
    }
    
}

extension NoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        // save content text string value for passing data
        contentText = textView.text
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        contentText = textView.text
    }
    func textViewDidChange(_ textView: UITextView) {
        contentText = textView.text
    }
}
