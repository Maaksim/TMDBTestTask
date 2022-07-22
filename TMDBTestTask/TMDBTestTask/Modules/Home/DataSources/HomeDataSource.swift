//
//  HomeDataSource.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 20.07.2022.
//

import UIKit

class HomeDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let countItemsBeforePagination: Int = 10
    private let cellHeight: CGFloat = 186
    
    var movies: [MovieInfoEntity]?
    var isNeedPagination: Bool = true

    var paginationHandler: (() -> Void)?
    var didItemSelect: ((MovieInfoEntity) -> Void)?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoveTableViewCell = tableView.dequeue(MoveTableViewCell.self, indexPath)
        
        if let count = movies?.count, indexPath.row < count {
            cell.display(model: movies?[indexPath.row])
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let moviesCount = movies?.count ?? 0
        
        if indexPath.row == (moviesCount - countItemsBeforePagination) && isNeedPagination {
            paginationHandler?()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = movies?[indexPath.row] {
            didItemSelect?(model)
        }
    }
}
