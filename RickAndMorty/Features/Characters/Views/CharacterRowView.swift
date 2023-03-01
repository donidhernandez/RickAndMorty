//
//  CharacterRowView.swift
//  RickAndMorty
//
//  Created by Doni on 3/1/23.
//

import SwiftUI

struct CharacterRowView: View {
    let character: Character
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
                
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title2)
                Text(character.gender.rawValue)
                    .font(.subheadline)
                Text(character.species)
                    .font(.caption)
            }
            
            Spacer()
        }
        
    }
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character: dummyData)
    }
}
