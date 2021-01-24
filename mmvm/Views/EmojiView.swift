//
//  EmojiView.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/18.
//

import SwiftUI
import Combine

struct EmojiView: View {

    @ObservedObject var viewModel: EmojiViewViewModel

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 30) {
                    ForEach(viewModel.emoji, id: \.self) { emoji in
                        EmojiItemView(emoji: emoji)
                    }
                }
            }
            .navigationBarTitle(Text("Emoji"))
        }
        .onAppear {
            viewModel.apply(input: .onAppear)
        }
    }
}

#if DEBUG
struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView(viewModel: EmojiViewViewModel())
    }
}
#endif
