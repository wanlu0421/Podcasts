//
//  NetworkService.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//

import Foundation

class NetworkService {
    
    func getPodcasts(page: Int) async throws -> PodcastResults {
        let endpoint = "https://listen-api-test.listennotes.com/api/v2/best_podcasts?page=\(page)"
        
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
            return response
        } catch {
            throw PodcastApiError.invalidData
        }
    }
}

