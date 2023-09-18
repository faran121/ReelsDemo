//
//  Reel.swift
//  ReelsApp
//
//  Created by Maliks on 16/09/2023.
//

import Foundation
import AVKit

struct Reel: Identifiable {
    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}
