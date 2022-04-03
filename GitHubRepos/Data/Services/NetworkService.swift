//
//  NetworkService.swift
//  GitHubRepos
//
//  Created by Marko Matijević on 03.04.2022..
//

import Foundation
import RxSwift
import RxCocoa

enum RequestType: String {
    case GET, PUT, POST, DELETE
}

enum NetworkError: Error {
    case badURL, requestFailed, fileTooLarge, unknown

    var description : String {
        switch self {
        case .badURL: return "Bad URL."
        case .requestFailed: return "Request Failed."
        case .fileTooLarge: return "File too large."
        case .unknown: return "Unknown error."
        }
  }
}

struct EmptyRequestBody: Encodable {
    
}

struct Resources<T: Decodable, P: Encodable> {
    let path: String
    let requestType: RequestType
    let bodyParameters: P?
    let httpHeaderFields: [String : String]?
    var queryParameters: [String : Codable]?
}

class NetworkService {
    
    public func performRequest<T: Decodable, P: Encodable>(resources: Resources<T, P>, retryCount: Int) -> Observable<T> {
       
        guard let url = getUrl(path: resources.path, queryParameters: resources.queryParameters) else {
            return Observable.error(NetworkError.badURL)
        }
        return Observable
            .just(url)
            .flatMap{url -> Observable<(response: HTTPURLResponse, data: Data)> in
                var request = URLRequest(url: url)
                
                if let bodyParameters = resources.bodyParameters {
                    let jsonData = try? JSONEncoder().encode(bodyParameters)
                    request.httpBody = jsonData
                }
                
                if let headerFields = resources.httpHeaderFields {
                    request.allHTTPHeaderFields = headerFields
                }
                
                request.httpMethod = resources.requestType.rawValue
                request.addValue("application/json", forHTTPHeaderField:
                              "Content-Type")
                return URLSession.shared.rx.response(request: request)
            }.map { response, data -> T in
                if 200..<300 ~= response.statusCode {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        return try decoder.decode(T.self, from: data)
                    } catch {
                        throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                    }
                }
                throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
            }.observeOn(MainScheduler.instance)
            .retry(retryCount)
            .asObservable()
    }
    
    private func getUrl(path: String, queryParameters: [String : Codable]?) -> URL? {
        let pathWithQueryParameters = addQueryParametersToPath(path: path, queryParameters: queryParameters)
        
        guard let url = URL(string: K.Networking.baseUrl + pathWithQueryParameters) else {
            return nil
        }
        return url
    }
    
    private func addQueryParametersToPath(path: String, queryParameters: [String : Codable]?) -> String {
        var newPath = path
        if let queryParameters = queryParameters {
            newPath.append("?")
            queryParameters.forEach { (key, value) in
                newPath = "\(newPath)\(key)=\(value)&"
            }
            newPath.removeLast()
        }
        return newPath
    }
    
}
