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

    // MARK: - Init

    init() {
        bind()
    }

    // MARK: - Input

    let loadAllEmojiSubject = PassthroughSubject<Void, Never>()
    let errorSubject = PassthroughSubject<ServiceError, Never>()

    // The endpoint for this input is just /emoji, which is not helpful. So I've named the input for clarity.
    enum Input: Equatable {
        case loadAllEmoji
    }

    func apply(input: Input) {
        switch input {
            case .loadAllEmoji: loadAllEmojiSubject.send(())
        }
    }

    // MARK: - Output

    @Published var emoji: [Emoji] = []
    @Published var error: ServiceError?

    // MARK: - Binding View Model

    private func bind() {
        loadAllEmojiSubject
            .flatMap { [unowned self] in
                return self.response(from: EmojiRequest())
                    .catch { [weak self] error -> Empty<EmojiRequest.Response, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }
            .assign(to: \.emoji, on: self)
            .store(in: &cancellables)

        errorSubject
            .compactMap { $0 }
            .assign(to: \.error, on: self)
            .store(in: &cancellables)
    }
}
