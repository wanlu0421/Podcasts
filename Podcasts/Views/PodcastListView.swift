//
//  PodcastListView.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//
import SwiftUI

struct PodcastListView: View {
    @StateObject private var podcastListViewModel = PodcastListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(podcastListViewModel.podcasts) { podcast in
                    PodcastRow(podcast: podcast)
                }
            }
            .task {
                await podcastListViewModel.loadPodcasts()
            }
            .listStyle(.plain)
            .navigationDestination(for: Podcast.self) { podcast in
                PodcastDetail(podcast: podcast)
            }
            .navigationTitle(podcastListViewModel.navTitle)
        }
    }
}

#Preview {
    PodcastListView()
}
