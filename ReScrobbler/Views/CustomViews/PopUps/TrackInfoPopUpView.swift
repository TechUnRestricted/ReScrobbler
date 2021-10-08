//
//  TrackInfoPopUpView.swift
//  ReScrobbler
//
//  Created by Mac on 22.09.2021.
//

import SwiftUI

struct TrackInfoPopUpView: View {
    var chosenTrackName : String
    var chosenArtistName : String
    @Binding var showingModal : Bool
    @StateObject var receiver = TrackInfo()
    
    var body: some View {
        
        let trackInfo = receiver.data?.track
        let tagsFormatted : [String?] = {
            var arr : [String] = []
            for tag in trackInfo?.toptags?.tag ?? []{
                arr.append(tag.name ?? "")
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
                        ColoredRoundedButton(title: "Close", action:{ showingModal = false}, color: Color.purple)
                    }
                    HStack(){
                        if let path = receiver.data?.track?.album?.image?.last?.text, let url = URL(string: path), let image = NSImage(contentsOf: url){
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
                            HStack{
                                Text(trackInfo?.name ?? "Unknown Track")
                                    .font(.title)
                                Text("(" + (trackInfo?.duration?.convertToDuration ?? "0:00") + ")")
                            }
                            Text(trackInfo?.album?.title ?? "Unknown Album")
                                .font(.title2)
                            Text(trackInfo?.artist?.name ?? "Unknown Artist")
                                .font(.largeTitle)
                        }.padding()
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                HStack(spacing: 40){
                    Text("Listeners: " + (trackInfo?.listeners?.roundedWithAbbreviations ?? ""))
                    Text("Play Count: " + (trackInfo?.playcount?.roundedWithAbbreviations ?? ""))
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
                
                if let wikiInfo = trackInfo?.wiki?.summary?.withoutHtmlTags{
                    VStack(alignment: .leading){
                        Text("About track:")
                            .font(.system(size: 20))
                            .padding(.leading, 15.0)
                            .padding(.bottom, 0.5)
                        
                        
                        Text(wikiInfo.withoutHtmlTags.replacingOccurrences(of: "Read more on Last.fm", with: "") )
                            .font(.system(size: 15))
                            .fontWeight(.light)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                
            }.padding(22.0)
            .onAppear(perform: {
                if receiver.data == nil{
                    receiver.getData(track: chosenTrackName, artist: chosenArtistName)
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

struct UIBenchView_Previews: PreviewProvider {
    static var previews: some View {
        // TrackInfoPopUpView()
        EmptyView()
    }
}
