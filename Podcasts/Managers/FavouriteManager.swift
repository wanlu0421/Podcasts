//
//  FavouriteManager.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//
import SwiftUI

class FavouriteManager: FavouriteManagerProtocol {
    private let favouriteKey = "favouritePodcasts"
    @Published var favouriteIds: Set<String> = []
    
    init() {
        //load favouriteIds from UserDefaults when App started
        if let savedIds = UserDefaults.standard.array(forKey: favouriteKey) as? [String] {
            self.favouriteIds = Set(savedIds)
        }
    }
    
    //check if podcast already favourited
    func isFavourite(podcastId: String) -> Bool {
        favouriteIds.contains(podcastId)
    }
    
    //change favourite state
    func toggleFavourite(podcastId: String) {
        if isFavourite(podcastId: podcastId) {
            favouriteIds.remove(podcastId)
        } else {
            favouriteIds.insert(podcastId)
        }
        
        //update to UserDefaults
        saveFavourites()
    }
    
    private func saveFavourites() {
        let ids = Array(favouriteIds)
        UserDefaults.standard.set(ids, forKey: favouriteKey)
    }
}
