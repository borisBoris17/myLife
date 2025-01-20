//
//  ImagePickerView.swift
//  myLife
//
//  Created by tucker bichsel on 1/19/25.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    @Binding var photoItem: PhotosPickerItem?
    @Binding var selectedImageData: Data?
    
    var imageSize: CGFloat
    
    var body: some View {
        HStack {
            PhotosPicker("Image from Library", selection: $photoItem, matching: .images)
            Spacer()
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize, height: imageSize)
            }
        }
        .onChange(of: photoItem) {
            Task {
                if let loaded = try? await photoItem?.loadTransferable(type: Data.self) {
                    selectedImageData = loaded
                } else {
                    print("Failed")
                }
            }
        }
    }
    
}
