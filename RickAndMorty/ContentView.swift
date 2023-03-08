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
            CharactersView()
                .tabItem {
                    Label("Characters", systemImage: "person.3.fill")
                }
            
            EpisodesView()
                .tabItem {
                    Label("Episodes", systemImage: "film.stack")
                }
            
            LocationViews()
                .tabItem {
                    Label("Locations", systemImage: "globe")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
