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
                        ActionButton(title: "Artists", action: {tabSelection = "Artists"}, currentTab: $tabSelection)
                        ActionButton(title: "Tracks", action: {tabSelection = "Tracks"}, currentTab: $tabSelection)
                        ActionButton(title: "Tags", action: {tabSelection = "Tags"}, currentTab: $tabSelection)
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




struct TruePreview: View {
    var body: some View {
       EmptyView()
    }
}
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ArtistInfoPopUpView(artistName: "Marina and the Diamonds",
                            isOnTour: true,
                            tags: ["Pop", "Rock", "Female", "This is very long", "Test", "Bar", "Baz", "Boom"],
                            listeners: "1234567",
                            playCount: "98765432",
                            aboutArtist: "Melanie Adele Martinez, known professionally as Melanie Martinez is an American singer, songwriter, artist, film director, music video director, actress, dancer and photographer. Moriah Rose Pereira known professionally as Poppy (or Moriah Poppy, That Poppy), is an American singer, songwriter, actress and model. In early 2014, Poppy signed to Island Records. Over a year later, her debut single ''Everybody Wants to Be Poppy'' was released and in early 2016, she released her debut extended play, Bubblebath.",
                            similarArtists: ["Lana Del Rey", "Britney Spears", "Some Artist", "Eminem i guess", "More dummy entries"])
            

        VStack(){
            SimilarArtistButton(artistName: "Marina and the Diamons", index: 1, action: {})
        }.frame(width: 400, height: 200)
        .padding()
        .background(Color.white)
    }
}
