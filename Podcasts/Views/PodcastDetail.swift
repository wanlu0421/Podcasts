//
//  PodcastDetail.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//

import SwiftUI

struct PodcastDetail: View {
    var podcast: Podcast
    
    var body: some View {
        Text("PodcastDetail")
        Text(podcast.title)
    }
}


private let mockPodcast = Podcast(
    id: "mock_id_1",
    title: "Mock Podcast",
    thumbnail: "https://cdn-images-3.listennotes.com/podcasts/the-ed-mylett-show-ed-mylett-cumulus-vQDCWVsEFw2-PEUIT9RBhZD.300x300.jpg",
    publisher: "Mock Publisher",
    description: "A moke podcast."
)
#Preview {   
    PodcastDetail(podcast: mockPodcast)
}
