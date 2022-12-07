//
//  AudioPlayer.swift
//  ThePodcastApp
//
//  Created by Sankeeth Naguleswaran on 2022-12-07.
//

import Foundation
import AVFoundation

class AudioPlayer: ObservableObject {
    static private var player = AVPlayer()
    static private var episode: Episode?
    
    private init() {}
    
    static func play() {
        if ( !AudioPlayer.isPlaying() ) {
            AudioPlayer.player.play()
        }
    }
    
    static func pause() {
        if ( AudioPlayer.isPlaying() ) {
            AudioPlayer.player.pause()
        }
    }
    
    static func set(episode: Episode) {
        if ((AudioPlayer.episode == nil) || (AudioPlayer.episode?.audioUrl != episode.audioUrl)) {
            AudioPlayer.episode = episode
            
            if let url = URL(string: episode.audioUrl) {
                AudioPlayer.player = AVPlayer(url: url)
            }
        }
    }
    
    static func isPlaying() -> Bool {
        let audioPlayer = AudioPlayer.player
        return (audioPlayer.rate) != 0 && (audioPlayer.error == nil)
    }
    
    static func isPlaying(episode: Episode) -> Bool {
        return AudioPlayer.isPlaying() && (AudioPlayer.episode?.id == episode.id)
    }
    
    static func getOngoingEpisode() -> Episode? {
        return AudioPlayer.episode
    }
}
