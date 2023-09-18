//
//  Media.swift
//  ReelsApp
//
//  Created by Maliks on 16/09/2023.
//

import Foundation

struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url: String
    var isExpanded: Bool = false
}

var MediaFileJSON = [
    MediaFile(url: "Reel1"),
    MediaFile(url: "Reel2"),
    MediaFile(url: "Reel3"),
    MediaFile(url: "Reel4")
]
