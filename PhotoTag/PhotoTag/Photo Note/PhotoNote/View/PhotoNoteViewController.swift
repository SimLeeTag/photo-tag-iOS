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
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var imageHorizontalScrollView: UIScrollView!
    private var isCreating: Bool
    
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
    }
    
    private func setupView() {
        moreButton.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 10
        noteTextView.isEditable = false
        imageHorizontalScrollView.delegate = self
        setupPageControl()
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
    
    private func presentNoteWritingScene() {
        
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
