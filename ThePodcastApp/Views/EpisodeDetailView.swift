//
//  EpisodeDetailView.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import SwiftUI

struct EpisodeDetailView: View {
    var episodeID: String
    @State var isPlaying: Bool = false
    
    @ObservedObject private var episodeDetailViewModel = EpisodeDetailViewModel()
    
    var body: some View {
        List {
            Text(episodeDetailViewModel.episode.title).font(.title)
            Text(episodeDetailViewModel.episode.description).font(.subheadline)
            Button(action: {() -> Void in
                AudioPlayer.set(episode: episodeDetailViewModel.episode)
                isPlaying = AudioPlayer.isPlaying(episode: episodeDetailViewModel.episode)
                
                if ( isPlaying ) {
                    AudioPlayer.pause()
                } else {
                    AudioPlayer.play()
                }
                isPlaying = !isPlaying
            }, label: {
                Image(isPlaying ? "pause" : "play")
            })
            .buttonStyle(.plain)
            .frame(width: 100, height: 100)
            
        }.navigationBarTitle("Episode Detail")
        .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            self.episodeDetailViewModel.fetchData(episodeID: episodeID, completion: { () in
                isPlaying = AudioPlayer.isPlaying(episode: episodeDetailViewModel.episode)
            })
        }
    }
}
