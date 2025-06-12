//
//  Helpers.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/21/25.
//

import Foundation
import SwiftUI

func isTruthy(value: Binding<AnyObject?>) -> Binding<Bool> {
    Binding<Bool>(
        get: { value.wrappedValue != nil },
        set: { $0 }
    )
}
