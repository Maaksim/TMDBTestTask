//
//  MovieEndPageRouter.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 21.07.2022.
//  Copyright (c) 2022 Lampa. All rights reserved.

import UIKit

protocol MovieEndPageRouterProtocol: AnyObject {
}

class MovieEndPageRouter: MovieEndPageRouterProtocol {
    private unowned let view: UIViewController
    private unowned let dataStore: MovieEndPageDataStore
    
    required init(view: UIViewController, interactor: MovieEndPageDataStore) {
        self.view = view
        self.dataStore = interactor
    }
}
