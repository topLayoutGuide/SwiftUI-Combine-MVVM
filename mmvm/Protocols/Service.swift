//
//  Service.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/20.
//

import SwiftUI
import Combine

protocol Service {
    // All my API-calling services will have inputs
    // The inputs will represent callable endpoints
    associatedtype Input: Equatable

    // Every API has a base URL, so let's make sure our concrete implementation of a "service" also has one.
    var baseURLString: String { get }
    var cancellables: [AnyCancellable] { get }

    // We need a function to apply our inputs
    func apply(input: Input)

    // We also need a function to request our data and return the desired response.
    func response<R>(from request: R) -> AnyPublisher<R.Response, ServiceError> where R: Request
}

extension Service {

    /// Get the API Response
    /// - Parameter request: The request to use
    /// - Returns: The response defined by the request
    func response<R>(from request: R) -> AnyPublisher<R.Response, ServiceError> where R: Request {
        // If we can't build the URLs, let's fail our Publisher with an error.
        guard let relativeToURL = URL(string: baseURLString),
              let pathURL = URL(string: request.path, relativeTo: relativeToURL) else {
            return Fail(error: ServiceError.requestError)
                .eraseToAnyPublisher()
        }

        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = request.queryItems

        guard let url = urlComponents?.url else {
            return Fail(error: ServiceError.requestError)
                .eraseToAnyPublisher()
        }

        // Assuming (the root of all evil with programming!!) that the response will be JSON.
        // Always check this in the API documentation! (if it exists!)
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Some APIs love to define properties_like_this which is annoying, so I try to convertToCamelCase.
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // Lastly, return our data!
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, urlResponse in data }
            // Map any errors here to a responseError, because that's the type of error that's happening now.
            .mapError { _ in ServiceError.responseError }
            // Decode the response into our request response
            .decode(type: R.Response.self, decoder: decoder)
            // Map any errors to parseError...because we cannot parse our response. This may be due to a typo, or a missing field...
            .mapError(ServiceError.parseError)
            // Receive on global queue, and erase the type to AnyPublisher.
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
