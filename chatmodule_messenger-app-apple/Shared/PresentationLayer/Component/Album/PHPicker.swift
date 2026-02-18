//
//  PHPicker.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import PhotosUI

enum PhotoPickerType {
    case onlyImages
    case imagesAndVideos
}

struct PHPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController

    @Binding var images: [UIImage]
    private var selectLimit: Int
    private var photoType: PhotoPickerType
    var itemProviders: [NSItemProvider] = []

    init(images: Binding<[UIImage]>, selectLimit: Int = 1, photoType: PhotoPickerType = .onlyImages) {
        self._images = images
        self.selectLimit = selectLimit
        self.photoType = photoType
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = selectLimit
        configuration.filter = self.photoType == .onlyImages ? .images : .any(of: [.images, .videos])
        let picker = PHPickerViewController(configuration: configuration)

        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        return PHPicker.Coordinator(parent: self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate, UINavigationControllerDelegate {

        var parent: PHPicker

        init(parent: PHPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            if !results.isEmpty {
                parent.itemProviders = []
                parent.images = []
            }

            parent.itemProviders = results.map(\.itemProvider)
            loadImage()
        }

        // 이미지를 가져옵니다.
        // video의 경우 url을 받도록 따로 구현 필요
        private func loadImage() {
            for itemProvider in parent.itemProviders {
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let image = image as? UIImage {
                            self.parent.images.append(image)
                        } else {
                            print("Could not load image", error?.localizedDescription ?? "")
                        }
                    }
                }
            }
        }
    }
}
