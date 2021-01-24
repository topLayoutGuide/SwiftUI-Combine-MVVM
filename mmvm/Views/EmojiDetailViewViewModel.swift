//
//  EmojiDetailViewViewModel.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/24.
//

import SwiftUI
import Combine

final class EmojiDetailViewViewModel: ViewModel {

    // MARK: - Init

    init(selectedEmoji: Emoji) {
        bind(selectedEmoji: selectedEmoji)
    }

    let onAppearSubject = PassthroughSubject<Void, Never>()
    var cancellables: [AnyCancellable] = []

    // MARK: - Input

    enum Input: Equatable {
        case onAppear
    }

    func apply(input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        }
    }

    // MARK: - Output

    @Published var emoji: Emoji = .empty

    // MARK: - Binding View Model

    private func bind(selectedEmoji: Emoji) {
        onAppearSubject
            .map { selectedEmoji }
            .assign(to: \.emoji, on: self)
            .store(in: &cancellables)
    }
}
