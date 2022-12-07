//
//  EpisodeDetailViewModel.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import Foundation
import FirebaseFirestore

class EpisodeDetailViewModel: ObservableObject {
    @Published var episode = Episode(id:"", podcastID:"", title: "", description: "", imageUrl: "", audioUrl: "")
    
    private var db = Firestore.firestore()
    
    func fetchData(episodeID: String, completion: @escaping () -> ()) {
        db.collection("episodes").document(episodeID).addSnapshotListener {
            (documentSnapshot, error) in
            let docID = documentSnapshot?.documentID ?? ""
            let data = documentSnapshot?.data()
            let podcastID = data?["podcastID"] as? String ?? ""
            let title = data?["title"] as? String ?? ""
            let description = data?["description"] as? String ?? ""
            let imageUrl = data?["imageUrl"] as? String ?? ""
            let audioUrl = data?["audioUrl"] as? String ?? ""
            self.episode = Episode(id: docID, podcastID: podcastID, title: title, description: description, imageUrl: imageUrl, audioUrl: audioUrl)
            completion()
        }
    }
}
