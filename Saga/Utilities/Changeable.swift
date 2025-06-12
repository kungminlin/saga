//
//  Changeable.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/22/25.
//

import Foundation

protocol Changeable {}

extension Changeable {
    func change<T>(path: WritableKeyPath<Self, T>, to value: T) -> Self {
        var clone = self
        clone[keyPath: path] = value
        return clone
    }
}
