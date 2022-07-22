//
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import UIKit

protocol HTTPClientProvider {
    func request(method: HTTPClient.RequestType, url: String, params: Any?, completion: @escaping (Result<Data, Error>) -> Void)
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

final class HTTPClient: HTTPClientProvider {
        
    init(session: URLSessionProtocol? = nil) {
        let delegateQueue = OperationQueue()
        delegateQueue.qualityOfService = .userInteractive
        delegateQueue.maxConcurrentOperationCount = 1
        
        self.urlSession = session ?? URLSession.init(configuration: .default, delegate: nil, delegateQueue: delegateQueue)
    }
        
    let jsonParser: JSONParserServiceProtocol = JSONParserService()
            
    private let urlSession: URLSessionProtocol
    
    enum RequestType: String {
        case post = "POST"
        case put = "PUT"
        case get = "GET"
        case delete = "DELETE"
    }

    func request(method: HTTPClient.RequestType, url: String, params: Any?, completion: @escaping (Result<Data, Error>) -> Void) {
        var parameters: [String: Any] = [:]
        
        switch params {
        case let data as [String: Any]:
            parameters = data
        case let data as Codable:
            parameters = data.convertToParameters
        default: break
        }
        
        var urlRequest: URLRequest?
                
        switch method {
        case .get:
            let urlWithQuery = url + parameters.queryItems()
            urlRequest = createRequest(method: .get, url: urlWithQuery)
        default:
            urlRequest = createRequest(method: method, url: url, params: parameters)
        }

        performRequest(urlRequest, completion: completion)
    }
    
    private func performRequest(_ urlRequest: URLRequest?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = urlRequest else {
            return completion(.failure(HTTPClientError.emptyURL(message: "Empty URL")))
        }
                
        let dataTask = urlSession.dataTask(request: request) { (data, response, error) in
            if let error = error {
                let errorType = error as NSError
                
                switch errorType.code {
                case NSURLErrorCancelled:
                    break
                default:
                    completion(.failure(error))
                }
            } else if let data = data, let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    completion(.success(data))
                default:
                    completion(.failure(HTTPClientError.responseStatusError(message: "Response status code: \(response.statusCode)")))
                }
            } else {
                completion(.failure(HTTPClientError.responseStatusError(message: "Server error")))
            }
        }
        
        dataTask.resume()
    }
        
    private func createRequest(method: HTTPClient.RequestType, url: String, params: [String: Any] = [:]) -> URLRequest? {
        let link: URL? = URL(string: url.replacingOccurrences(of: " ", with: "%20"))
        
        guard let url = link else {  return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if !params.isEmpty {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        return request
    }
}

extension URLSession: URLSessionProtocol {
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
    
}

extension Encodable {
    var convertToParameters: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        let jsonObject = (try? (JSONSerialization.jsonObject(with: data, options: []))).flatMap { $0 as? [String: Any] } ?? [:]
        var jsonObjectString: [String: Any] = [:]

        for item in jsonObject {
            
            switch item.value {
            case let array as NSArray: jsonObjectString[item.key] = array.count > 0 ? array : ""
            case let dict as NSDictionary: jsonObjectString[item.key] = dict.count > 0 ? dict : ""
            default: jsonObjectString[item.key] = String(describing: item.value)
            }
        }
        
        return jsonObjectString
    }
}

extension Dictionary {
    fileprivate func queryItems() -> String {
        guard let dic = self as? [String: Any] else { return "" }
        
        var components = URLComponents()
        components.queryItems = dic.map {
            URLQueryItem(name: $0, value: String(describing: $1))
        }
        
        let customAllowedSet = CharacterSet.init(charactersIn: "_+-").inverted
        return components.url?.absoluteString.addingPercentEncoding(withAllowedCharacters: customAllowedSet) ?? ""
    }
}
