//
//  HomePageViewController.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 20.07.2022.
//  Copyright (c) 2022 Lampa. All rights reserved.
//

import UIKit

protocol HomePageViewControllerProtocol: AnyObject {
    func setupMovies(_ movies: [MovieInfoEntity])
    func showLoader(_ isNeedShow: Bool)
    func openEndPage(with model: MovieInfoEntity)
    func showError(_ message: String)
}

class HomePageViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var emptyResultsLabel: UILabel!
    
    // MARK: - Properties
    static let builder = HomePageBuilder()
    private var interactor: HomePageInteractorProtocol!
    private var router: HomePageRouterProtocol!
    
    private let refreshControl = UIRefreshControl()
    private var dataSource: HomeDataSource = HomeDataSource()
    
    // MARK: - Setup
    func initialSetup(interactor: HomePageInteractorProtocol, router: HomePageRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setupRefreshControl()
        setupTableView()
        setupDataSource()
        setupSegmentedControl()
        interactor.getData()
    }
    
    private func setupNavigationView() {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.text = "Movies"
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.barTintColor = UIColor(named: "mainBlue")
    }
    
    private func setupSegmentedControl() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    private func setupTableView() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.addSubview(refreshControl)

        tableView.register(MoveTableViewCell.self)
     }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = UIColor(named: "secondaryColor")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    private func setupDataSource() {
        dataSource.paginationHandler = { [weak self] in
            guard let self = self else { return }
            self.interactor.getNextPage()
        }
        
        dataSource.didItemSelect = { [weak self] model in
            guard let self = self else { return }
            self.router.showEndPage(with: model)
        }
    }
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func showEmptyResults() {
        DispatchQueue.main.async {
            self.emptyResultsLabel.isHidden = false
            self.emptyResultsLabel.text = "There aren't any results."
        }
    }
    
    private func hideEmptyResults() {
        DispatchQueue.main.async {
            self.emptyResultsLabel.isHidden = true
            self.emptyResultsLabel.text = nil
        }
    }
    
    private func scrollToTop() {
        guard tableView.numberOfRows(inSection: 0) > 0 else { return }
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    // MARK: - @objc funcs
    @objc func refresh(_ sender: AnyObject) {
        interactor.refreshData()
    }
    
    // MARK: - @IBAction funcs
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        guard let type = HomePageEntity.HomeScreenType(rawValue: sender.selectedSegmentIndex) else { return }
        scrollToTop()
        interactor.changedType(type)
    }
}

extension HomePageViewController: HomePageViewControllerProtocol {
    func setupMovies(_ movies: [MovieInfoEntity]) {
        dataSource.movies = movies
        dataSource.isNeedPagination = !movies.isEmpty
        reloadTable()
        
        movies.isEmpty ? showEmptyResults(): hideEmptyResults()
    }

    func showLoader(_ isNeedShow: Bool) {
        DispatchQueue.main.async {
            if isNeedShow {
                self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
                self.tableView.isHidden = true
            } else {
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.tableView.isHidden = false
            }
        }
    }
    
    func openEndPage(with model: MovieInfoEntity) {
        router.showEndPage(with: model)
    }
    
    func showError(_ message: String) {
        router.showErrorDialog(with: message)
    }
}
