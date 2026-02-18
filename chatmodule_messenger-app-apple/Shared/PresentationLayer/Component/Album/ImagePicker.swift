//
//  ImagePicker.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import SwiftUI

enum ImagePickerType {
    case ALL
    case ONLYIMAGE
    case ONLYVIDEO
}

struct ImagePicker: UIViewControllerRepresentable {

    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator

    @Binding var image: UIImage?
    @Binding var videoUrl: URL?
    @Binding var isShown: Bool
    var sourceType: UIImagePickerController.SourceType = .camera
    var imagePickerType: ImagePickerType = .ONLYIMAGE

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(image: $image, videoUrl: $videoUrl, isShown: $isShown)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.mediaTypes = getPickerMediaTypes()
        picker.delegate = context.coordinator
        return picker

    }

    func getPickerMediaTypes() -> [String] {
        switch imagePickerType {
        case .ALL:
            return ["public.image", "public.movie"]
        case .ONLYIMAGE:
            return ["public.image"]
        case .ONLYVIDEO:
            return ["public.movie"]
        }
    }
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @Binding var image: UIImage?
    @Binding var videoUrl: URL?
    @Binding var isShown: Bool

    init(image: Binding<UIImage?>, videoUrl: Binding<URL?>, isShown: Binding<Bool>) {
        _image = image
        _videoUrl = videoUrl
        _isShown = isShown
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiImage
            isShown = false
        } else if let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            videoUrl = url
            isShown = false
        }

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }

}
