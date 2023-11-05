//
//  MasterViewController.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

class MasterViewController: UIViewController, Storyboarded {
    // MARK: - Properties
    internal lazy var coordinator: MainCoordinator? = {
        return MainCoordinator()
    }()
    internal lazy var masterVM: MasterViewModel = {
        return MasterViewModel(delegate: self)
    }()
    // MARK: - Identifiers
    internal let masterId = MasterCollectionViewCell.identifier
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - IBAction
    @IBAction func searchAction(_ sender: UIButton) {
        navToSearch()
    }
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        masterVM.getMovies()
        setupCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
// MARK: - SetUpCollectionView
extension MasterViewController {
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = masterVM.adjustTabBar
        collectionView.scrollIndicatorInsets = masterVM.adjustTabBar
        // Register cells
        collectionView.register(UINib(nibName: masterId, bundle: nil),
                                forCellWithReuseIdentifier: masterId)
        // casting is required because UICollectionViewLayout doesn't offer header pin.
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
    }
}
// MARK: - Implement protocol
extension MasterViewController: MasterProtocol {
    var updateLoadingStatus: ((State) -> Void)? {
        return { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                activityIndicator(activity: indicator)
            case .empty, .error:
                indicator.stopAnimating()
            default:
                indicator.stopAnimating()
            }
        }
    }
    var reloadCollectionView: ((Bool) -> Void)? {
        return { [weak self] isHidden in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                collectionView.reloadData()
                collectionView.isHidden = isHidden
            }
        }
    }
}
// MARK: - Coordinator
extension MasterViewController {
    func navToDetails(for movie: MasterDataViewModel?) {
        let details = coordinator?.navToController(controller: DetailsViewController(),
                                                   navControl: navigationController,
                                                   storyboard: Storyboard.details)
        details?.movie = movie
    }
    func navToSearch() {
        _ = coordinator?.navToController(controller: SearchViewController(),
                                         navControl: navigationController,
                                         storyboard: Storyboard.search)
    }
}

