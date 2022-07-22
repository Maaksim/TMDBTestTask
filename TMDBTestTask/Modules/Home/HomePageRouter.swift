//
//  HomePageRouter.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 20.07.2022.
//  Copyright (c) 2022 Lampa. All rights reserved.

import UIKit

protocol HomePageRouterProtocol: AnyObject {
    func showEndPage(with model: MovieInfoEntity)
    func showErrorDialog(with message: String)
}

class HomePageRouter: HomePageRouterProtocol {
    private unowned let view: UIViewController
    private unowned let dataStore: HomePageDataStore
    
    required init(view: UIViewController, interactor: HomePageDataStore) {
        self.view = view
        self.dataStore = interactor
    }
    
    func showEndPage(with model: MovieInfoEntity) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let vc = MovieEndPageViewController.builder.default(model: model)
            vc.updateFavoritesHandler = self.dataStore.updatedHandler
            self.view.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showErrorDialog(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.view.present(alert, animated: true, completion: nil)
        }
    }
}
