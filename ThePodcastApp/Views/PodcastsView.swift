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
        List(podcastsViewModel.podcasts) { podcast in
            VStack(alignment: .leading) {
                Text(podcast.title).font(.title)
                Text(podcast.description).font(.subheadline)
            }
        }.navigationBarTitle("Podcasts")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            self.podcastsViewModel.fetchData()
        }
    }
}