//
//  Podcast.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//

struct PodcastResults: Codable {
    var podcasts: [Podcast]
}

struct Podcast: Codable, Identifiable {
    let id: String
    let title: String
    let thumbnail: String
    let publisher: String
}
