//
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import Foundation

class APIService {
    let httpClient: HTTPClientProvider
    let jsonParser: JSONParserServiceProtocol = JSONParserService() //
    
    init() {
        self.httpClient = HTTPClient()
    }
    
    func handleResponseResult<T: Codable>(result: Result<Data, Error>, responseModel: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        switch result {
        case .success(let data):
            self.jsonParser.parseJSON(of: responseModel.self, from: data) { (result) in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .failure(let error):
            completion(.failure(error))
        }
    }}
