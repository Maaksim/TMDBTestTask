//
//  HomePageModels.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 20.07.2022.
//  Copyright (c) 2022 Lampa. All rights reserved.

import Foundation

enum HomePageEntity {
    
    struct Request {
        struct GetPopularMovies: Codable {
            let apiKey: String = APIEndpoints.apiKey
            let page: Int
            
            enum CodingKeys: String, CodingKey {
                case apiKey = "api_key"
                case page = "page"
            }
        }
        
        struct GetCurrentlyBroadcastedMovies: Codable {
            let apiKey: String = APIEndpoints.apiKey
            let page: Int
            
            enum CodingKeys: String, CodingKey {
                case apiKey = "api_key"
                case page = "page"
            }
        }
        
        struct GetConfigurations: Codable {
            let apiKey: String = APIEndpoints.apiKey
            
            enum CodingKeys: String, CodingKey {
                case apiKey = "api_key"
            }
        }
    }
    
    struct Response {
        struct PopularMoviesResponse: BaseModelProtocol {
            let page: Int?
            let results: [MovieResult]?
            let totalPages, totalResults: Int?

            enum CodingKeys: String, CodingKey {
                case page, results
                case totalPages = "total_pages"
                case totalResults = "total_results"
            }
        }
        
        struct MovieResult: Codable {
            let adult: Bool?
            let backdropPath: String?
            let genreIDS: [Int]?
            let id: Int?
            let originalLanguage: String?
            let originalTitle, overview: String?
            let popularity: Double?
            let posterPath, releaseDate, title: String?
            let video: Bool?
            let voteAverage: Double?
            let voteCount: Int?

            enum CodingKeys: String, CodingKey {
                case adult
                case backdropPath = "backdrop_path"
                case genreIDS = "genre_ids"
                case id
                case originalLanguage = "original_language"
                case originalTitle = "original_title"
                case overview, popularity
                case posterPath = "poster_path"
                case releaseDate = "release_date"
                case title, video
                case voteAverage = "vote_average"
                case voteCount = "vote_count"
            }
        }
        
        struct ConfigurationResponse: Codable {
            let images: ImagesSettings?
            let changeKeys: [String]?

            enum CodingKeys: String, CodingKey {
                case images
                case changeKeys = "change_keys"
            }
        }

        // MARK: - Images
        struct ImagesSettings: Codable {
            let baseURL: String?
            let secureBaseURL: String?
            let logoSizes, profileSizes: [String]?
            let stillSizes: [String]?
            let posterSizes: [PosterSizes]?
            let backdropSizes: [BackdropSizes]?
            
            enum CodingKeys: String, CodingKey {
                case baseURL = "base_url"
                case secureBaseURL = "secure_base_url"
                case backdropSizes = "backdrop_sizes"
                case logoSizes = "logo_sizes"
                case posterSizes = "poster_sizes"
                case profileSizes = "profile_sizes"
                case stillSizes = "still_sizes"
            }
        }
    }
    
    struct View {
    }
    
    enum HomeScreenType: Int, CaseIterable {
        case popular = 0
        case nowPlaying
        case favorites
    }
}
