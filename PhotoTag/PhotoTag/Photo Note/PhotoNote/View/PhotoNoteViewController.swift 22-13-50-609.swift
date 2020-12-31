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
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    
    init(coordinator: PhotoNoteCoordinator, viewModel: PhotoNoteViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        noteTextView.isEditable = false
        displayPhotos()
        displayDate()
    }
    
    private func displayDate() {
        if viewModel.date == nil {
            dateLabel.isHidden = true
        }
    }
    
    private func displayPhotos() {
        var images = (firstImage: viewModel.passImages().0,
                      secondToLastImage: viewModel.passImages().1)
        firstImageView.image = images.firstImage
        
        for image in images.secondToLastImage {
            let imageView = newImageView()
            imageView.image = image
            imageStackView.addArrangedSubview(imageView)
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
    }
    
    @IBAction func moreButtonTapped(_ sender: Any) {
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
}
extension PhotoNoteViewController {
    private func newImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        return imageView
    }
}
