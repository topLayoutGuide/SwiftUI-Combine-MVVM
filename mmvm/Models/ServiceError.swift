//
//  ServiceError.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/20.
//

import Foundation

enum ServiceError: Error {
    case requestError
    case responseError
    case parseError(Error)
}
