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

struct ArtistsTopView: View {
    @State var showAlert = false
    @State var chosenArtistName : String = ""
    var body: some View {
        ZStack{
            if showAlert{
                ArtistInfoPopUpView()
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
