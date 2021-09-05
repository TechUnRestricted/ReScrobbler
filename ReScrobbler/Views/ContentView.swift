//
//  ContentView.swift
//  ReScrobbler
//
//  Created on 10.06.2021.
//

import SwiftUI
import Introspect




var defaultTabSelection : String = "Chart.Artists"

struct ContentView: View {
    /*
     Using TabView for switching between screens (views)
     Because there is no better solution for it. Period.
     */
    @State var tabSelectionHistory : [String] = []
    @State var tabOffset : Int = 0
    @State private var tabSelection: String = defaultTabSelection
    func changeScreen(tag: String) {
        switch tag {
        case "Go.Left":
            tabOffset+=1
            tabSelection = tabSelectionHistory.dropLast(tabOffset).last ?? defaultTabSelection
        case "Go.Right":
            tabSelection = tabSelectionHistory.dropFirst(tabSelectionHistory.count - tabOffset).first!
            tabOffset-=1

        default:
           if tag != tabSelection {
                print("[LOG]:> Changing screen from <\(tabSelection)> to <\(tag)>.")
            tabSelectionHistory = tabSelectionHistory.dropLast(tabOffset)
            tabOffset = 0
                tabSelectionHistory.append(tag)
                tabSelection = tag
            } else {
                print("[Failure]:> <\(tag)>")
            }
        }
    }
    var body: some View {
        
        NavigationView {
            List (/* Using custom "selection" handler */) {
                Section(header: Text("Chart").bold().font(.title)) {
                    VStack(){
                        SidebarButton(title: "Artists", tag: "Chart.Artists", image: "music.mic", action: {changeScreen(tag: "Chart.Artists")}, currentTab: $tabSelection)
                        SidebarButton(title: "Tracks", tag: "Chart.Tracks", image: "music.note", action: {changeScreen(tag: "Chart.Tracks")}, currentTab: $tabSelection)
                        SidebarButton(title: "Tags", tag: "Chart.Tags", image: "tag", action: {changeScreen(tag: "Chart.Tags")}, currentTab: $tabSelection)
                    }
                }
                Section(header: Text("Yours").bold().font(.title)) {
                    VStack(){
                        SidebarButton(title: "Albums", tag: "Yours.Albums", image: "rectangle.stack", action: {changeScreen(tag: "Yours.Albums")}, currentTab: $tabSelection)
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
                ToolbarItem(placement: .navigation) {
                    Button(action: {
                        changeScreen(tag: "Go.Left")
                    }, label: {
                        Image(systemName: "chevron.backward")
                    }).disabled(tabOffset >= tabSelectionHistory.count ? true : false)
                }
                ToolbarItem(placement: .navigation) {
                    Button(action: {
                        changeScreen(tag: "Go.Right")
                    }, label: {
                        Image(systemName: "chevron.forward")
                    }).disabled(tabOffset == 0 ? true : false)
                    
                }
                
            }
            
            TabView(selection: $tabSelection){
                /* Section: Chart */
                ChartArtistsTopView().tag("Chart.Artists")
                ChartTracksTopView().tag("Chart.Tracks")
                ChartTagsTopView().tag("Chart.Tags")
                /* Section: Yours */
                YoursAlbumsView().tag("Yours.Albums")
            }.introspectTabView{ property in
                /* Using Introspect module (master)
                 to disable TabView stock styling */
                property.tabPosition = .none
                property.tabViewBorderType = .none
            }
        }
        
    }
}

struct YoursAlbumsView: View {
    
    var body: some View {
        VStack{
            AlbumCard(imageUrl: "https://lastfm.freetls.fastly.net/i/u/300x300/e8048f782acf8eb9e611dc82346faa6c.png", artist: "Tessa Violet", album: "Bad Ideas")

        }
    }
    
}






/*struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 TruePreview()
 }
 }*/
