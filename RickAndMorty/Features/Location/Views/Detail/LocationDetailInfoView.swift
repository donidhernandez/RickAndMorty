//
//  LocationDetailInfoView.swift
//  RickAndMorty
//
//  Created by Doni on 3/7/23.
//

import SwiftUI

struct LocationDetailInfoView: View {
    
    @State var location: Location
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(location.name)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .fontDesign(.rounded)
                        Text(location.type)
                            .font(.headline)
                            .fontDesign(.rounded)
                        Text(location.dimension)
                            .font(.subheadline)
                            .fontDesign(.rounded)
                    }
                    Spacer()
                }
            }
            .padding()
        }
    }
}

struct LocationDetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailInfoView(location: locationDummyData)
    }
}
