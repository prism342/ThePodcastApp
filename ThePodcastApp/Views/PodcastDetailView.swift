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
        VStack(){
            Text(podcastDetailViewModel.podcast.title).font(.title)
            Text(podcastDetailViewModel.podcast.description).font(.subheadline)
            List(podcastDetailViewModel.episodes) { episode in
                VStack(alignment: .leading) {
                    Text(episode.title).font(.title)
                    Text(episode.description).font(.subheadline)
                }
            }
        }.navigationBarTitle("Podcast Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            self.podcastDetailViewModel.fetchData(podcastID:podcastID)
        }
    }
}
