//
//  EpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Doni on 3/6/23.
//

import SwiftUI

struct EpisodeDetailView: View {
    
    @State var episode: Episode
    
    var body: some View {
        NavigationStack {
            EpisodeDetailInfo(episode: episode)
            EpisodeCharactersGridView(episode: episode)
            Spacer()
        }
        
        .padding()
    }
}


struct EpisodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailView(episode: episodeDummyData)
    }
}
