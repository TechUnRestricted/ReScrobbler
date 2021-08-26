//
//  TracksTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI

func getData() -> getTopTracks.jsonStruct?{
    if let savedJson = defaults.object(forKey: "SavedTracksTop") as? Data {
        if let loadedJson = try? JSONDecoder().decode(getTopTracks.jsonStruct.self, from: savedJson) {
            print("[LOG]:> {TracksTopView} Loaded local JSON struct from <defaults>.")
            return loadedJson
        }
    }
    else{
        if let jsonFromInternet = try? JSONDecoder().decode(getTopTracks.jsonStruct.self, from:getJSONFromUrl("method=chart.gettopTracks&limit=100")){
            print("[LOG]:> {TracksTopView} Loaded JSON struct from <internet>")
            if let encoded = try? JSONEncoder().encode(jsonFromInternet) {
                defaults.set(encoded, forKey: "SavedTracksTop")
            }
            return jsonFromInternet
        }
        else{
            print("[LOG]:> An error has occured while getting data from Internet.")
        }
    }
    return nil
}

struct TracksTopView: View {
    
    var body: some View {
        ScrollView(.vertical){
            
            VStack{
                if let json = getData(){
                    if let jsonSimplified = json.tracks?.track{
                        ForEach(0 ..< (jsonSimplified.count)) { value in
                            TracksTopEntry(
                                index: value+1,
                                track: jsonSimplified[value].name!,
                                artist: jsonSimplified[value].artist!.name!,
                                listenersCount: jsonSimplified[value].listeners?.roundedWithAbbreviations ?? "Unknown Listeners",
                                playCount: jsonSimplified[value].playcount?.roundedWithAbbreviations ?? "Unknown Play Count"
                            )
                            .contentShape(Rectangle())
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
}

struct TracksTopEntry: View {
    var index: Int
    var track: String
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
                    VStack{
                        Group{
                            Text(track)
                                .bold()
                            Text(artist)
                                .fontWeight(.light)
                        }
                        .frame(width: 200, alignment: .leading)
                    }
                    
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

