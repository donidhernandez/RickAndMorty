//
//  LocationResidentsView.swift
//  RickAndMorty
//
//  Created by Doni on 3/7/23.
//

import SwiftUI

struct LocationResidentsView: View {
    @StateObject var locationsVM = LocationsViewModel()
    @State private var characters: [Character] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var location: Location
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(characters) { character in
                        NavigationLink {
                            CharactersDetailView(character: character)
                        } label: {
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(character.name)
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            }
            .task {
                characters = await locationsVM.getLocationCharacters(location: location)
            }
        }
       
    }
}

struct LocationResidentsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationResidentsView(location: locationDummyData)
    }
}
