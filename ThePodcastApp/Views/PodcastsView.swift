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
            NavigationLink(destination: SubscribedPodcastsView()){
                Text("See subscribed")
            }
            List(podcastsViewModel.podcasts) { podcast in
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
            }
            HStack(){
                VStack(){
                    Text("Now playing").font(.title2)
                    Text("Podcast title placeholder").font(.title3)
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
