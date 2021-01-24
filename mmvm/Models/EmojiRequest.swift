//
//  EmojiRequest.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/23.
//

import Foundation

struct EmojiRequest: Request {
    typealias Response = [Emoji]

    var path: String { return "/emojis" }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "access_key", value: "<YOUR_ACCESS_KEY>") // Do not actually store it like this ever.
        ]
    }
}
