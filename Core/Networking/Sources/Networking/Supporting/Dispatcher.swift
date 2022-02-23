//
//  Dispatcher.swift
//  Networking
//
//  Created by Jezreel Barbosa on 21/01/22.
//

import Foundation

class Dispatcher {

    // Properties

    var isMockedEnviroment: Bool
    var mockedResponse: DispatcherMockResponse

    // Lifecycle

    init(isMockedEnviroment: Bool = false, mockedResponse: DispatcherMockResponse = .empty) {
        self.isMockedEnviroment = isMockedEnviroment
        self.mockedResponse = mockedResponse
    }

    // Functions

    @discardableResult
    func call(endpoint: TargetType, completion: @escaping TargetCompletion) -> URLSessionDataTask? {
        guard let request = makeURLRequest(endpoint: endpoint) else {
            completion(.failure(.urlError))
            return nil
        }

        guard !isMockedEnviroment else {
            mockedResponse(completion: completion)
            return nil
        }

        let task = makeDataTask(request: request, completion: completion)
        task.resume()
        return task
    }

    func makeURLRequest(endpoint: TargetType) -> URLRequest? {
        let fullPath = endpoint.baseURL + endpoint.path + joinedParameters(from: endpoint.parameters)
        let urlString = fullPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        guard let url = URL(string: urlString) else { return nil }

        var request = URLRequest(url: url, cachePolicy: endpoint.cachePolicy)
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.body
        if let headers = endpoint.headers {
            headers.forEach { header in
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }

        return request
    }

    func makeDataTask(request: URLRequest, completion: @escaping TargetCompletion) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            self?.handle(data: data, response: response, error: error, completion: completion)
        }
    }

    func handle(data: Data?, response: URLResponse?, error: Error?, completion: @escaping TargetCompletion) {
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

    func joinedParameters(from parameters: [String: Any]?) -> String {
        guard let parameters = parameters else { return "" }
        return "/?" + parameters.map({ $0.key + "=" + "\($0.value)" }).joined(separator: "&")
    }

    func mockedResponse(completion: @escaping TargetCompletion) {
        handle(data: mockedResponse.data, response: mockedResponse.response, error: mockedResponse.error, completion: completion)
    }
}
