//
//  MovieEndPageInteractor.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 21.07.2022.
//  Copyright (c) 2022 Lampa. All rights reserved.

import Foundation

protocol MovieEndPageInteractorProtocol {
    func getData()
    func changeFavorite()
}

protocol MovieEndPageDataStore: AnyObject {
}

class MovieEndPageInteractor: MovieEndPageInteractorProtocol, MovieEndPageDataStore {
    private let presenter: MovieEndPagePresenterProtocol?
    private let model: MovieInfoEntity
    
    required init(presenter: MovieEndPagePresenterProtocol, model: MovieInfoEntity) {
        self.presenter = presenter
        self.model = model
    }
    
    func getData() {
        presenter?.setupData(with: model)
    }
    
    func changeFavorite() {
        guard let id = model.id else { return }
        
        var allFavorites = UserDefaultsHelper.getFavorites() ?? []
        
        if allFavorites.contains(where: { $0.id == id }) {
            allFavorites.removeAll(where: { $0.id == id })
        } else {
            allFavorites.append(model)
        }
        
        UserDefaultsHelper.saveFavorites(allFavorites)
    }
}
