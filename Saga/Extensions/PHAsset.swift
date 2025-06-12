//
//  PHAsset.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/23/25.
//

import Photos
import VisionKit
import Vision
import SwiftUI

extension PHAsset {
    var thumbnail: UIImage {
        let manager = PHImageManager()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: self, targetSize: CGSize(width: 512.0, height: 512.0), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
}
