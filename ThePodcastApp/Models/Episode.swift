//
//  Episode.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import Foundation

struct Episode: Identifiable {
    var id: String
    var podcastID: String 
    var title: String
    var description: String
    var timestamp: Int 
    var audioUrl: String
}

