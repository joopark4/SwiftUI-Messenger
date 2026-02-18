//
//  VideoPlayerSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import UIKit
import AVKit
import Foundation

struct VideoPlayerSection: View {
    var videoUrl: URL?
    var player: AVPlayer?

    init(videoUrl: URL) {
        self.videoUrl = videoUrl
        player = AVPlayer(url: videoUrl)
    }

    var body: some View {
        if let player = player {
            VideoPlayerView(player: player)
            .onAppear {
                self.player?.play()
            }
        }
    }
}

private struct VideoPlayerView: UIViewControllerRepresentable {

    var player: AVPlayer

    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPlayerView>) -> AVPlayerViewController {

        let controller = AVPlayerViewController()
        controller.player = player
        return controller
    }

    func updateUIViewController(_ uiViewController: VideoPlayerView.UIViewControllerType,
                                context: UIViewControllerRepresentableContext<VideoPlayerView>) {

    }
}

#if DEBUG
struct VideoPlayerSection_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerSection(videoUrl: URL(fileURLWithPath: ""))
    }
}
#endif
