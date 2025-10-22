//
//  NetworkService.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//

import Foundation

class NetworkService {
    
    func getPodcasts() async throws -> [Podcast] {
        let endpoint = "https://listen-api-test.listennotes.com/api/v2/best_podcasts"
        
        guard let url = URL(string: endpoint) else {
            throw PodcastApiError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PodcastApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(PodcastResults.self, from: data)
            return response.podcasts
        } catch {
            throw PodcastApiError.invalidData
        }
    }
}

//MARK: - Podcast API Error
enum PodcastApiError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
