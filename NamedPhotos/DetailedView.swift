//
//  DetailedView.swift
//  NamedPhotos
//
//  Created by James Cao on 3/31/25.
//

import SwiftUI

struct DetailedView: View {
    let currPerson: Person
    
    var body: some View {
        NavigationView {
            VStack {
                currPerson.convert()
                    .resizable()
                    .scaledToFit()
                    .border(.secondary)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("\(currPerson.name)")
        } // NavigationView
    } // body
}

//#Preview {
//    DetailedView()
//}
