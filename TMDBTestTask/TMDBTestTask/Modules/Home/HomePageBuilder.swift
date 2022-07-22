//
//  HomePageBuilder.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 20.07.2022.
//  Copyright (c) 2022 Lampa. All rights reserved.

import UIKit

struct HomePageBuilder {
    typealias Controller = HomePageViewController
    typealias Presenter = HomePagePresenter
    
    func`default`() -> Controller {
        let vc = Controller.fromStoryboard
        let presenter = Presenter(view: vc)
        let interactor = HomePageInteractor(presenter: presenter)
        let router = HomePageRouter(view: vc, interactor: interactor)
        
        vc.initialSetup(interactor: interactor, router: router)
        return vc
    }
}
