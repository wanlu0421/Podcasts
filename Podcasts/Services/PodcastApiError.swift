//
//  PodcastApiError.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-23.
//

//MARK: - Podcast API Error
enum PodcastApiError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        case .invalidData:
            return "Invalid Data"
        }
    }
}
