//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Doni on 3/1/23.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject var charactersVM = CharactersViewModel()
    @State private var hasAppeared = false
    
    var body: some View {
        NavigationStack {
            if charactersVM.isLoading {
                ProgressView()
            } else {
                List(charactersVM.characters) { character in
                    NavigationLink {
                        Text(character.name)
                    } label: {
                        CharacterRowView(character: character)
                            .accessibilityIdentifier("item_\(character.id)")
                            .task {
                                if charactersVM.hasReachedEnd(of: character) && !charactersVM.isFetching {
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
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}

