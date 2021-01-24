//
//  EmojiItemView.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/24.
//

import SwiftUI

struct EmojiItemView: View {

    @State var emoji: Emoji

    var body: some View {
        NavigationLink(destination: EmojiDetailView(viewModel: EmojiDetailViewViewModel(selectedEmoji: emoji))) {
            Text(emoji.character.decode())
                .padding()
                .font(.title)
        }
    }

}

#if DEBUG
struct EmojiItemView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiItemView(emoji: Fixture.emoji)
    }
}

extension EmojiItemView_Previews {
    struct Fixture {
        static var emoji: Emoji {
            Emoji(
                slug: "grinning-face",
                character: "\\ud83d\\ude00",
                unicodeName: "grinning face",
                codePoint: "1F600",
                group: "smileys-emotion"
            )
        }
    }
}
#endif
