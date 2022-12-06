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
            PodcastDetailView(podcastID: "q7eHUoO4noRtmwVrbOpO")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
