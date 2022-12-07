//
//  PodcastDetailViewModel.swift
//  ThePodcastApp
//
//  Created by Xuehao Xiang on 2022-12-06.
//

import Foundation
import FirebaseFirestore
import UIKit

class PodcastDetailViewModel: ObservableObject {
    @Published var podcast = Podcast(id:"", title: "", description: "", imageUrl: "", rank: 1000)
    @Published var episodes = [Episode]()
    @Published var subscribed = false
    @Published var toggleState = false
    
    private var db = Firestore.firestore()
    var deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    func fetchData(podcastID: String) {
        let userDataRef = db.collection("userData").document(deviceID)
        
        userDataRef.getDocument {
            (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                let subscribedPodcastIDs = document.data()?["subscribedPodcastIDs"] as? [String] ?? []
                print(subscribedPodcastIDs)
                if subscribedPodcastIDs.contains(self.podcast.id){
                    self.subscribed = true
                } else {
                    self.subscribed = false
                }
            } else {
                print("Document does not exist")
                self.subscribed = false
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
            self.toggleState = self.subscribed
        }
        
        db.collection("podcasts").document(podcastID).addSnapshotListener {
            (documentSnapshot, error) in
            let docID = documentSnapshot?.documentID ?? ""
            let data = documentSnapshot?.data()
            let title = data?["title"] as? String ?? ""
            let description = data?["description"] as? String ?? ""
            let imageUrl = data?["imageUrl"] as? String ?? ""
            let rank = data?["rank"] as? Int ?? 1000
            self.podcast = Podcast(id: docID, title: title, description: description, imageUrl: imageUrl, rank: rank)
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
                let timestamp = data["timestamp"] as? Int ?? 0
                let audioUrl = data["audioUrl"] as? String ?? ""
                return Episode(id:docID, podcastID:podcastID, title: title, description: description, timestamp:timestamp, audioUrl: audioUrl)
            }
        }
    }
    
    
    func toggleSubscribe(){
        print("toggleSubscribe func called")
        print("toggleState: ")
        print(toggleState)
        print("subscribed: ")
        print(subscribed)
        
        if (toggleState == subscribed) { return }
                
        let userDataRef = db.collection("userData").document(deviceID)
        
        var notificationMessage: String?
        if (self.subscribed == false){
            userDataRef.updateData(["subscribedPodcastIDs": FieldValue.arrayUnion([self.podcast.id])])
            notificationMessage = "You've subscribed to \(self.podcast.title)"
            self.subscribed = true
        } else {
            userDataRef.updateData(["subscribedPodcastIDs": FieldValue.arrayRemove([self.podcast.id])])
            notificationMessage = "You've unsubscribed from \(self.podcast.title)"
            self.subscribed = false
        }
        
        NotificationGenerator.generateNotification(title: "Subscription", description: notificationMessage!)
    }
}
