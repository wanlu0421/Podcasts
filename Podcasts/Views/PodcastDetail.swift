//
//  PodcastDetail.swift
//  Podcasts
//
//  Created by wanlu wei on 2025-10-22.
//

import SwiftUI

struct PodcastDetail: View {
    var podcast: Podcast
    @ObservedObject var favouriteManager: FavouriteManager
    
    var isFavourite: Bool {
        favouriteManager.isFavourite(podcastId: podcast.id)
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                Text(podcast.title)
                    .font(Font.largeTitle.bold())
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    .multilineTextAlignment(.center)
                
                Text(podcast.publisher)
                    .font(.title2)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                
                AsyncImage(url: URL(string: podcast.thumbnail)) {
                    thumbnailImage in
                    thumbnailImage
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 250, height: 250)
                .cornerRadius(8)
                .padding()
                
                Button {
                    favouriteManager.toggleFavourite(podcastId: podcast.id)
                } label: {
                    Text(isFavourite ? "Favourited" : "Favourite")
                        .bold()
                        .frame(width: 130, height: 50)
                        .background(.red)
                        .foregroundStyle(.white)
                        .cornerRadius(20)
                }
                .buttonStyle(.plain)
                
                Text(podcast.description)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}


private let mockPodcast = Podcast(
    id: "mock_id_1",
    title: "Mock Podcast",
    thumbnail: "https://cdn-images-3.listennotes.com/podcasts/the-ed-mylett-show-ed-mylett-cumulus-vQDCWVsEFw2-PEUIT9RBhZD.300x300.jpg",
    publisher: "Mock Publisher",
    description: "Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos."
)
#Preview {
    NavigationStack{
        PodcastDetail(podcast: mockPodcast, favouriteManager: FavouriteManager())
    }
}
