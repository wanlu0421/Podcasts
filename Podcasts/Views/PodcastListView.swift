//
//  PodcastListView.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//
import SwiftUI

struct PodcastListView: View {
    @StateObject private var podcastListViewModel = PodcastListViewModel()
    @StateObject private var favouriteManager = FavouriteManager()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(podcastListViewModel.podcasts) { podcast in
                    PodcastRow(podcast: podcast, isFavourite: favouriteManager.isFavourite(podcastId: podcast.id))
                }
            }
            .task {
                await podcastListViewModel.loadPodcasts()
            }
            .listStyle(.plain)
            .navigationDestination(for: Podcast.self) { podcast in
                PodcastDetail(podcast: podcast, favouriteManager: favouriteManager)
            }
            .navigationTitle(podcastListViewModel.navTitle)
        }
    }
}

#Preview {
    PodcastListView()
}
