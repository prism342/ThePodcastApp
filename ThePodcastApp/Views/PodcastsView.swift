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
            if ongoingEpisode != nil {
                HStack(){
                    VStack(alignment: .leading, spacing: 6){
                        Text("Now playing").font(.title3)
                        Text(ongoingEpisode!.title).font(.system(size: 16))
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
                .frame(maxWidth: .infinity)
                .background(Color(UIColor(red: 0.914, green: 0.910, blue: 0.910, alpha: 1.0)).clipShape(RoundedRectangle(cornerRadius:20)))
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
