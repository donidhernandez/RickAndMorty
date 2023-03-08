//
//  LocationViews.swift
//  RickAndMorty
//
//  Created by Doni on 3/7/23.
//

import SwiftUI

struct LocationViews: View {
    @StateObject var locationsVM = LocationsViewModel()
    @State private var hasAppeared = false
    
    var body: some View {
        NavigationStack {
            List(locationsVM.locations) { location in
                NavigationLink {
                    LocationDetailView(location: location)
                } label: {
                    Text(location.name)
                        .task {
                            if locationsVM.hasReachedEnd(of: location) {
                                await locationsVM.getNextSetOfLocations()
                            }
                        }
                }
            }
            .task {
                if !hasAppeared {
                    await locationsVM.getAllLocations()
                    hasAppeared = true
                }
            }
            .navigationTitle("Locations")
        }
    }
}

struct LocationViews_Previews: PreviewProvider {
    static var previews: some View {
        LocationViews()
    }
}
