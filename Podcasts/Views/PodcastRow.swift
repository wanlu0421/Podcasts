//
//  PodcastRow.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//
import SwiftUI

struct PodcastRow: View {
    let podcast: Podcast
    let isFavourite: Bool
    
    var body: some View {
        //using ZStack and transparent NavigationLink to remove the right arrow in List View
        ZStack{
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
                
                VStack(alignment: .leading){
                    
                    Text(podcast.title)
                        .font(.headline)
                        .bold()
                    
                    Text(podcast.publisher)
                        .foregroundStyle(Color.secondary)
                        .font(.subheadline)
                        .italic()
                    
                    Spacer()
                    
                    if isFavourite {
                        Text("Favourited")
                            .font(.subheadline)
                            .foregroundStyle(.red)
                    }
                }
                Spacer()
            }
            NavigationLink(value: podcast) {
                EmptyView()
            }
            .opacity(0)
        }
    }
}
