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

    @State private var image: Image?
    @State private var inputUIImage: UIImage?
    @State private var savingUIImage: UIImage?
    @State private var showingImagePicker = false
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

                ZStack {
                    Rectangle()
                        .fill(.secondary)
                        .frame(width: 300, height: 300)
                    Text("Tap to select photo")
                        .foregroundColor(.white)
                        .font(.headline)
                    image?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
                .onTapGesture {
                    showingImagePicker = true
                }
            }
            .onChange(of: inputUIImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputUIImage)
//                PhotosPicker("", selection: $inputUIImage, matching: .images)
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Save") {
                        viewModel.addPerson(name: personName, inputUIImage: savingUIImage)
                        viewModel.updateView()
                        dismiss()
                    }
                    .disabled(inputUIImage == nil)
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
        guard let inputUIImage = inputUIImage else { return }
        image = Image(uiImage: inputUIImage)
        savingUIImage = inputUIImage
    }
}


#Preview {
    AddPersonView(viewModel: ViewModel())
}
