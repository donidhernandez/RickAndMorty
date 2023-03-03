//
//  CharactersDetailView.swift
//  RickAndMorty
//
//  Created by Doni on 3/2/23.
//

import SwiftUI

struct CharactersDetailView: View {
    
    @State var character: Character
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    AsyncImage(url: URL(string: character.image)) { image in
                        
                        image
                            .resizable()
                            .scaledToFill()
                           
                    } placeholder: {
                        ProgressView()
                    }
                    
                    CharacterInfoView(character: character)
                    
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct CharactersDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersDetailView(character: dummyData)
    }
}
