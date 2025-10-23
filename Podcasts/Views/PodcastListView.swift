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
                    PodcastRow(
                        podcast: podcast,
                        isFavourite: podcastListViewModel.favouriteManager.isFavourite(podcastId: podcast.id)
                    )
                    
                    //pagination
                    .task {
                        await podcastListViewModel.loadMorePodcasts(currentItem: podcast)
                    }
                }
                
                //Loading indicator
                if podcastListViewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView("Loading...")
                        Spacer()
                    }
                }
            }
            
            //first time loading
            .task {
                await podcastListViewModel.loadInitialPodcasts()
            }
            .listStyle(.plain)
            .navigationDestination(for: Podcast.self) { podcast in
                PodcastDetail(podcast: podcast, favouriteManager: podcastListViewModel.favouriteManager as! FavouriteManager)
            }
            .navigationTitle(podcastListViewModel.navTitle)
        }
    }
}

#Preview {
    PodcastListView()
}
