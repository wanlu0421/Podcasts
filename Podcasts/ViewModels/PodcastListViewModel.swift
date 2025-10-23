//
//  PodcastListViewModel.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//


import SwiftUI

class PodcastListViewModel: ObservableObject {
    @Published var podcasts: [Podcast] = []
    @Published var navTitle: String = "Podcasts"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var currentPage = 0
    private var hasNextPage = true
    
    private let networkService: NetworkService
    var favouriteManager: any FavouriteManagerProtocol
    
    init(networkService: NetworkService = NetworkService(), favouriteManager: any FavouriteManagerProtocol = FavouriteManager()) {
        self.networkService = networkService
        self.favouriteManager = favouriteManager
    }
    
    func loadPodcasts(page: Int) async {
        await MainActor.run {
            guard !isLoading && hasNextPage else { return }
            
            isLoading = true
            errorMessage = nil
        }
        
        do {
            
            let results = try await networkService.getPodcasts(page: page)
            
            await MainActor.run {
                self.podcasts.append(contentsOf: results.podcasts)
                
                self.currentPage = page
                self.hasNextPage = results.hasNext ?? false
            }
            
        } catch let error as PodcastApiError {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        } catch {
            print("unkonwn error")
            await MainActor.run {
                self.errorMessage = "Unkonwn Error"
            }
        }
        
        await MainActor.run {
            self.isLoading = false
        }
    }
    
    //MARK: - loading at first time
    func loadInitialPodcasts() async {
        guard podcasts.isEmpty else { return }
        await loadPodcasts(page: 1)
    }
    
    //MARK: - loading for next pages
    func loadMorePodcasts(currentItem podcast: Podcast?) async {
        
        let shouldLoad: Bool = await MainActor.run {
            guard let podcast = podcast,
                  let lastIndex = podcasts.lastIndex(where: { $0.id == podcast.id}),
                  lastIndex >= podcasts.count - 2, //load next page when reach the second to last item
                  hasNextPage,
                  !isLoading
            else { return false}
            
            isLoading = true
            return true
        }
        
        if shouldLoad {
            await loadPodcasts(page: currentPage + 1)
        }
        
    }
    
    func toggleFavourite(podcastId: String) {
        favouriteManager.toggleFavourite(podcastId: podcastId)
    }
    
    func isFavourite(podcastId: String) -> Bool {
        favouriteManager.isFavourite(podcastId: podcastId)
    }
    
}
