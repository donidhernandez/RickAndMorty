//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Doni on 3/1/23.
//

import SwiftUI

struct CharactersView: View {
    @StateObject var charactersVM = CharactersViewModel()
    @State private var hasAppeared = false
    
    var body: some View {
        NavigationStack {
            
            List(charactersVM.characters) { character in
                NavigationLink {
                    CharactersDetailView(character: character)
                } label: {
                    CharacterRowView(character: character)
                        .accessibilityIdentifier("item_\(character.id)")
                        .task {
                            if charactersVM.hasReachedEnd(of: character) {
                                await charactersVM.getNextSetOfCharacters()
                            }
                        }
                }
            }
            .task {
                if !hasAppeared {
                    await charactersVM.getAllCharacters()
                    hasAppeared = true
                }
                
            }
            .navigationTitle("Characters")
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}

