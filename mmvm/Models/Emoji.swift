//
//  Emoji.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/20.
//

import SwiftUI

struct Emoji: Hashable, Identifiable, Codable {
    var id: String { character }

    let slug: String
    let character: String
    let unicodeName: String
    let codePoint: String
    let group: String

    init(slug: String,
         character: String,
         unicodeName: String,
         codePoint: String,
         group: String) {
        self.slug = slug
        self.character = character
        self.unicodeName = unicodeName
        self.codePoint = codePoint
        self.group = group
    }

    private init() {
        self.slug = String()
        self.character = String()
        self.unicodeName = String()
        self.codePoint = String()
        self.group = String()
    }
}

extension Emoji {
    static var empty = Emoji()
}
