//
//  mmvmApp.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/18.
//

import SwiftUI

@main
struct mmvmApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiView(viewModel: EmojiViewViewModel())
        }
    }
}
