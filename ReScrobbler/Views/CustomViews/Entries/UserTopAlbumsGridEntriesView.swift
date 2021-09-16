//
//  UserTopAlbumsGridEntriesView.swift
//  ReScrobbler
//
//  Created on 16.09.2021.
//

import SwiftUI

struct UserTopAlbumsGridEntriesView: View {
    var userNameInput : String

    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if let albumsArray = getUserTopAlbums(user: userNameInput, limit: 10)?.topalbums?.album{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 500))]){
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
                        
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke((colorScheme == .light ? Color.white : Color.black).opacity(0.3), lineWidth: 5).blur(radius: 0.5)
                        )
                    }
                    
                    
                }
            }
        }
        
    }
}
