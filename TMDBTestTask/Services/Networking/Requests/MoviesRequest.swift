//
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import Foundation

 class MoviesRequest: APIService {

     func getPopularMovies(params: HomePageEntity.Request.GetPopularMovies, completion: @escaping (Result<HomePageEntity.Response.PopularMoviesResponse, Error>) -> Void) {
         let url = APIEndpoints.baseURL + Requests.popularMovies
         
         httpClient.request(method: .get, url: url, params: params) { [weak self] (result) in
             guard let self = self else { return }
             self.handleResponseResult(result: result, responseModel: HomePageEntity.Response.PopularMoviesResponse.self, completion: completion)
         }
     }
     
     func getNowPlaying(params: HomePageEntity.Request.GetCurrentlyBroadcastedMovies, completion: @escaping (Result<HomePageEntity.Response.PopularMoviesResponse, Error>) -> Void) {
         let url = APIEndpoints.baseURL + Requests.nowPlaying
         
         httpClient.request(method: .get, url: url, params: params) { [weak self] (result) in
             guard let self = self else { return }
             self.handleResponseResult(result: result, responseModel: HomePageEntity.Response.PopularMoviesResponse.self, completion: completion)
         }
     }
 }
