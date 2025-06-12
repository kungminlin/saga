//
//  StringProtocol.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/24/25.
//

import Foundation

extension StringProtocol { // for Swift 4 you need to add the constrain `where Index == String.Index`
    var words: [SubSequence] {
        var words: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            words.append(self[range])
        }
        return words
    }
}
