//
//  ArtistsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI

class ArtistsTopData: ObservableObject {
    /**
     Observable Object for storing data from ArtistsTopView
     */
    
    @Published var savedJson : getTopArtists.jsonStruct?
}

struct ArtistsTopView: View {
    @EnvironmentObject var data: ArtistsTopData
    
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
                        if let savedArtistsTopDefaults = defaults.object(forKey: "SavedArtistsTop") as? Data {
                            if let loadedArtistsTopDefaults = try? JSONDecoder().decode(getTopArtists.jsonStruct.self, from: savedArtistsTopDefaults) {
                                print("Loading from Defaults")
                                data.savedJson = loadedArtistsTopDefaults
                            }
                        }
                        else{
                            print("Found nothing in Defaults. Fetching info from Internet.")
                            
                            //Getting JSON from Internet
                            if let jsonFromInternet = try? JSONDecoder().decode(getTopArtists.jsonStruct.self, from:getJSONFromUrl("method=chart.gettopartists&limit=100")){
                                data.savedJson = jsonFromInternet
                                
                                print("Successfully got info from Internet")
                                if let encoded = try? JSONEncoder().encode(data.savedJson) {
                                    defaults.set(encoded, forKey: "SavedArtistsTop")
                                }
                                
                            }
                            else{
                                print("An error has occured while getting data from Internet.")
                            }
                        }
                        
                    }
                })
                
                //Checking if we have JSON loaded to RAM
                if ((data.savedJson != nil)){
                    let jsonSimplified = data.savedJson!.artists!.artist!
                    
                    ForEach(0 ..< (jsonSimplified.count)) { value in
                        ArtistsTopEntry(
                            index: value+1,
                            artist: jsonSimplified[value].name!,
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
                else{
                    Text("Can't load data")
                }
                
                
            }
        }
    }
    
}

struct ArtistsTopEntry: View {
    var index: Int = 0
    var artist: String = "Unknown Artist"
    var listenersCount: String = "0"
    var playCount: String = "0"
    
    init(index: Int, artist: String, listenersCount: String, playCount: String) {
        self.index = index
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
