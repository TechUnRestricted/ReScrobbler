//
//  UserTopAlbums.swift
//  ReScrobbler
//
//  Created by Mac on 07.09.2021.
//

import SwiftUI



fileprivate func getData(username : String) -> userGetTopAlbums.jsonStruct?{
    if let jsonFromInternet = try? JSONDecoder().decode(userGetTopAlbums.jsonStruct.self, from:getJSONFromUrl("method=user.gettopalbums&user="+username.urlEncoded!+"&limit=10")){
       print("[LOG]:> {UserTopAlbumsView} Loaded JSON struct from <internet>")
       /*if let encoded = try? JSONEncoder().encode(jsonFromInternet) {
           if let jsonFile = jsonFile{
               do {
                   try encoded.write(to: jsonFile)
                   print("[LOG]:> JSON <ChartTagsTop.json> has been saved.")

               } catch {
                   print("[ERROR]:> Can't write <ChartTagsTop.json>. {Message: \(error)}")
               }
           }
       }*/
       return jsonFromInternet
   }
   else{
       print("[LOG]:> An error has occured while getting data from Internet.")
       return nil
   }
}

struct UserTopAlbumsGrid: View {
    var userNameInput : String

    var body: some View {
        
        if let albumsArray = getData(username: userNameInput)?.topalbums?.album{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 500))]){
                ForEach(0..<albumsArray.count) { index in
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
       // let jsonFromInternet = try? JSONDecoder().decode(userGetTopAlbums.jsonStruct.self, from:getJSONFromUrl("method=user.gettopalbums&user=eminem&limit=10")).topalbums?.album
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
                
                UserTopAlbumsGrid(userNameInput: confirmedUserNameInput)
                
                /*
                 LazyVGrid(columns: [GridItem(.adaptive(minimum: 500))]){
                 AlbumCard(imageUrl: "https://lastfm.freetls.fastly.net/i/u/300x300/61b269414d3fa768c56e5e00fa9f8588.jpg", artist: "Dua Lipa", album: "Future Nostalgia")
                 AlbumCard(imageUrl: "https://lastfm.freetls.fastly.net/i/u/300x300/48770963661b4a895dba1e9ab5091ec7.png", artist: "Melanie Martinez", album: "Cry Baby")
                 AlbumCard(imageUrl: "https://lastfm.freetls.fastly.net/i/u/300x300/e8048f782acf8eb9e611dc82346faa6c.png", artist: "Tessa Violet", album: "Bad Ideas")
                 AlbumCard(imageUrl: "https://lastfm.freetls.fastly.net/i/u/300x300/046fabe60696270614fec381ea891521.jpg", artist: "Fergie", album: "Double Dutchess")
                 AlbumCard(imageUrl: "https://lastfm.freetls.fastly.net/i/u/300x300/726cd5d722886758f79eddac6c3249d8.jpg", artist: "Marina", album: "Electra Heart (Deluxe)")
                 AlbumCard(imageUrl: "https://lastfm.freetls.fastly.net/i/u/300x300/9bc4e8d03571689a6a7e2c82707fc566.jpg", artist: "Allie X", album: "Cape God")
                 }*/
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
