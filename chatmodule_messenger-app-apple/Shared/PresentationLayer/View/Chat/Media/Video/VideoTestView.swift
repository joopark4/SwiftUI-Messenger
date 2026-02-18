//
//  VideoTestView.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI

struct VideoTestView: View {
    @State var url: URL?
    @State var pickerShow: Bool = false

    var body: some View {
        if let url = url {
            VideoPlayerSection(videoUrl: url)
        }

        Button(action: {
            pickerShow.toggle()
        }, label: {
            Text("선택")
        })
        .sheet(isPresented: $pickerShow) {
            ImagePicker(image: .constant(nil), videoUrl: $url,
                        isShown: $pickerShow, sourceType: .photoLibrary, imagePickerType: .ONLYVIDEO)
        }
    }
}

struct VideoTestView_Previews: PreviewProvider {
    static var previews: some View {
        VideoTestView()
    }
}
