//
//  EpisodesView.swift
//  RickAndMorty
//
//  Created by Doni on 3/3/23.
//

import SwiftUI

struct EpisodesView: View {
    @StateObject var episodesVM = EpisodesViewModel()
    @State private var hasAppeared = false
    
    var body: some View {
        NavigationStack {
            List(episodesVM.episodes) { episode in
                NavigationLink {
                    EpisodeDetailView(episode: episode)
                } label: {
                    VStack(alignment: .leading) {
                        Text(episode.name)
                            .font(.title3)
                            .fontWeight(.heavy)
                            .fontDesign(.rounded)
                        Text(episode.episode)
                            .font(.caption)
                            .fontDesign(.rounded)
                            .foregroundColor(.gray)
                    }
                        .task {
                            if episodesVM.hasReachedEnd(of: episode) {
                                await episodesVM.getNextSetOfEpisodes()
                            }
                        }
                }
            }
            .task {
                if !hasAppeared {
                    await episodesVM.getAllEpisodes()
                    hasAppeared = true
                }
                
            }
            .navigationTitle("Episodes")
        }
    }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView()
    }
}
