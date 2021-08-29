//
//  ContentView.swift
//  ReScrobbler
//
//  Created on 10.06.2021.
//

import SwiftUI
import Introspect


struct ContentView: View {
    
    @State private var tabSelection: String = "Chart.Tracks"
    
    
    var body: some View {
        
        NavigationView {
            List () {
                Section(header: Text("Chart").bold().font(.title)) {
                    VStack(){
                        SidebarButton(title: "Artists", tag: "Chart.Artists", image: "music.mic", action: {tabSelection = "Chart.Artists"}, currentTab: $tabSelection)
                        SidebarButton(title: "Tracks", tag: "Chart.Tracks", image: "music.note", action: {tabSelection = "Chart.Tracks"}, currentTab: $tabSelection)
                        SidebarButton(title: "Tags", tag: "Chart.Tags", image: "tag", action: {tabSelection = "Chart.Tags"}, currentTab: $tabSelection)
                    }
                }
                Section(header: Text("Yours").bold().font(.title)) {
                    VStack(){
                        SidebarButton(title: "Albums", tag: "Yours.Albums", image: "rectangle.stack", action: {tabSelection = "Yours.Albums"}, currentTab: $tabSelection)
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
                ///Section: Chart
                ChartArtistsTopView().tag("Chart.Artists")
                ChartTracksTopView().tag("Chart.Tracks")
                ChartTagsTopView().tag("Chart.Tags")
                ///Section: Yours
                YoursAlbumsView().tag("Yours.Albums")
            }.introspectTabView{ property in
                property.tabPosition = .none
                property.tabViewBorderType = .none
            }
        }
        
    }
}
struct YoursAlbumsView: View {

    var body: some View {
        VStack{
            Text("Yours: Albums")
        }
    }
    
}






struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        TruePreview()
    }
}
