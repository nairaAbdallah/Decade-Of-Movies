//
//  SearchViewController.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

class SearchViewController: UIViewController, Storyboarded {
    // MARK: - Properties
    internal lazy var coordinator: MainCoordinator? = {
        return MainCoordinator()
    }()
    internal lazy var searchVM: SearchViewModel = {
        return SearchViewModel(delegate: self)
    }()
    // MARK: - Identifiers
    internal let headerId = SearchHeaderTableViewCell.identifier
    internal let masterId = SearchTableViewCell.identifier
    // MARK: - IBOutlet
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTF.becomeFirstResponder()
    }
}
// MARK: - SetUpView
extension SearchViewController {
    private func setUpView() {
        innerNavigation(for: "Search")
        searchVM.getMovies()
        setUpSearch()
        setUpTableView()
    }
}

// MARK: - SetUp tableView
extension SearchViewController {
    private func setUpTableView() {
        let adjustTabBar = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = adjustTabBar
        tableView.scrollIndicatorInsets = adjustTabBar
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.sectionHeaderTopPadding = 0.0
        tableView.isHidden = true
        //MARK: - Register cells
        registerCells()
    }
    private func registerCells() {
        [headerId, masterId].forEach { id in
            tableView.register(UINib(nibName: id, bundle: nil),
                               forCellReuseIdentifier: id)
        }
    }
}
// MARK: - Implement protocol
extension SearchViewController: SearchProtocol {
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
    var reloadTableView: ((Bool) -> Void)? {
        return { [weak self] isHidden in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                tableView.reloadData()
                tableView.isHidden = isHidden
            }
        }
    }
}
// MARK: - Coordinator
extension SearchViewController {
    func navToDetails(for movie: MasterDataViewModel?) {
        let details = coordinator?.navToController(controller: DetailsViewController(),
                                                   navControl: navigationController,
                                                   storyboard: Storyboard.details)
        details?.movie = movie
    }
}

