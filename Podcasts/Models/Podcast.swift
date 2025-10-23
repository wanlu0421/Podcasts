//
//  Podcast.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//

struct PodcastResults: Codable {
    let podcasts: [Podcast]
    let hasNext: Bool?
    let nextPageNumber: Int?
}

struct Podcast: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let thumbnail: String
    let publisher: String
    let description: String
}
