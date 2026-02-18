//
//  SmilemeCameraView.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI

struct SmilemeCameraView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SmileMeCameraViewController

    var onSaved: ((URL) -> Void)?

    init(onSaved: ((URL) -> Void)? = nil) {
        self.onSaved = onSaved
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }

    func makeUIViewController(context: Context) -> SmileMeCameraViewController {

        let vc = SmileMeCameraViewController()
        vc.smileMeCameraViewControllerDelegate = context.coordinator
        return vc
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onSaved: onSaved)
    }

    class Coordinator: SmileMeCameraViewControllerDelegate {
        var onSaved: ((URL) -> Void)?

        init(onSaved: ((URL) -> Void)? = nil) {
            self.onSaved = onSaved
        }

        func getGIFDataUrl(gifUrl: URL) {
            self.onSaved?(gifUrl)
        }
    }
}
