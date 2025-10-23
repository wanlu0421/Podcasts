//
//  FavouriteManagerProtocol.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//
import SwiftUI

protocol FavouriteManagerProtocol: ObservableObject {
    var favouriteIds: Set<String> { get }
    
    func toggleFavourite(podcastId: String)
    func isFavourite(podcastId: String) -> Bool
}
