//
//  EmojiService.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/20.
//

import SwiftUI
import Combine

final class EmojiService: Service {

    // Conforming to the protocol reminds us that we need to define these.
    let baseURLString = "https://emoji-api.com"
    var cancellables: [AnyCancellable] = []

    // MARK: - Input

    let errorSubject = PassthroughSubject<ServiceError, Never>()

    // MARK: - Output

    @Published var error: ServiceError?

    // MARK: - Requests

    func loadAllEmoji() -> AnyPublisher<EmojiRequest.Response, Never> {
        return response(from: EmojiRequest())
            .catch { [weak self] error -> Empty<EmojiRequest.Response, Never> in
                self?.errorSubject.send(error)
                return .init()
            }
            .share()
            .eraseToAnyPublisher()
    }
}
