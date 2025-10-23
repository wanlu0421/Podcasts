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
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func loadPodcasts() async {
        do {
            podcasts = try await networkService.getPodcasts()
        } catch PodcastApiError.invalidURL {
            print("invalid URL")
        } catch PodcastApiError.invalidData {
            print("invalid Data")
        } catch PodcastApiError.invalidResponse {
            print("invalid Response")
        } catch {
            print("unkonwn error")
        }
    }    
    
}
