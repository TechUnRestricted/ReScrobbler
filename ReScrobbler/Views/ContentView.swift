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


struct ArtistInfoPopUpView: View {
    var body: some View{
        
            ScrollView(.vertical, showsIndicators: false){
                VStack(){
                    HStack{
                        
                        ZStack{
                            Text("Melanie Martinez")
                                .font(.title)
                                .fontWeight(.light)
                                .lineLimit(1)
                                .padding([.top, .leading, .trailing], 25.0)
                            HStack{
                                Spacer()
                                VStack{
                                    ColoredRoundedButton(title: "On Tour", action: {}, color: Color.purple)
                                }
                            }
                            
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ColoredRoundedButton(title: "pop", action: {}, color: Color.red)
                            
                            ColoredRoundedButton(title: "indie", action: {}, color: Color.yellow)
                            
                            ColoredRoundedButton(title: "indie pop", action: {}, color: Color.purple)
                            
                            ColoredRoundedButton(title: "female vocalists", action: {}, color: Color.green)
                            
                            ColoredRoundedButton(title: "alternative", action: {}, color: Color.blue)
                            
                            ColoredRoundedButton(title: "girls band favourites", action: {}, color: Color.orange)
                        }
                    }.clipShape(Capsule())
                    
                    HStack{
                        Group{
                            Text("Listeners: 69440K")
                            Text("Play Count: 66M")
                        }
                        .padding(.horizontal)
                        .font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                        .opacity(0.8)
                    }
                    Group{
                        VStack(alignment: .leading){
                            Text("About artist:")
                                .font(.body)
                                .padding(.leading, 15.0)
                                .padding(.bottom, 0.5)
                            
                            Text("Melanie Adele Martinez, known professionally as Melanie Martinez is an American singer, songwriter, artist, film director, music video director, actress, dancer and photographer. Moriah Rose Pereira known professionally as Poppy (or Moriah Poppy, That Poppy), is an American singer, songwriter, actress and model. In early 2014, Poppy signed to Island Records. Over a year later, her debut single ''Everybody Wants to Be Poppy'' was released and in early 2016, she released her debut extended play, Bubblebath.")
                                .font(.caption)
                                .fontWeight(.light)
                            
                        }.padding(.top, 10)
                        
                        VStack(alignment: .leading){
                            Text("Similar artists:")
                                .font(.body)
                                .padding(.leading, 15.0)
                                .padding(.bottom, 0.5)
                            VStack(spacing: 5.0){
                            SimilarArtistButton(artistName: "Lana Del Rey", index: 1, action: {})
                            SimilarArtistButton(artistName: "Britney Spears", index: 2, action: {})
                            SimilarArtistButton(artistName: "Zella Day", index: 3, action: {})
                            SimilarArtistButton(artistName: "That Poppy", index: 4, action: {})
                            SimilarArtistButton(artistName: "Billie Eilish", index: 5, action: {})
                            }
                            
                        }.padding(.top, 10)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                }
                
                
            }
            .padding(.horizontal, 22.0)
            .frame(maxWidth: 800, maxHeight: 600)
            .background(Color(NSColor.windowBackgroundColor))
            .cornerRadius(25)
        
    }
}


struct TruePreview: View {
    var body: some View {
        ZStack(){
            VStack(){}
                .frame(minWidth: 10, maxWidth: .infinity, minHeight: 35, maxHeight: .infinity)
                .background(Color.green)
            ScrollView(.vertical, showsIndicators: false){
                VStack(){
                    HStack{
                        
                        ZStack{
                            Text("Melanie Martinez")
                                .font(.title)
                                .fontWeight(.light)
                                .lineLimit(1)
                                .padding([.top, .leading, .trailing], 25.0)
                            HStack{
                                Spacer()
                                VStack{
                                    ColoredRoundedButton(title: "On Tour", action: {}, color: Color.purple)
                                }
                            }
                            
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ColoredRoundedButton(title: "pop", action: {}, color: Color.red)
                            
                            ColoredRoundedButton(title: "indie", action: {}, color: Color.yellow)
                            
                            ColoredRoundedButton(title: "indie pop", action: {}, color: Color.purple)
                            
                            ColoredRoundedButton(title: "female vocalists", action: {}, color: Color.green)
                            
                            ColoredRoundedButton(title: "alternative", action: {}, color: Color.blue)
                            
                            ColoredRoundedButton(title: "girls band favourites", action: {}, color: Color.orange)
                        }
                    }.clipShape(Capsule())
                    
                    HStack{
                        Group{
                            Text("Listeners: 69440K")
                            Text("Play Count: 66M")
                        }
                        .padding(.horizontal)
                        .font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                        .opacity(0.8)
                    }
                    Group{
                        VStack(alignment: .leading){
                            Text("About artist:")
                                .font(.body)
                                .padding(.leading, 15.0)
                                .padding(.bottom, 0.5)
                            
                            Text("Melanie Adele Martinez, known professionally as Melanie Martinez is an American singer, songwriter, artist, film director, music video director, actress, dancer and photographer. Moriah Rose Pereira known professionally as Poppy (or Moriah Poppy, That Poppy), is an American singer, songwriter, actress and model. In early 2014, Poppy signed to Island Records. Over a year later, her debut single ''Everybody Wants to Be Poppy'' was released and in early 2016, she released her debut extended play, Bubblebath.")
                                .font(.caption)
                                .fontWeight(.light)
                            
                        }.padding(.top, 10)
                        
                        VStack(alignment: .leading){
                            Text("Similar artists:")
                                .font(.body)
                                .padding(.leading, 15.0)
                                .padding(.bottom, 0.5)
                            VStack(spacing: 5.0){
                            SimilarArtistButton(artistName: "Lana Del Rey", index: 1, action: {})
                            SimilarArtistButton(artistName: "Britney Spears", index: 2, action: {})
                            SimilarArtistButton(artistName: "Zella Day", index: 3, action: {})
                            SimilarArtistButton(artistName: "That Poppy", index: 4, action: {})
                            SimilarArtistButton(artistName: "Billie Eilish", index: 5, action: {})
                            }
                            
                        }.padding(.top, 10)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                }
                
                
            }
            .padding(.horizontal, 22.0)
            .frame(maxWidth: 800, maxHeight: 600)
            .background(Color(NSColor.windowBackgroundColor))
            .cornerRadius(25)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        TruePreview()
            

        VStack(){
            SimilarArtistButton(artistName: "Marina and the Diamons", index: 1, action: {})
        }.frame(width: 400, height: 200)
        .padding()
        .background(Color.white)
    }
}
