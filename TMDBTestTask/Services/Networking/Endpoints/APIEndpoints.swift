//
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import Foundation

struct APIEndpoints {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let apiKey = "2c46288716a18fb7aadcc2a801f3fc6b"
}

struct Requests {
    static let popularMovies = "movie/popular"
    static let nowPlaying = "movie/now_playing"
    static let configuration = "configuration"
}
