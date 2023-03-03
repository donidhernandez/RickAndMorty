//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Doni on 2/26/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            CharactersListView()
                .tabItem {
                    Label("Characters", systemImage: "person.3.fill")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
