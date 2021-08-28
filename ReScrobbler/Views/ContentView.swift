//
//  ContentView.swift
//  ReScrobbler
//
//  Created on 10.06.2021.
//

import SwiftUI
import Introspect


struct ContentView: View {
    
    @State private var tabSelection: String = "Artists"
    
    
    var body: some View {
        
        NavigationView {
            List () {
                Section(header: Text("Chart")) {
                    VStack(){
                        ActionButton(title: "Artists", image: "music.mic", action: {tabSelection = "Artists"}, currentTab: $tabSelection)
                        ActionButton(title: "Tracks", image: "music.note", action: {tabSelection = "Tracks"}, currentTab: $tabSelection)
                        ActionButton(title: "Tags", image: "tag", action: {tabSelection = "Tags"}, currentTab: $tabSelection)
                    }
                }
            }.listStyle(SidebarListStyle())
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        toggleSidebar()
                    }, label: {
                        Image(systemName: "sidebar.left")
                    })
                }
            }
            
            TabView(selection: $tabSelection){
                ArtistsTopView().tag("Artists")
                TracksTopView().tag("Tracks")
                TagsTopView().tag("Tags")
            }.introspectTabView{ property in
                property.tabPosition = .none
                property.tabViewBorderType = .none
            }
        }
        
    }
}

extension Color {
    static var random: Color {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1)
    }
}





struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        TruePreview()
    }
}
