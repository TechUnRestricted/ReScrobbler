//
//  ContentView.swift
//  ReScrobbler
//
//  Created on 10.06.2021.
//

import SwiftUI

struct Test: View {
    /**
     Dummy view for debugging.
     */
    
    var body: some View {
        Text("Dummy")
    }
  
}

struct ContentView: View {
    
    @State private var selection: String? = "Tracks"
    @StateObject var artistsTopDataState = ArtistsTopData()
    @StateObject var tracksTopDataState = TracksTopData()
    
    var body: some View {
        
        NavigationView {
            List (selection: $selection) {
                Section(header: Text("Top")) {
                    NavigationLink(
                        destination: NavigationLazyView(ArtistsTopView()).environmentObject(artistsTopDataState),
                        label: {
                            Text("Artists")
                        }
                    ).tag("Artists")
                    
                    NavigationLink(
                        destination: NavigationLazyView(TracksTopView()).environmentObject(tracksTopDataState),
                        label: {
                            Text("Tracks")
                        })
                }.tag("Tracks")
                
            }.listStyle(SidebarListStyle())
            
            
        }
        
    }
}




    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView()
        Test()
    }
}
