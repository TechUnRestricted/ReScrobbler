//
//  ArtistInfoPopUpView.swift
//  ReScrobbler
//
//  Created by Mac on 15.09.2021.
//

import SwiftUI

struct ArtistInfoPopUp: View{
    var chosenArtistName : String
    @Binding var showingModal : Bool

    var body: some View{
        let artistInfo = getArtistInfo(artist: chosenArtistName)?.artist
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
                    if ((artistInfo?.bio?.summary) != nil){
                        VStack(alignment: .leading){
                            Text("About artist:")
                                .font(.system(size: 20))
                                .padding(.leading, 15.0)
                                .padding(.bottom, 0.5)
                            
                            Text(artistInfo?.bio?.summary?.withoutHtmlTags ?? "No information provided")
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
                                ForEach(0..<similarArtistsFormatted.count){ index in
                                    SimilarArtistButton(artistName: similarArtistsFormatted[index] ?? "Unknown Artist", index: index+1, action: {})
                                }
                            }
                            
                        }.padding(.top, 10)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
            }
            
            
        }
        .padding(.horizontal, 22.0)
        .frame(minWidth: 200, maxWidth: 800, maxHeight: 600)
        .background(Color(NSColor.windowBackgroundColor))
        .cornerRadius(13)
        
        /*End*/
            .frame(
                minWidth: 360,
                maxWidth: .infinity,
                minHeight: 480,
                maxHeight: .infinity,
                alignment: .center
            )
            
            .background(Color.gray.opacity(0.5))
            /*.onTapGesture {
                withAnimation{
                    showAlert = false
                }
            }*/
            .onExitCommand{
                showingModal = false
            }
    
    }
}
