//
//  TracksTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI

class TracksTopData: ObservableObject {
    @Published var savedJson : getTopTracks.jsonStruct?
}

struct TracksTopView: View {
    @EnvironmentObject var data: TracksTopData
    
    var body: some View {
        ScrollView(.vertical){
            VStack{
                VStack(){}.onAppear(perform: {
                    
                    //Checking if JSON is saved to RAM
                    if ((data.savedJson != nil) ){
                        print("JSON was used before")
                    }
                    else{
                        print("JSON wasn't used before. Fetching data...")
                        
                        //Checking if JSON was saved to App Defaults
                        if let savedTracksTopDefaults = defaults.object(forKey: "SavedTracksTop") as? Data {
                            if let loadedTracksTopDefaults = try? JSONDecoder().decode(getTopTracks.jsonStruct.self, from: savedTracksTopDefaults) {
                                print("Loading from Defaults")
                                data.savedJson = loadedTracksTopDefaults
                            }
                        }
                        else{
                            print("Found nothing in Defaults. Fetching info from Internet.")
                            
                            //Getting JSON from Internet
                            if let jsonFromInternet = try? JSONDecoder().decode(getTopTracks.jsonStruct.self, from:getJSONFromUrl("method=chart.gettoptracks&limit=100")){
                                data.savedJson = jsonFromInternet
                                
                                print("Successfully got info from Internet")
                                if let encoded = try? JSONEncoder().encode(data.savedJson) {
                                    defaults.set(encoded, forKey: "SavedTracksTop")
                                }
                                
                            }
                            else{
                                print("An error has occured while getting data from Internet.")
                            }
                        }
                        
                    }
                })
                if ((data.savedJson != nil)){
                    let jsonSimplified = data.savedJson!.tracks!.track!
                    ForEach(0 ..< (jsonSimplified.count)) { value in
                        TracksTopEntry(
                            index: value+1,
                            track: jsonSimplified[value].name!,
                            artist: jsonSimplified[value].artist!.name!,
                            listenersCount: Int(jsonSimplified[value].listeners!)!.roundedWithAbbreviations,
                            playCount: Int(jsonSimplified[value].playcount!)!.roundedWithAbbreviations
                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            print("Tap on: \(value+1)")
                        }
                        .onHover { inside in
                            if inside {
                                NSCursor.pointingHand.push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                    }
                    Spacer()
                    
                }
                else {
                    Text("Can't load data")
                    
                }
                
            }
        }
    }
    
}

struct TracksTopEntry: View {
    var index: Int = 0
    var track: String = "Unknown Track"
    var artist: String = "Unknown Artist"
    var listenersCount: String = "0"
    var playCount: String = "0"
    
    init(index: Int, track: String, artist: String, listenersCount: String, playCount: String) {
        self.index = index
        self.track = track
        self.artist = artist
        self.listenersCount = listenersCount
        self.playCount = playCount
    }
    
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
            }.lineLimit(2)
            Divider()
        }
    }
}

