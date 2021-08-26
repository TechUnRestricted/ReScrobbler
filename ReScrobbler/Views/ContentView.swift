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



struct ActionButton: View {
    var title: String
    //var image: Image?
    var action: () -> Void
    @Binding var currentTab : String
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(minWidth: 10, maxWidth: .infinity, minHeight: 35, maxHeight: 35, alignment: .center)
                //.foregroundColor(Color.white)
                .contentShape(Rectangle())
                .background(currentTab == title ? Color.gray.opacity(0.2) : .clear)
                .cornerRadius(6)
            
        }.buttonStyle(PlainButtonStyle())
    }
}


struct TruePreview: View {
    @State private var fakeSelection: String = "Artists"
    var body: some View {
        ActionButton(title: "Overprotected", action: {}, currentTab: $fakeSelection)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TruePreview()
    }
}
