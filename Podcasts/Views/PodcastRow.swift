//
//  PodcastRow.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//
import SwiftUI

struct PodcastRow: View {
    var podcast: Podcast
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: podcast.thumbnail)) {
                thumbnailImage in
                thumbnailImage
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
            } placeholder: {
                Color.gray
            }
            .frame(width: 80, height: 80)
            //.padding()
            
            VStack(alignment: .leading){
                Text(podcast.title)
                    .font(.headline)
                Text(podcast.publisher)
                    .foregroundStyle(Color.secondary)
                    .font(.subheadline)
                Spacer()
            }
            Spacer()
        }

    }
}
