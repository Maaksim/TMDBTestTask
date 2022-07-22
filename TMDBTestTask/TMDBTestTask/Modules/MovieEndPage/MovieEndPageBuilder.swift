//
//  MovieEndPageBuilder.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 21.07.2022.
//  Copyright (c) 2022 Lampa. All rights reserved.

import UIKit

struct MovieEndPageBuilder {
    typealias Controller = MovieEndPageViewController
    typealias Presenter = MovieEndPagePresenter
    
    func`default`(model: MovieInfoEntity) -> Controller {
        let vc = Controller.fromStoryboard
        let presenter = Presenter(view: vc)
        let interactor = MovieEndPageInteractor(presenter: presenter, model: model)
        let router = MovieEndPageRouter(view: vc, interactor: interactor)
        
        vc.initialSetup(interactor: interactor, router: router)
        return vc
    }
}
