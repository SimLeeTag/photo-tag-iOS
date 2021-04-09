//
//  PhotoNoteListViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/26.
//

import UIKit

final class PhotoNoteListViewController: UIViewController {
    
    weak var coordinator: PhotoNoteCoordinator? // show tag category create new note
    private let viewModel: PhotoNoteListViewModel
    private let dataSource: PhotoNoteListTableViewDataSource
    private var photoNoteListView: PhotoNoteListView! {
        return view as? PhotoNoteListView
    }
    
    // MARK: - Intialization
    init(coordinator: PhotoNoteCoordinator, viewModel: PhotoNoteListViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.dataSource = PhotoNoteListTableViewDataSource()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = PhotoNoteListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: - request data from API
        self.modalPresentationStyle = .fullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchNoteListData()
    }
    
    // MARK: - Functions
    private func configure () {
        hideNavigationBar()
        photoNoteListView.photoNoteListTableView.delegate = self
        photoNoteListView.photoNoteListTableView.dataSource = dataSource
        photoNoteListView.delegate = self
    }
    
    private func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func navigateToTagCategory() {
        navigationController?.popViewController(animated: true)
    }
    
    private func navigateToSelectPhoto() {
        coordinator?.navigateToSelectPhoto()
    }
    
    // fetch data and put each data in viewmodel properties
    private func fetchNoteListData() {
        viewModel.fetchPhotoNoteList() { [weak self] photoNoteList in
            guard let noteList = photoNoteList else { return }
            self?.dataSource.noteList = noteList
            DispatchQueue.main.async {
                self?.photoNoteListView.photoNoteListTableView.reloadData()
            }
        }
    }
}

extension PhotoNoteListViewController: PhotoNoteListViewDelegate {
    
    func leftSwipeDidBegin(_ photoNoteListView: PhotoNoteListView) {
        navigateToSelectPhoto()
    }
    
    func rightSwipeDidBegin(_ photoNoteListView: PhotoNoteListView) {
        navigateToTagCategory()
    }
}

extension PhotoNoteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - request data from API and pass data through coordinator
        guard let cell = tableView.cellForRow(at: indexPath) as? NoteListCell else { return }
        coordinator?.navigateToPhotoNote(noteId: cell.noteId, isCreatingMode: .reading)
    }
}
