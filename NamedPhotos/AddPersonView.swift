//
//  AddPersonView.swift
//  NamedPhotos
//
//  Created by James Cao on 3/27/25.
//

import SwiftUI
import PhotosUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedUIImage: UIImage?
    @State private var selectedViewImage: Image?
    @State private var personName = ""

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a name", text: $personName)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                PhotosPicker("Tap to select photo", selection: $selectedItem, matching: .images)
                
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .border(.secondary)
                        .frame(width: 300, height: 300)
                    Text("Select a photo")
                        .foregroundStyle(.secondary)
                        .frame(width: 300, height: 300)
                    selectedViewImage?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
            }
            .onChange(of: selectedItem) {
                loadImage()
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Save") {
                        viewModel.addPerson(name: personName, inputUIImage: selectedUIImage)
                        viewModel.updateView()
                        dismiss()
                    }
                    .disabled(selectedUIImage == nil)
                    .disabled(personName == "")
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }

    func loadImage() {
        Task {
            // turning the selectedItem (PhotosPickerItem) into image(Data)
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }

            // creating an image(UIImage) from image(Data)
            guard let tempUIImage = UIImage(data: imageData) else { return }
            selectedUIImage = tempUIImage
            
            // creating an image(Image) from image(UIImage)
            let tempViewImage = Image(uiImage: tempUIImage)
            selectedViewImage = tempViewImage
            
        }
    }
}


#Preview {
    AddPersonView(viewModel: ViewModel())
}
