//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Doni on 3/1/23.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject var charactersVM = CharactersViewModel()
    
    private func getAllCharacters() async {
        do {
            try await charactersVM.getAllCharacters()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack {
            List(charactersVM.characters) { character in
                NavigationLink {
                    Text(character.name)
                } label: {
                    CharacterRowView(character: character)
                }
            }
            .task {
                await getAllCharacters()
            }
            .navigationTitle("Characters")
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
