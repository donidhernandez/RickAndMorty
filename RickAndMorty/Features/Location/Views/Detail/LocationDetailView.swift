//
//  LocationDetailView.swift
//  RickAndMorty
//
//  Created by Doni on 3/7/23.
//

import SwiftUI

struct LocationDetailView: View {
    @State var location: Location
    
    var body: some View {
        VStack {
            LocationDetailInfoView(location: location)
            LocationResidentsView(location: location)
            Spacer()
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: locationDummyData)
    }
}
