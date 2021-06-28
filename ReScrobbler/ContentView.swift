//
//  ContentView.swift
//  ReScrobbler
//
//  Created on 10.06.2021.
//

import SwiftUI
let apiKey = "b33ac675651abec66c08e3d4cba063c6"
let baseUrl = "https://ws.audioscrobbler.com/2.0/?api_key=" + apiKey + "&format=json&"

let defaults = UserDefaults.standard

struct NavigationLazyView<Content: View>: View {
    /**
     Making NavigationLink lazy.
     So it won't load all views when app starts.
     */
    
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}



extension Int {
    var roundedWithAbbreviations: String {
        /**
         Round numbers and add "M" or "K" (millions and thousands)
         at the end of each number.
         */
        
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

enum ApiError: Error {
    /**
     Dummy throwable error.
     */
    
    case connectionFailure
}



func getJSONFromUrl(_ method : String) throws -> Data{
    /**
     Getting JSON from Internet
     */
    
    print("[[[::URL::]]] >> \(baseUrl + method)")
    
    guard let data = try? Data(contentsOf: URL(string: (baseUrl + method))!) else {
        throw ApiError.connectionFailure
    }
    return data
}

func scream() -> String {
    /**
     Dummy function for debugging.
     */
    
    let randomDebugValue = arc4random()
    print("[SCREAM -> \(randomDebugValue)]")
    return " [SCREAM -> \(randomDebugValue)] "
}

struct Test: View {
    /**
     Dummy view for debugging.
     */
    
    var body: some View {
        VStack(){
            Divider()
            HStack{
                Text("1")
                    .font(.title2)
                    .padding()
                    .frame(width: 80)
                Group{
                    VStack{
                        Group{
                            Text("Smile")
                                .bold()
                            Text("Lily Allen")
                                .fontWeight(.light)
                        }
                        .frame(width: 200, alignment: .leading)
                    }
                    
                    Text("Listeners: " + "69.3M")
                        .frame(width: 200, alignment: .leading)
                    Text("Play Count: " + "90.8M")
                        .frame(width: 200, alignment: .leading)
                }.padding()
            }.lineLimit(1)
            Divider()
        }
    }
    
    
}

/*
 [START]: Artists Top
 */


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
/*
 [END]: Artists Top
 */

/*
 [START]: Tracks Top
 */
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
/*
 [END]: Tracks Top
 */

struct ContentView: View {
    
    @State private var selection: String? = "Tracks"
    @StateObject var artistsTopDataState = ArtistsTopData()
    @StateObject var tracksTopDataState = TracksTopData()
    
    var body: some View {
        
        NavigationView {
            List (selection: $selection) {
                Section(header: Text("Top")) {
                    NavigationLink(
                        destination: NavigationLazyView(ArtistsTopView()).environmentObject(artistsTopDataState),
                        label: {
                            Text("Artists")
                        }
                    ).tag("Artists")
                    
                    NavigationLink(
                        destination: NavigationLazyView(TracksTopView()).environmentObject(tracksTopDataState),
                        label: {
                            Text("Tracks")
                        })
                }.tag("Tracks")
                
            }.listStyle(SidebarListStyle())
            
            
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
            }.lineLimit(2)
            Divider()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView()
        Test()
    }
}
