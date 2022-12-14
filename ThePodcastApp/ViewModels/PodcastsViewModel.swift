//
//  PodcastsViewModel.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import Foundation
import FirebaseFirestore

class PodcastsViewModel: ObservableObject {
    
    @Published var podcasts = [Podcast]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("podcasts").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.podcasts = documents.map { (queryDocumentSnapshot) -> Podcast in
                let docID = queryDocumentSnapshot.documentID
                let data = queryDocumentSnapshot.data()
                let title = data["title"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let imageUrl = data["imageUrl"] as? String ?? ""
                let rank = data["rank"] as? Int ?? 1000
                return Podcast(id:docID, title: title, description: description, imageUrl: imageUrl, rank: rank)
            }.sorted(by: {$0.rank < $1.rank})
        }
    }
}
