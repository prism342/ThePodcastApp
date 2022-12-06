//
//  ContentView.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            EpisodeDetailView(episodeID: "22Pwv3oFdg13MndnEOOl")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
