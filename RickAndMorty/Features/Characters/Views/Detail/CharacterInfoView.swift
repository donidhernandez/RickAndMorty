//
//  CharacterInfoView.swift
//  RickAndMorty
//
//  Created by Doni on 3/3/23.
//

import SwiftUI

struct CharacterInfoView: View {
    @State var character: Character
    
    func getStatusColor() -> Color {
        switch character.status {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknown:
            return .gray
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(character.name)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                
                Spacer()
                
                Circle()
                    .frame(height: 15)
                    .foregroundColor(getStatusColor())
                Text(character.status.rawValue)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Species:")
                        .font(.title3)
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                    Text(character.species)
                        .fontDesign(.rounded)
                }
                
                HStack {
                    Text("Gender:")
                        .font(.title3)
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                    Text(character.gender.rawValue)
                        .fontDesign(.rounded)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Last known location:")
                            .font(.title3)
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                        Link(character.origin.name, destination: URL(string: character.origin.url)!)
                    }
                    HStack {
                        Text("First seen in:")
                            .font(.title3)
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                        Link(character.location.name, destination: URL(string: character.location.url)!)
                    }
                    
                }
            }
        }
        .padding()
       
    }
}

struct CharacterInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterInfoView(character: dummyData)
    }
}
