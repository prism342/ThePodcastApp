//
//  SubscribedPodcastsViewModel.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import Foundation
import FirebaseFirestore
import UIKit

class SubscribedPodcastsViewModel: ObservableObject {
    var deviceID: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
    @Published var podcasts = [Podcast]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {        
        var subscribedPodcastIDs = [String]()
        var subscribedPodcasts = [Podcast]()
        
        let userDataRef = db.collection("userData").document(deviceID)
        
        userDataRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                subscribedPodcastIDs = document.data()?["subscribedPodcastIDs"] as? [String] ?? []
                
                subscribedPodcastIDs.forEach {
                    (id) -> Void in
                    self.db.collection("podcasts").document(id).getDocument {
                        (document, error) in
                        if let document = document, document.exists {
                            let docID = document.documentID
                            let data = document.data()
                            let dataDescription = data.map(String.init(describing:)) ?? "nil"
                            print("Document data: \(dataDescription)")
                            let title = data?["title"] as? String ?? ""
                            let description = data?["description"] as? String ?? ""
                            let imageUrl = data?["imageUrl"] as? String ?? ""
                            let rank = data?["rank"] as? Int ?? 1000
                            subscribedPodcasts.append(Podcast(id: docID, title: title, description: description, imageUrl: imageUrl, rank: rank))
                            self.podcasts = subscribedPodcasts.sorted(by: {$0.rank < $1.rank})
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
                
            } else {
                print("Document does not exist")
                userDataRef.setData([
                    "subscribedPodcastIDs": []
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
}
