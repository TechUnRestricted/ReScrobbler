//
//  UserTopAlbumsGridEntriesView.swift
//  ReScrobbler
//
//  Created on 16.09.2021.
//

import SwiftUI

fileprivate var chosenAlbumName : String = ""
fileprivate var chosenArtistName : String = ""

struct UserTopAlbumsEntriesView: View {
    var userNameInput : String
    var limit : Int
    @Environment(\.colorScheme) var colorScheme
    @StateObject var receiver = UserTopAlbums()
    @State var showingModal = false
    
    var body: some View {
        if (receiver.data == nil){
            HStack(spacing: 10){
                Text("Loading...")
                ProgressView()
            }
        }
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 500))]){
            if let albumsArray = receiver.data?.topalbums?.album{
                ForEach(0..<albumsArray.count, id: \.self) { index in
                    
                    /*
                     Loading an Image from URL.
                     - Success: Loaded image
                     - Failure: Empty Image
                     */
                    
                    let nsImage : NSImage = {
                        if let url = URL(string: albumsArray[index].image?.last?.text ?? ""), let image = NSImage(contentsOf: url){
                            return image
                        }
                        return NSImage()
                    }()
                    Button(action: {
                        if let albumName = albumsArray[index].name, let artistName = albumsArray[index].artist?.name{
                            print("Pressing on index [\(index)]; album: \(albumName); artist: \(artistName)")
                            chosenAlbumName = albumName
                            chosenArtistName = artistName
                            showingModal = true
                        }
                        
                    }) {
                        
                        VStack(){
                            HStack(){
                                Image(nsImage: nsImage)
                                    .resizable()
                                    .frame(
                                        width: 150,
                                        height: 150
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke((colorScheme == .light ? Color.white : Color.black).opacity(0.3), lineWidth: 5).blur(radius: 0.5)
                                    )
                                    
                                    .cornerRadius(20)
                                    .padding()
                                
                                VStack(alignment: .leading){
                                    Group(){
                                        Text(albumsArray[index].artist?.name ?? "Unknown")
                                            .frame(alignment: .leading)
                                            .font(.title2)
                                            .padding()
                                        
                                        
                                        Text(albumsArray[index].name ?? "Unknown")
                                            .fontWeight(.bold)
                                            .frame(alignment: .leading)
                                            .font(.largeTitle)
                                            .padding()
                                        
                                    }
                                    .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                    .background((colorScheme == .light ? Color.white : Color.black).opacity(0.7))
                                    .lineLimit(1)
                                    .opacity(0.8)
                                    
                                    .cornerRadius(20)
                                    
                                }
                                .padding(.trailing)
                            }
                            .frame(/*width: 700,*/ maxWidth: .infinity, maxHeight: 190, alignment: .leading)
                            .background(
                                ZStack{
                                    Image(nsImage: nsImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .blur(radius: 4.0, opaque: true)
                                    (colorScheme == .light ? Color.white : Color.black).opacity(0.2)
                                }
                            )
                            
                            
                        }
                        
                        
                        
                    }.buttonStyle(PlainButtonStyle())
                    .contentShape(Rectangle())
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke((colorScheme == .light ? Color.white : Color.black).opacity(0.3), lineWidth: 5).blur(radius: 0.5)
                    )
                }
            }
        }
        .sheet(
            isPresented: $showingModal,
            content: {AlbumInfoPopUpView(chosenAlbumName: chosenAlbumName, chosenArtistName: chosenArtistName, showingModal: $showingModal) })
        .onAppear(perform: {
            if receiver.data == nil{
                receiver.getData(user: userNameInput, limit: 10)
            }
        })
        .onChange(of: userNameInput, perform: { value in
            receiver.data = nil
            receiver.getData(user: value, limit: 10)
        })
        
    }
}
