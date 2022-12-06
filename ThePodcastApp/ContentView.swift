//
//  ContentView.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var podcastsViewModel = PodcastsViewModel()

    var body: some View {
        NavigationView {
            List(podcastsViewModel.podcasts) { podcast in
                VStack(alignment: .leading) {
                    Text(podcast.title).font(.title)
                    Text(podcast.description).font(.subheadline)
                }
            }.navigationBarTitle("Podcasts")
            .onAppear() {
                self.podcastsViewModel.fetchData()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
