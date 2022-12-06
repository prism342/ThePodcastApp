//
//  PodcastDetailViewModel.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import Foundation
import FirebaseFirestore

class PodcastDetailViewModel: ObservableObject {
    @Published var podcast = Podcast(id:"", title: "", description: "", imageUrl: "")
    @Published var episodes = [Episode]()
    
    private var db = Firestore.firestore()
    
    func fetchData(podcastID: String) {
        db.collection("podcasts").document(podcastID).addSnapshotListener {
            (documentSnapshot, error) in
            let docID = documentSnapshot?.documentID ?? ""
            let data = documentSnapshot?.data()
            let title = data?["title"] as? String ?? ""
            let description = data?["description"] as? String ?? ""
            let imageUrl = data?["imageUrl"] as? String ?? ""
            self.podcast = Podcast(id: docID, title: title, description: description, imageUrl: imageUrl)
        }
        
        db.collection("episodes").whereField("podcastID", isEqualTo: podcastID).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.episodes = documents.map { (queryDocumentSnapshot) -> Episode in
                let docID = queryDocumentSnapshot.documentID
                let data = queryDocumentSnapshot.data()
                let podcastID = data["podcastID"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let imageUrl = data["imageUrl"] as? String ?? ""
                let audioUrl = data["audioUrl"] as? String ?? ""
                return Episode(id:docID, podcastID:podcastID, title: title, description: description, imageUrl: imageUrl, audioUrl: audioUrl)
            }
        }
    }
}
