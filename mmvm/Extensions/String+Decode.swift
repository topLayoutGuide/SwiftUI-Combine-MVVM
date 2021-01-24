//
//  String+Decode.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/23.
//

import Foundation

extension String {
    func decode() -> String {
          let data = self.data(using: .utf8)!
          return String(data: data, encoding: .nonLossyASCII) ?? self
      }
}
