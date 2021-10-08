//
//  AlbumInfoPopUpView.swift
//  ReScrobbler
//
//  Created by Mac on 04.10.2021.
//

import SwiftUI

import SwiftUI

struct AlbumInfoPopUpView: View {
    var chosenAlbumName : String
    var chosenArtistName : String
    @Binding var showingModal : Bool
    @StateObject var receiver = AlbumInfo()
    
    var body: some View {
        
        let albumInfo = receiver.data?.album
        let tagsFormatted : [String?] = {
            var arr : [String] = []
            for tag in albumInfo?.tags?.tag ?? []{
                arr.append(tag.name ?? "")
            }
            return arr
        }()
        
        let tracksFormatted : [String?] = {
            var arr : [String] = []
            for track in albumInfo?.tracks?.track ?? []{
                arr.append(track.name ?? "")
            }
            return arr
        }()
        
        ScrollView(.vertical, showsIndicators: false){
           if (receiver.data == nil){
                VStack{
                    Spacer()
                    HStack(spacing: 10){
                        Text("Loading...")
                        ProgressView()
                    }
                    Spacer()
                }
            }
            
            VStack(){
                ZStack(){
                    HStack{
                        Spacer()
                        ColoredRoundedButton(title: "Close", action:{showingModal = false}, color: Color.purple)
                    }
                    HStack(){
                        if let path = albumInfo?.image?.last?.text, let url = URL(string: path), let image = NSImage(contentsOf: url){
                            Image(nsImage: image)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .cornerRadius(18)
                        }
                        else {
                            DefaultProfilePictureView()
                                .frame(width: 150, height: 150)
                                .cornerRadius(18)
                        }
                        
                            
                        VStack(alignment: .leading){
                            Text(albumInfo?.name ?? "Unknown Album")
                                    .font(.largeTitle)
                            Text(albumInfo?.artist ?? "Unknown Artist")
                                    .font(.title)
                            Text("Tracks count in album: \(tracksFormatted.count)")

                        }.padding()
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                HStack(spacing: 40){
                    Text("Listeners: " + (albumInfo?.listeners?.roundedWithAbbreviations ?? ""))
                    Text("Play Count: " + (albumInfo?.playcount?.roundedWithAbbreviations ?? ""))
                }
                .font(.system(size: 15))
                .opacity(0.8)
                .frame(maxWidth: .infinity)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                       ForEach(tagsFormatted, id: \.self){ tag in
                            ColoredRoundedButton(title: tag ?? "Unknown Tag", action: {}, color: Color.random)
                        }
                    }
                }.clipShape(Capsule())
                
                if let wikiContent = albumInfo?.wiki?.content{
                    VStack(alignment: .leading){
                        Text("About artist:")
                            .font(.system(size: 20))
                            .padding(.leading, 15.0)
                            .padding(.bottom, 0.5)
                        
                        Text(wikiContent.withoutHtmlTags.replacingOccurrences(of: "Read more on Last.fm", with: "") )
                            .font(.system(size: 15))
                            .fontWeight(.light)
                            .fixedSize(horizontal: false, vertical: true)
                        
                    }.padding(.top, 10)
                }
                
                if tracksFormatted != []{
                    VStack(alignment: .leading){
                        Text("Tracks in Album:")
                            .font(.system(size: 20))
                            .padding(.leading, 15.0)
                            .padding(.bottom, 0.5)
                        VStack(spacing: 5.0){
                            ForEach(0..<tracksFormatted.count, id: \.self){ index in
 NumberedTitleButton(artistName: tracksFormatted[index] ?? "Unknown Track", index: index+1, action: {})
                            }
                        }
                        
                    }.padding(.top, 10)
                }
                
            
            }.padding(22.0)
            .onAppear(perform: {
                if receiver.data == nil{
                    receiver.getData(artist: chosenArtistName, album: chosenAlbumName)
                }
            })
            
            
        }
        
        /*End*/
        .frame(
            minWidth: 740,
            maxWidth: .infinity,
            minHeight: 480,
            maxHeight: .infinity,
            alignment: .center
        )    }
}

struct AlbumInfoPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumInfoPopUpView(chosenAlbumName: "Sour", chosenArtistName: "Olivia Rodrigo", showingModal: .constant(true))
    }
}
