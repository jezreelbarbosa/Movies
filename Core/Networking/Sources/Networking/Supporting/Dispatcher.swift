//
//  Dispatcher.swift
//  Networking
//
//  Created by Jezreel Barbosa on 21/01/22.
//

import Foundation

public class Dispatcher {

    // Properties

    var isMockedEnviroment: Bool

    // Lifecycle

    init(isMockedEnviroment: Bool = false) {
        self.isMockedEnviroment = isMockedEnviroment
    }

    // Functions

    @discardableResult
    func call(endpoint: TargetType, completion: @escaping TargetCompletion) -> URLSessionDataTask? {
        let fullPath = endpoint.baseURL + endpoint.path + joinedParameters(from: endpoint.parameters)
        let urlString = fullPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return nil
        }

        var request = URLRequest(url: url, cachePolicy: endpoint.cachePolicy)
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.body
        if let headers = endpoint.headers {
            headers.forEach { header in
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }

        let task = makeDataTask(request: request, completion: completion)
        task.resume()
        return task
    }

    func makeDataTask(request: URLRequest, completion: @escaping TargetCompletion) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestError(data, response, error)))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(.unknowError(data, response, error)))
                return
            }

            switch response.statusCode {
            case 200...299:
                completion(.success((data, response)))
            case 300...399:
                completion(.failure(.redirectionError(data, response)))
            case 400...499:
                completion(.failure(.clientError(data, response)))
            case 500...599:
                completion(.failure(.serverError(data, response)))
            default:
                completion(.failure(.unknowError(data, response, error)))
            }
        }
    }

    func joinedParameters(from parameters: [String: Any]?) -> String {
        guard let parameters = parameters else { return "" }
        return "/?" + parameters.map({ $0.key + "=" + "\($0.value)" }).joined(separator: "&")
    }

    func mockedResponse() {
        // TODO: mocked response
    }
}
