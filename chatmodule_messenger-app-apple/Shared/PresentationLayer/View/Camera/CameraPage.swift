//
//  CameraPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI

struct CameraPage: View {

    var body: some View {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            ImagePicker(image: .constant(nil),
                        videoUrl: .constant(nil),
                        isShown: .constant(false),
                        sourceType: .camera,
                        imagePickerType: .ALL)
        } else {
            Text("Camera is not available")
        }
    }
}

struct CameraPage_Previews: PreviewProvider {
    static var previews: some View {
        CameraPage()
    }
}
