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
    @StateObject var tagsTopDataState = TagsTopData()

    
    var body: some View {
        
        NavigationView {
            List (selection: $selection) {
                Section(header: Text("Chart")) {
                    NavigationLink(
                        destination: NavigationLazyView(ArtistsTopView()).environmentObject(artistsTopDataState),
                        label: {
                            Image(systemName: "music.mic")
                                .frame(width: 20)
                            Text("Artists")
                        }
                    ).tag("Artists")
                    
                    NavigationLink(
                        destination: NavigationLazyView(TracksTopView()).environmentObject(tracksTopDataState),
                        label: {
                            Image(systemName: "music.note")
                                .frame(width: 20)
                            Text("Tracks")
                        })
                }.tag("Tracks")
                
                NavigationLink(
                    destination: NavigationLazyView(TagsTopView()).environmentObject(tagsTopDataState),
                    label: {
                        Image(systemName: "tag")
                            .frame(width: 20)
                        Text("Tags")
                    })
            }.tag("Tags")
                
            }.listStyle(SidebarListStyle())
            
            
        }
        
    }





    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView()
        Test()
    }
}
