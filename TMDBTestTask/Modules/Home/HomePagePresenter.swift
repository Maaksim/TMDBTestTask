//
//  HomePagePresenter.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 20.07.2022.
//  Copyright (c) 2022 Lampa. All rights reserved.

import Foundation

protocol HomePagePresenterProtocol {
    func showLoader(_ isNeedShow: Bool)
    func configureMovies(items: [HomePageEntity.Response.MovieResult])
    func setupFavorite(items: [MovieInfoEntity])
    func saveAppConfigurations(_ config: HomePageEntity.Response.ConfigurationResponse)
    func showError(_ message: String)
}

class HomePagePresenter: HomePagePresenterProtocol {
    private unowned let view: HomePageViewControllerProtocol
    
    required init(view: HomePageViewControllerProtocol) {
        self.view = view
    }
    
    func showLoader(_ isNeedShow: Bool) {
        view.showLoader(isNeedShow)
    }
    
    func configureMovies(items: [HomePageEntity.Response.MovieResult]) {
        let baseImageUrl = UserDefaultsHelper.getBaseImageUrl() ?? ""
        let posterSize: PosterSizes = UserDefaultsHelper.getPosterSizes()?.first(where: { $0 == .w780 }) ?? .original
        let backdropSize: BackdropSizes = UserDefaultsHelper.getBackdropSizes()?.first(where: { $0 == .w1280 }) ?? .original
        var viewItems: [MovieInfoEntity] = []

        items.forEach { item in
            let posterPath = item.posterPath ?? ""
            let posterFullPath = baseImageUrl + posterSize.rawValue + posterPath
            
            let backdropPath = item.backdropPath ?? ""
            let backdropFullPath = baseImageUrl + backdropSize.rawValue + backdropPath

            let viewItem = MovieInfoEntity(id: item.id,
                                           title: item.title,
                                           description: item.overview,
                                           posterPath: posterFullPath,
                                           backdropPath: backdropFullPath,
                                           releaseDate: item.releaseDate)
            viewItems.append(viewItem)
        }
        
        self.view.setupMovies(viewItems)
    }
    
    func setupFavorite(items: [MovieInfoEntity]) {
        self.view.setupMovies(items)
    }
    
    func saveAppConfigurations(_ config: HomePageEntity.Response.ConfigurationResponse) {
        UserDefaultsHelper.saveBaseImageUrl(config.images?.baseURL)
        UserDefaultsHelper.savePosterSizes(config.images?.posterSizes ?? [])
        UserDefaultsHelper.saveBackdropSizes(config.images?.backdropSizes ?? [])
    }
    
    func showError(_ message: String) {
        view.showError(message)
    }
}
