//
//  EmojiViewViewModel.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/18.
//

import SwiftUI
import Combine

final class EmojiViewViewModel: ViewModel {

    // MARK: - Init

    private let emojiService: EmojiService

    init(emojiService: EmojiService = EmojiService()) {
        self.emojiService = emojiService
        bind()
    }

    let onAppearSubject = PassthroughSubject<Void, Never>()
    let didTapEmojiSubject = PassthroughSubject<Int?, Never>()
    var cancellables: [AnyCancellable] = []

    // MARK: - Input

    enum Input: Equatable {
        case onAppear
        case didTapEmoji(Int?)
    }

    func apply(input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        case .didTapEmoji(let index): didTapEmojiSubject.send(index)
        }
    }

    // MARK: - Output

    @Published var emoji: [Emoji] = []
    @Published var selectedIndex: Int?

    // MARK: - Binding View Model

    private func bind() {
        onAppearSubject
            .sink { [emojiService] in
                emojiService.apply(input: .loadAllEmoji)
            }
            .store(in: &cancellables)

        didTapEmojiSubject
            .assign(to: \.selectedIndex, on: self)
            .store(in: &cancellables)

        emojiService.$emoji
            .assign(to: \.emoji, on: self)
            .store(in: &cancellables)
    }
}
