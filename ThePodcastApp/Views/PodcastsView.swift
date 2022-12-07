//
//  PodcastsView.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//


import SwiftUI

struct PodcastsView: View {
    @ObservedObject private var podcastsViewModel = PodcastsViewModel()
    @State var isPlaying: Bool = false
    @State var ongoingEpisode: Episode? = AudioPlayer.getOngoingEpisode()

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
            if ongoingEpisode != nil {
                HStack(){
                    VStack(){
                        Text("Now playing").font(.title)
                        Text(ongoingEpisode!.title).font(.subheadline)
                    }
                    Button(action: {() -> Void in
                        isPlaying = AudioPlayer.isPlaying()
                        
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
                }
            }
        }.navigationBarTitle("Podcasts")
            .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            self.podcastsViewModel.fetchData()
            ongoingEpisode = AudioPlayer.getOngoingEpisode()
            if ( ongoingEpisode != nil ) {
                isPlaying = AudioPlayer.isPlaying(episode: ongoingEpisode!)
            }
        }
    }
}
