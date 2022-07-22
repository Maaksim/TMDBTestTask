//
//  MovieEndPagePresenter.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 21.07.2022.
//  Copyright (c) 2022 Lampa. All rights reserved.

import Foundation

protocol MovieEndPagePresenterProtocol {
    func setupData(with model: MovieInfoEntity)
}

class MovieEndPagePresenter: MovieEndPagePresenterProtocol {
    private unowned let view: MovieEndPageViewControllerProtocol
    
    required init(view: MovieEndPageViewControllerProtocol) {
        self.view = view
    }
    
    func setupData(with model: MovieInfoEntity) {
        view.setupData(with: model)
    }
}
