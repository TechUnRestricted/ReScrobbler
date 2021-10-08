//
//  ArtistInfoPopUpView.swift
//  ReScrobbler
//
//  Created by Mac on 15.09.2021.
//

import SwiftUI

struct ArtistInfoPopUpView: View{
    var chosenArtistName : String
    @Binding var showingModal : Bool
    @StateObject var receiver = ArtistInfo()

    var body: some View{
        let artistInfo = receiver.data?.artist
        let tagsFormatted : [String?] = {
            var arr : [String] = []
            for tag in artistInfo?.tags?.tag ?? []{
                arr.append(tag.name ?? "")
            }
            return arr
        }()
        
        let similarArtistsFormatted : [String?] = {
            var arr : [String] = []
            for artist in artistInfo?.similar?.artist ?? []{
                arr.append(artist.name ?? "")
            }
            return arr
        }()
        
        
        /*Start*/
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(){
                if (receiver.data == nil){
                    Spacer()
                    HStack(spacing: 10){
                        Text("Loading...")
                        ProgressView()
                    }
                    Spacer()
                }
                HStack{
                    
                    ZStack{
                        Text(artistInfo?.name ?? "")
                            .font(.system(size: 30))
                            .fontWeight(.light)
                            .lineLimit(1)
                            .padding([.top, .leading, .trailing], 25.0)
                            HStack{
                                VStack{
                                    ColoredRoundedButton(title: "Close", action:{ showingModal = false}, color: Color.purple)
                                }
                                Spacer()
                                
                            if (artistInfo?.ontour == "1" ? true : false){
                                VStack{
                                    ColoredRoundedButton(title: "On Tour", action: {}, color: Color.purple)
                                }
                            }
                        }
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(tagsFormatted, id: \.self){ tag in
                            ColoredRoundedButton(title: tag ?? "Unknown Tag", action: {}, color: Color.random)
                        }
                    }
                }.clipShape(Capsule())
                
                HStack{
                    Group{
                        Text("Listeners: " + (artistInfo?.stats?.listeners?.roundedWithAbbreviations ?? ""))
                        Text("Play Count: " + (artistInfo?.stats?.playcount?.roundedWithAbbreviations ?? ""))
                    }
                    .padding(.horizontal)
                    .font(.system(size: 15))
                    .opacity(0.8)
                }
                Group{
                    if let wikiInfo = artistInfo?.bio?.summary{
                        VStack(alignment: .leading){
                            Text("About artist:")
                                .font(.system(size: 20))
                                .padding(.leading, 15.0)
                                .padding(.bottom, 0.5)
                            
                            Text(wikiInfo.withoutHtmlTags.replacingOccurrences(of: "Read more on Last.fm", with: ""))
                                .font(.system(size: 15))
                                .fontWeight(.light)
                                .fixedSize(horizontal: false, vertical: true)
                            
                        }.padding(.top, 10)
                    }
                       
                    if similarArtistsFormatted != []{
                        VStack(alignment: .leading){
                            Text("Similar artists:")
                                .font(.system(size: 20))
                                .padding(.leading, 15.0)
                                .padding(.bottom, 0.5)
                            VStack(spacing: 5.0){
                                ForEach(0..<similarArtistsFormatted.count, id: \.self){ index in
                                    NumberedTitleButton(artistName: similarArtistsFormatted[index] ?? "Unknown Artist", index: index+1, action: {receiver.data = nil
                                                            receiver.getData(artist: similarArtistsFormatted[index] ?? "Unknown Artist")})
                                }
                            }
                            
                        }.padding(.top, 10)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
            }
            
            
        }
        .padding(.horizontal, 22.0)
        
        /*End*/
            .frame(
                minWidth: 740,
                maxWidth: .infinity,
                minHeight: 480,
                maxHeight: .infinity,
                alignment: .center
            )
            
            /*.onTapGesture {
                withAnimation{
                    showAlert = false
                }
            }*/

        .onAppear(perform: {
            if receiver.data == nil{
                receiver.getData(artist: chosenArtistName)
            }
        })
    }
}
