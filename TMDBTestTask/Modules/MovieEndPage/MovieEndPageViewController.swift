//
//  MovieEndPageViewController.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 21.07.2022.
//  Copyright (c) 2022 Lampa. All rights reserved.
//

import UIKit

protocol MovieEndPageViewControllerProtocol: AnyObject {
    func setupData(with model: MovieInfoEntity)
}

class MovieEndPageViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var favoriteImage: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    static let builder = MovieEndPageBuilder()
    private var interactor: MovieEndPageInteractorProtocol!
    private var router: MovieEndPageRouterProtocol!
    
    private let filledStarImage = UIImage(named: "filledStar")
    private let emptyStarImage = UIImage(named: "emptyStar")
    
    var updateFavoritesHandler: (() -> Void)?

    // MARK: - Setup
    func initialSetup(interactor: MovieEndPageInteractorProtocol, router: MovieEndPageRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        interactor.getData()
    }
    
    private func setupNavigationView() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "mainBlue")
    }
    
    private func setFavorite(_ isFavorite: Bool) {
        let image = isFavorite ? filledStarImage: emptyStarImage
        favoriteImage.image = image
        favoriteButton.isSelected = isFavorite
    }
    
    @IBAction func favoriteButtonClick(_ sender: UIButton) {
        setFavorite(!sender.isSelected)
        interactor.changeFavorite()
        updateFavoritesHandler?()
    }
}

extension MovieEndPageViewController: MovieEndPageViewControllerProtocol {
    func setupData(with model: MovieInfoEntity) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        releaseDateLabel.text = model.releaseDate
        
        let allFavorites = UserDefaultsHelper.getFavorites() ?? []
        setFavorite(allFavorites.contains(where: { $0.id == model.id }))
        
        if let path = model.backdropPath, let url = URL(string: path) {
            movieImage.setImage(from: url)
        }
    }
}
