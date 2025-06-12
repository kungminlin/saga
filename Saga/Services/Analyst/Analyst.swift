//
//  Analyst.swift
//  Saga
//
//  Created by Kung-Min Lin on 6/11/25.
//

import SwiftUI

protocol Analyst {
    func analyze(_ image: UIImage) async throws -> [String: Float]
}
