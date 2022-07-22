//
//  HomePageInteractor.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 20.07.2022.
//  Copyright (c) 2022 Lampa. All rights reserved.

import Foundation

protocol HomePageInteractorProtocol {
    func getData()
    func getNextPage()
    func changedType(_ type: HomePageEntity.HomeScreenType)
    func refreshData()
}

protocol HomePageDataStore: AnyObject {
    var updatedHandler: (() -> Void)? { get }
}

class HomePageInteractor: HomePageInteractorProtocol, HomePageDataStore {
    private let presenter: HomePagePresenterProtocol?
    private let moviesApi = MoviesRequest()
    private let configurationApi = ConfigurationRequest()

    private let defaultStartPage: Int = 1
    private var currentScreenType: HomePageEntity.HomeScreenType = .popular
    private var currentPage: Int = 1
    private var items: [HomePageEntity.Response.MovieResult] = []
    
    var updatedHandler: (() -> Void)?

    required init(presenter: HomePagePresenterProtocol) {
        self.presenter = presenter
        self.setupUpdatedHandler()
    }
    
    func getData() {
        let dispatchGroup = DispatchGroup()
        
        presenter?.showLoader(true)

        dispatchGroup.enter()
        getConfigurations() {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getNextMovies() {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .global(), execute: { [weak self] in
            guard let self = self else { return }
            self.presenter?.showLoader(false)
            self.presenter?.configureMovies(items: self.items)
        })
    }
    
    func getNextPage() {
        currentPage += 1
        getNextMovies()
    }
    
    func changedType(_ type: HomePageEntity.HomeScreenType) {
        currentScreenType = type
        refreshData()
    }
    
    func refreshData() {
        items.removeAll()
        currentPage = defaultStartPage
        presenter?.showLoader(true)
        
        getNextMovies {  [weak self] in
            guard let self = self else { return }
            self.presenter?.showLoader(false)
        }
    }
    
    private func setupUpdatedHandler() {
        updatedHandler = { [weak self] in
            guard let self = self else { return }
           
            switch self.currentScreenType {
            case .favorites:
                self.refreshData()
            default:
                break
            }
        }
    }
    
    private func getNextMovies(completion: (() -> Void)? = nil) {
        switch currentScreenType {
        case .popular:
            getPopularMovies(page: currentPage) { [weak self] in
                guard let self = self else { return }
                self.presenter?.configureMovies(items: self.items)
                completion?()
            }
        case .nowPlaying:
            getNowPlaying(page: currentPage) { [weak self] in
                guard let self = self else { return }
                self.presenter?.configureMovies(items: self.items)
                completion?()
            }
        case .favorites:
            let allFavorites = UserDefaultsHelper.getFavorites() ?? []
            presenter?.setupFavorite(items: allFavorites)
            completion?()
        }
    }
    
    private func getPopularMovies(page: Int, completion: (() -> Void)?) {
        let params: HomePageEntity.Request.GetPopularMovies = HomePageEntity.Request.GetPopularMovies(page: page)
        
        moviesApi.getPopularMovies(params: params) { [weak self] response in
            guard let self = self else {return}
            
            switch response {
            case .success(let result):
                self.items.append(contentsOf: result.results ?? [])
            case .failure(let error):
                self.presenter?.showError(error.localizedDescription)
            }
            
            completion?()
        }
    }
    
    private func getNowPlaying(page: Int, completion: (() -> Void)?) {
        let params: HomePageEntity.Request.GetCurrentlyBroadcastedMovies = HomePageEntity.Request.GetCurrentlyBroadcastedMovies(page: page)
        
        moviesApi.getNowPlaying(params: params) { [weak self] response in
            guard let self = self else {return}
            
            switch response {
            case .success(let result):
                self.items.append(contentsOf: result.results ?? [])
            case .failure(let error):
                self.presenter?.showError(error.localizedDescription)
            }
            
            completion?()
        }
    }
    
    private func getConfigurations(completion: (() -> Void)?) {
        let params: HomePageEntity.Request.GetConfigurations = HomePageEntity.Request.GetConfigurations()
        
        configurationApi.getConfigurations(params: params) { [weak self] response in
            guard let self = self else {return}
            
            switch response {
            case .success(let result):
                self.presenter?.saveAppConfigurations(result)
            case .failure(let error):
                self.presenter?.showError(error.localizedDescription)
            }
            
            completion?()
        }
    }
}
