//
//  ContentView.swift
//  ReScrobbler
//
//  Created on 10.06.2021.
//

import SwiftUI
import Introspect


struct ProfileIconView: View{
    var username : String = ""

    var body: some View{
        
            if let url = URL(string: getUserInfo(user: username)?.user?.image?.last?.text ?? ""), let image = NSImage(contentsOf: url), username != ""{
                Image(nsImage: image)
                    .resizable()
                    .clipShape(Circle())

            }
            else {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 100))
            }
        
    }
}

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
                print("[LOG]:> Not changing screen from <\(tag)>")
            }
        }
    }
    
    @State var showModal : Bool = false
    @AppStorage("username") var username : String = ""


    var body: some View {
        
        
        
        NavigationView {
            List (/* Using custom "selection" handler */) {
                    Button(action: {
                        showModal = true
                    }) {
                        VStack{
                            ProfileIconView(username: username)
                                .frame(width: 105, height: 105)
                            
                                
                            Text(username != "" ? username : "Sign in")
                        }.contentShape(Rectangle())
                        
                    }.buttonStyle(PlainButtonStyle())
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                    .sheet(
                        isPresented: $showModal,
                        content: {AuthenticatePopUp(showingModal: $showModal, confirmedUsername: $username)
                            
                        }
                    )
                    
                Section(header: Text("Chart").bold().font(.title)) {
                    VStack(){
                        SidebarButton(title: "Artists", tag: "Chart.Artists", image: "music.mic", action: {changeScreen(tag: "Chart.Artists")}, currentTab: $tabSelection)
                        SidebarButton(title: "Tracks", tag: "Chart.Tracks", image: "music.note", action: {changeScreen(tag: "Chart.Tracks")}, currentTab: $tabSelection)
                        SidebarButton(title: "Tags", tag: "Chart.Tags", image: "tag", action: {changeScreen(tag: "Chart.Tags")}, currentTab: $tabSelection)
                    }
                }
                Section(header: Text("Yours").bold().font(.title)) {
                    VStack(){
                        SidebarButton(title: "Artists", tag: "Yours.Artists", image: "music.mic", action: {changeScreen(tag: "Yours.Artists")}, currentTab: $tabSelection)
                        SidebarButton(title: "Tracks", tag: "Yours.Tracks", image: "music.note", action: {changeScreen(tag: "Yours.Tracks")}, currentTab: $tabSelection)
                        SidebarButton(title: "Albums", tag: "Yours.Albums", image: "rectangle.stack", action: {changeScreen(tag: "Yours.Albums")}, currentTab: $tabSelection)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 180)
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
                ChartTopArtistsView().tag("Chart.Artists")
                ChartTopTracksView().tag("Chart.Tracks")
                ChartTopTagsView().tag("Chart.Tags")
                /* Section: Yours */
                UserTopAlbumsView(username: username).tag("Yours.Albums")
                UserTopTracksView(username: username).tag("Yours.Tracks")
                UserTopArtistsView(username: username).tag("Yours.Artists")
            }.introspectTabView{ property in
                /* Using Introspect module (master)
                 to disable TabView stock styling */
                property.tabPosition = .none
                property.tabViewBorderType = .none
            }
            .frame(maxWidth: 1300)
        }
        
    }
}







/*struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 TruePreview()
 }
 }*/
