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
                
                if podcastListViewModel.podcasts.isEmpty && !podcastListViewModel.isLoading {
                    Text("Unable to load podcasts. Please try again later.")
                } else {
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
            
            //error alert
            .alert("Error", isPresented: .constant(podcastListViewModel.errorMessage != nil)) {
                Button("OK") {
                    podcastListViewModel.errorMessage = nil
                }
            } message: {
                Text(podcastListViewModel.errorMessage ?? "Unknown error")
            }
            .navigationTitle(podcastListViewModel.navTitle)
        }
    }
}


#Preview {
    PodcastListView()
}
