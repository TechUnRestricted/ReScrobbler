//
//  ArtistsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI



func getData() -> getTopArtists.jsonStruct?{
    if let savedJson = defaults.object(forKey: "SavedArtistsTop") as? Data {
        if let loadedJson = try? JSONDecoder().decode(getTopArtists.jsonStruct.self, from: savedJson) {
            print("[LOG]:> {ArtistsTopView} Loaded local JSON struct from <defaults>.")
            return loadedJson
        }
    }
    else{
        if let jsonFromInternet = try? JSONDecoder().decode(getTopArtists.jsonStruct.self, from:getJSONFromUrl("method=chart.gettopartists&limit=100")){
            print("[LOG]:> {ArtistsTopView} Loaded JSON struct from <internet>")
            if let encoded = try? JSONEncoder().encode(jsonFromInternet) {
                defaults.set(encoded, forKey: "SavedArtistsTop")
            }
            return jsonFromInternet
        }
        else{
            print("[LOG]:> An error has occured while getting data from Internet.")
        }
    }
    return nil
}

extension String {
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}

func getArtistInfo(artistName: String) -> getInfoArtist.jsonStruct?{
    if let jsonFromInternet = try? JSONDecoder().decode(getInfoArtist.jsonStruct.self, from:getJSONFromUrl("method=artist.getinfo&artist=" + artistName.urlEncoded!)){
        print("[LOG]:> {ArtistInfoPopUpView} Loaded JSON struct from <internet>")

        return jsonFromInternet
    }
    else{
        print("[LOG]:> An error has occured while getting data from Internet.")
    }
    return nil
}

struct ArtistInfoPopUpView: View {
    var artistName : String = "Unknown Artist"
    var isOnTour : Bool = false
    var tags : [String?] = []
    var listeners : String = "Unknown"
    var playCount : String = "Unknown"
    var aboutArtist : String = "No information provided"
    var similarArtists : [String?] = []
    
    var body: some View{
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(){
                HStack{
                    
                    ZStack{
                        Text(artistName)
                            .font(.title)
                            .fontWeight(.light)
                            .lineLimit(1)
                            .padding([.top, .leading, .trailing], 25.0)
                        if isOnTour{
                            HStack{
                                Spacer()
                                VStack{
                                    ColoredRoundedButton(title: "On Tour", action: {}, color: Color.purple)
                                }
                            }
                        }
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(tags, id: \.self){ tag in
                            ColoredRoundedButton(title: tag!, action: {}, color: Color.random)
                        }
                    }
                }.clipShape(Capsule())
                
                HStack{
                    Group{
                        Text("Listeners: " + (listeners.roundedWithAbbreviations))
                        Text("Play Count: " + (playCount.roundedWithAbbreviations))
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
                        
                        Text(aboutArtist)
                            .font(.caption)
                            .fontWeight(.light)
                        
                    }.padding(.top, 10)
                    
                    VStack(alignment: .leading){
                        Text("Similar artists:")
                            .font(.body)
                            .padding(.leading, 15.0)
                            .padding(.bottom, 0.5)
                        VStack(spacing: 5.0){
                            ForEach(0..<similarArtists.count){ index in
                                SimilarArtistButton(artistName: similarArtists[index]!, index: index+1, action: {})
                            }
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

struct ArtistsTopView: View {
    @State var showAlert = false
    @State var chosenArtistName : String = ""
    var body: some View {
        ZStack{
            if showAlert{
                let artistInfo = getArtistInfo(artistName: chosenArtistName)?.artist
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
                
                ArtistInfoPopUpView(
                    artistName: artistInfo?.name ?? "",
                    isOnTour: (artistInfo?.ontour == "1" ? true : false),
                    tags: tagsFormatted,
                    listeners: artistInfo?.stats?.listeners ?? "",
                    playCount: artistInfo?.stats?.playcount ?? "",
                    aboutArtist: artistInfo?.bio?.summary ?? "",
                    similarArtists: similarArtistsFormatted)
                    
                    .zIndex(2)
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                    
                    .background(Color.gray.opacity(0.5))
                    .onTapGesture {
                        withAnimation{
                            showAlert = false
                        }
                    }
            }
            
            ScrollView(.vertical){
                VStack{
                    
                    if let json = getData(){
                        if let jsonSimplified = json.artists?.artist{
                            ForEach(0 ..< (jsonSimplified.count)) { value in
                                ArtistsTopEntry(
                                    index: value+1,
                                    artist: jsonSimplified[value].name ?? "Unknown Artist",
                                    listenersCount: jsonSimplified[value].listeners?.roundedWithAbbreviations ?? "Unknown Listeners",
                                    playCount: jsonSimplified[value].playcount?.roundedWithAbbreviations ?? "Unknown Play Count"
                                )
                                .contentShape(Rectangle())
                                .onTapGesture{
                                    if let artistName = jsonSimplified[value].name{
                                        chosenArtistName = artistName
                                        withAnimation{
                                            showAlert = true
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                
            }
        }.zIndex(1)
    }
}



struct ArtistsTopEntry: View {
    var index: Int
    var artist: String
    var listenersCount: String
    var playCount: String
    
    var body: some View {
        VStack(){
            Divider()
            HStack{
                Text(String(index))
                    .font(.title2)
                    .padding()
                    .frame(width: 80)
                Group{
                    Text(artist).bold()
                        .frame(width: 200, alignment: .leading)
                    Text("Listeners: " + listenersCount)
                        .frame(width: 200, alignment: .leading)
                    Text("Play Count: " + playCount)
                        .frame(width: 200, alignment: .leading)
                }.padding()
            }.lineLimit(1)
            Divider()
        }
    }
    
}
