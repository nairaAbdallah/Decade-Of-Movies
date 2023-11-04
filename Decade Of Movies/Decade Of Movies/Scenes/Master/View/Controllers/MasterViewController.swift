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
    internal let headerId = SearchHeaderTableViewCell.identifier
    internal let masterId = SearchTableViewCell.identifier
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    // MARK: - IBAction
    @IBAction func searchAction(_ sender: UIButton) {
        navToSearch()
    }
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        masterVM.getMovies()
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
// MARK: - SetUp tableView
extension MasterViewController {
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
    var reloadTableView: ((Bool) -> Void)? {
        return { [weak self] isHidden in
            guard let self = self else { return }
            tableView.reloadData()
            tableView.isHidden = isHidden
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
        let search = coordinator?.navToController(controller: SearchViewController(),
                                                   navControl: navigationController,
                                                   storyboard: Storyboard.search)
    }
}

