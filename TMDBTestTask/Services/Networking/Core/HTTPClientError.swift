//
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import Foundation

enum HTTPClientError: Error {
    case emptyURL(message: String)
    case responseStatusError(message: String)
}

extension HTTPClientError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .responseStatusError(message):
            return "\(message)"
        case let .emptyURL(message):
            return "\(message)"
        }
    }
}
