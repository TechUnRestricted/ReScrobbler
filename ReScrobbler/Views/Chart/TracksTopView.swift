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
                        
                        let vGridLayout = [
                            GridItem(.flexible(maximum: 80), spacing: 0),
                            GridItem(.flexible(), spacing: 0),
                            GridItem(.flexible(), spacing: 0),
                            GridItem(.flexible(), spacing: 0)
                        ]
                        
                        
                        LazyVGrid(columns: vGridLayout, spacing: 0) {
                            ForEach(0 ..< (jsonSimplified.count)) { value in
                                let currentColor : Color = {
                                    if (value+1).isMultiple(of: 2){
                                        return Color.gray.opacity(0.1)
                                    } else {
                                        return Color.gray.opacity(0.00001)
                                    }
                                }()
                                
                                Group{
                                    Rectangle()
                                        .foregroundColor(currentColor)
                                        .frame(height: 80)
                                        .overlay(
                                                Text("\(value+1)")
                                                    .font(.title2)
                                        )
                                    
                                    Rectangle()
                                        .foregroundColor(currentColor)
                                        .frame(height: 80)
                                        .overlay(
                                            VStack{
                                                Text(jsonSimplified[value].name!)
                                                    .bold()
                                                Text((jsonSimplified[value].artist?.name)!)
                                                    .fontWeight(.light)
                                            }
                                        )
                                    
                                    Rectangle()
                                        .foregroundColor(currentColor)
                                        .frame(height: 80)
                                        .overlay(
                                            Text("Listeners: \(jsonSimplified[value].listeners!.roundedWithAbbreviations)")
                                        )
                                    
                                    Rectangle()
                                        .foregroundColor(currentColor)
                                        .frame(height: 80)
                                        .overlay(
                                            Text("Play Count: \(jsonSimplified[value].playcount!.roundedWithAbbreviations)")
                                        )
                                    
                                }
                                
                                /*.onTapGesture{
                                    if let artistName = jsonSimplified[value].name{
                                      //  chosenArtistName = artistName
                                        withAnimation{
                                        //    showAlert = true
                                        }
                                    }
                                    
                                }*/
                            }
                            
                            
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

