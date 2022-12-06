//
//  PodcastsView.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//


import SwiftUI

struct PodcastsView: View {
    @ObservedObject private var podcastsViewModel = PodcastsViewModel()

    var body: some View {
        VStack(){
            NavigationLink(destination: SubscribedPodcastsView(subscribedPodcastIDs: [])){
                Text("See subscribed")
            }
            List(podcastsViewModel.podcasts) { podcast in
                NavigationLink(destination: PodcastDetailView(podcastID: podcast.id)){
                    VStack(alignment: .leading) {
                        Text(podcast.title).font(.title)
                        Text(podcast.description).font(.subheadline)
                    }
                }
            }
            HStack(){
                VStack(){
                    Text("Now playing").font(.title)
                    Text("Podcast title placeholder").font(.subheadline)
                }
                Button("Play", action: {() -> Void in
                    print("play button onclick")})
            }
        }.navigationBarTitle("Podcasts")
            .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            self.podcastsViewModel.fetchData()
        }
    }
}
