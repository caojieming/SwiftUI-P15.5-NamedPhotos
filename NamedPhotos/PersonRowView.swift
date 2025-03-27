//
//  PersonRowView.swift
//  NamedPhotos
//
//  Created by James Cao on 3/27/25.
//

import SwiftUI
import UIKit

struct PersonRowView: View {
    let person: Person
    @State private var image: Image?

    var body: some View {
        HStack {
            image?
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                .shadow(radius: 2)
            Text(person.name)
                .font(.title2)
            Spacer()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        image = person.convert()
    }
}

// had trouble getting this to work
//#Preview {
//    let exampleAvatarData = UIImage(named: "")!.jpegData(compressionQuality: 0.8)
//    let example = Person(name: "asdf", avatar: exampleAvatarData!)
//    PersonRowView(person: example)
//}
