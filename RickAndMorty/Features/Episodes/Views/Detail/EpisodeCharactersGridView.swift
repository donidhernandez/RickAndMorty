//
//  EpisodeCharactersGridView.swift
//  RickAndMorty
//
//  Created by Doni on 3/6/23.
//

import SwiftUI

struct EpisodeCharactersGridView: View {
    @StateObject var episodesVM = EpisodesViewModel()
    @State private var characters: [Character] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var episode: Episode
    
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
                characters = await episodesVM.getEpisodeCharacters(episode: episode)
            }
        }
       
    }
}

struct EpisodeCharactersGridView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeCharactersGridView(episode: episodeDummyData)
    }
}
