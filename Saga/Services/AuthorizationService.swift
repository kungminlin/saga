//
//  AuthorizationService.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/23/25.
//

import Photos

class AuthorizationService {
    static func requestAuthorizations() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in }
    }
}
