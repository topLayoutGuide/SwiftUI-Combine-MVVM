//
//  ViewModel.swift
//  mmvm
//
//  Created by toplayoutguide on 2021/01/18.
//

import Combine

protocol ViewModel: ObservableObject {
    associatedtype Input: Equatable

    var cancellables: [AnyCancellable] { get }
    func apply(input: Input)
}
