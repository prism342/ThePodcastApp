//
//  SubscribedPodcastsView.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import SwiftUI

struct SubscribedPodcastsView: View {
    @ObservedObject private var subscribedPodcastsViewModel = SubscribedPodcastsViewModel()

    var body: some View {
        List(subscribedPodcastsViewModel.podcasts) { podcast in
            NavigationLink(destination: PodcastDetailView(podcastID: podcast.id)){
                HStack(){
                    AsyncImage(url: URL(string: podcast.imageUrl), content: {image in
                        image.image?.resizable().aspectRatio(1, contentMode: .fit)
                            .frame(width: 50, height: 50)
                    })
                    
                    VStack(alignment: .leading) {
                        Text(podcast.title).font(.title)
                        Text(podcast.description).font(.subheadline)
                    }
                }.frame(height: 100)
            }
        }.navigationBarTitle("Subscribed Podcasts")
        .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            self.subscribedPodcastsViewModel.fetchData()
        }
    }
}
