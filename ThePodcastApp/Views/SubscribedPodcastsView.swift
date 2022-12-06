//
//  SubscribedPodcastsView.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import SwiftUI

struct SubscribedPodcastsView: View {
    var subscribedPodcastIDs: [String]
    @ObservedObject private var subscribedPodcastsViewModel = SubscribedPodcastsViewModel()

    var body: some View {
        List(subscribedPodcastsViewModel.podcasts) { podcast in
            VStack(alignment: .leading) {
                Text(podcast.title).font(.title)
                Text(podcast.description).font(.subheadline)
            }
        }.navigationBarTitle("Subscribed Podcasts")
        .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            self.subscribedPodcastsViewModel.fetchData(subscribedPodcastIDs: subscribedPodcastIDs)
        }
    }
}
