//
//  EmojiDetailView.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/23.
//

import SwiftUI
import Combine

struct EmojiDetailView: View {

    @ObservedObject var viewModel: EmojiDetailViewViewModel

    var body: some View {
        VStack {
            Text(viewModel.emoji.character.decode())
                .font(
                    .system(
                        size: 160,
                        weight: .regular,
                        design: .default
                    )
                )
            HStack {
                Text("Name:")
                    .bold()
                Text(viewModel.emoji.unicodeName)
                    .italic()
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Code:")
                    .bold()
                Text(viewModel.emoji.character)
                    .italic()
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            viewModel.apply(input: .onAppear)
        }
    }

}

#if DEBUG
struct EmojiDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiDetailView(viewModel: EmojiDetailViewViewModel(selectedEmoji: Fixture.sampleEmoji))
    }
}

extension EmojiDetailView_Previews {
    struct Fixture {
        static var sampleEmoji: Emoji {
            Emoji(
                slug: "grinning-face-with-big-eyes",
                character: "\\ud83d\\ude03",
                unicodeName: "grinning face with big eyes",
                codePoint: "1F603",
                group: "smileys-emotion"
            )
        }
    }
}
#endif
