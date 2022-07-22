//
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import Foundation

protocol JSONParserServiceProtocol {
    func parseJSON<T: Codable>(of type: T.Type, from data: Data, completion: @escaping (Result<T, Error>) -> Void)
}

class JSONParserService: JSONParserServiceProtocol {
    func parseJSON<T>(of type: T.Type, from data: Data, completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        do {
            let response: T = try JSONDecoder().decode(T.self, from: data)
            completion(.success(response))
        } catch let error {
            completion(.failure(error))
        }
    }
}
