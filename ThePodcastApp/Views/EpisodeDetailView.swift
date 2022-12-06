//
//  EpisodeDetailView.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import SwiftUI

struct EpisodeDetailView: View {
    var episodeID: String
    @ObservedObject private var episodeDetailViewModel = EpisodeDetailViewModel()
    
    var body: some View {
        VStack(){
            Text(episodeDetailViewModel.episode.title).font(.title)
            Text(episodeDetailViewModel.episode.description).font(.subheadline)
        }.navigationBarTitle("Episode Detail")
        .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            self.episodeDetailViewModel.fetchData(episodeID: episodeID)
        }
    }
}
