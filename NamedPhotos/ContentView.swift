//
//  ContentView.swift
//  NamedPhotos
//
//  Created by James Cao on 3/26/25.
//

/*
 Todo:
 add detailed view
 get sorting on front page working (currently adds most recent to bottom of list)
 */

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()

    @State var refresh: Bool = false
    @State private var showAddView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.namedList) { person in
                    PersonRowView(person: person)
                        .padding(-15)
                }
                .onDelete { index in
                    viewModel.removePerson(at: index)
                }
            }
            .navigationTitle("Names to Faces")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing:
                Button(action: { showAddView = true } ) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showAddView) {
                AddPersonView(viewModel: viewModel)
            }
        }
    }
}


#Preview {
    ContentView()
}
