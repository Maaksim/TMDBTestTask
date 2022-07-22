//
//  ConfigurationRequests.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 21.07.2022.
//

import Foundation

class ConfigurationRequest: APIService {

    func getConfigurations(params: HomePageEntity.Request.GetConfigurations, completion: @escaping (Result<HomePageEntity.Response.ConfigurationResponse, Error>) -> Void) {
        let url = APIEndpoints.baseURL + Requests.configuration
        
        httpClient.request(method: .get, url: url, params: params) { [weak self] (result) in
            guard let self = self else { return }
            self.handleResponseResult(result: result, responseModel: HomePageEntity.Response.ConfigurationResponse.self, completion: completion)
        }
    }
}
