//
//  SubscribedPodcastsViewModel.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import Foundation
import FirebaseFirestore

class SubscribedPodcastsViewModel: ObservableObject {
    
    @Published var podcasts = [Podcast]()
    
    private var db = Firestore.firestore()
    
    func fetchData(subscribedPodcastIDs: [String]) {
        var subscribedPodcasts = [Podcast]()
        subscribedPodcastIDs.forEach {
            (id) -> Void in
            db.collection("podcasts").document(id).getDocument {
                (document, error) in
                if let document = document, document.exists {
                    let docID = document.documentID
                    let data = document.data()
                    let dataDescription = data.map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    let title = data?["title"] as? String ?? ""
                    let description = data?["description"] as? String ?? ""
                    let imageUrl = data?["imageUrl"] as? String ?? ""
                    subscribedPodcasts.append(Podcast(id: docID, title: title, description: description, imageUrl: imageUrl))
                    self.podcasts = subscribedPodcasts.sorted(by: {$0.title < $1.title})
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
}
