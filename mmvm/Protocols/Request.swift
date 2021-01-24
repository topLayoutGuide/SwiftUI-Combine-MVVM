//
//  Request.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/20.
//

import Foundation

protocol Request {
    // Every request should have a decodable response, even if it's an empty JSON body!
    associatedtype Response: Decodable

    // Most requests will also have a path. Supply an empty string if there's no subpath.
    var path: String { get }

    // If you want any?query=items&on=the&url=then define them in this object.
    var queryItems: [URLQueryItem]? { get }
}
