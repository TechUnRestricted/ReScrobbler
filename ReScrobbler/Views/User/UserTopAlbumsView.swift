//
//  UserTopAlbums.swift
//  ReScrobbler
//
//  Created by Mac on 07.09.2021.
//

import SwiftUI


struct UserTopAlbumsGrid: View {
    var userNameInput : String
    
    var body: some View {
        if let albumsArray = getUserTopAlbums(user: userNameInput, limit: 10)?.topalbums?.album{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 500))]){
                ForEach(0..<albumsArray.count, id: \.self) { index in
                    AlbumCard(imageUrl: (albumsArray[index].image?.last?.text)!, artist: (albumsArray[index].artist?.name)!, album: albumsArray[index].name!)
                    
                }
            }
        }
        
    }
}

struct UserTopAlbums: View {
    @State var userNameInput : String = ""
    @State var confirmedUserNameInput : String = ""
    
    var body: some View {
        
        ScrollView(.vertical){
            VStack{
                Text("""
                    Find your stats
                    by your Last.Fm profile
                    username
                    """).multilineTextAlignment(.center)
                    .fixedSize()
                    .font(.system(size: 30))
                    .opacity(0.9)
                HStack{
                    TextField("Your Last.Fm profile User Name", text: $userNameInput, onCommit: {
                        confirmedUserNameInput = userNameInput
                    })
                    .frame(maxWidth: 300)
                    
                    Button(action: {
                        confirmedUserNameInput = userNameInput
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                if confirmedUserNameInput != ""{
                    UserTopAlbumsGrid(userNameInput: confirmedUserNameInput)
                }
            }.padding()
        }
    }
    
}

struct AlbumCard: View {
    var imageUrl: String
    var artist: String
    var album: String
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        
        let nsImage : NSImage = {
            if let url = URL(string: imageUrl), let image = NSImage(contentsOf: url){
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
                        Text(artist)
                            .frame(/*minWidth: 200,*/ /*minWidth: 200,*/ alignment: .leading)
                            .font(.title2)
                            .padding()
                        
                        Text(album)
                            .fontWeight(.bold)
                            .frame(/*minWidth: 300,*/ alignment: .leading)
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

struct UserTopAlbums_Previews: PreviewProvider {
    static var previews: some View {
        UserTopAlbums()
    }
}
