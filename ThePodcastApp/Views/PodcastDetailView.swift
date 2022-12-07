//
//  PodcastDetailView.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import SwiftUI

struct PodcastDetailView: View {
    var podcastID: String
    @ObservedObject private var podcastDetailViewModel = PodcastDetailViewModel()
    
    var body: some View {
        List {
            VStack {
                AsyncImage(url: URL(string: podcastDetailViewModel.podcast.imageUrl), content: {image in
                    image.image?.resizable().aspectRatio(1, contentMode: .fit)
                        .frame(width: 150, height: 150)
                })
                Text(podcastDetailViewModel.podcast.title).font(.title)
                Text(podcastDetailViewModel.podcast.description).font(.subheadline)
            }
            Toggle("Subscribed", isOn: $podcastDetailViewModel.toggleState).onChange(of: podcastDetailViewModel.toggleState) { _ in
                podcastDetailViewModel.toggleSubscribe()
            }
            ForEach(podcastDetailViewModel.episodes) { episode in
                NavigationLink(destination: EpisodeDetailView(episodeID: episode.id)){
                    VStack(alignment: .leading) {
                        Text(episode.title).font(.title2)
                        Text(episode.description).font(.subheadline)
                    }.frame(height:100)
                }
            }
        }.navigationBarTitle("Podcast Detail")
        .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            self.podcastDetailViewModel.fetchData(podcastID:podcastID)
        }
    }
}
