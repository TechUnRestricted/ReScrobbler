//
//  ContentView.swift
//  ReScrobbler
//
//  Created on 10.06.2021.
//

import SwiftUI
let apiKey = "b33ac675651abec66c08e3d4cba063c6"
let baseUrl = "https://ws.audioscrobbler.com/2.0/?api_key=" + apiKey + "&format=json&"

struct NavigationLazyView<Content: View>: View {
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
    case connectionFailure
}



func getJSONFromUrl(_ method : String) throws -> Data{
    print("[[[::URL::]]] >> \(baseUrl + method)")
    
    guard let data = try? Data(contentsOf: URL(string: (baseUrl + method))!) else {
        throw ApiError.connectionFailure
    }
    return data
}

func scream() -> String {
    print("[SCREAM]")
    return " [Scream] "
}

/*
 [START]: Artists Top
 */
class ArtistsTopData: ObservableObject {
    @Published var score = 0
    @Published var savedJson : getTopArtists.jsonStruct?
    /*
     @Published var artist : [String] = []
     @Published var listenersCount : [Int] = []
     @Published var playCount : [Int] = []
     @Published var genres : [[String]] = []
     */
}

struct Test: View {
    var body: some View {
        let columns = [
                GridItem(.fixed(160)),
                GridItem(.fixed(160))
            ]
        VStack(){
        LazyVGrid(columns: columns, content: {
            /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
            /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
        })
    }
    }
    
}

struct ArtistsTopView: View {
    @EnvironmentObject var data: ArtistsTopData
    init() {
        print("[Initializing] ArtistsTopView")
    }
    var body: some View {
        ScrollView(.vertical){
            VStack{
                VStack(){}.onAppear(perform: {
                    if ((data.savedJson != nil)){
                        print("JSON was used before")
                    }
                    else{
                        print("JSON wasn't used befire. Fetching data...")
                        data.savedJson = try! JSONDecoder().decode(getTopArtists.jsonStruct.self, from:getJSONFromUrl("method=chart.gettopartists&limit=100"))
                    }
                })
                
                if ((data.savedJson != nil)){
                    let jsonSimplified = data.savedJson!.artists!.artist!
                    /*
                     List(0..<5) { item in
                                 Image(systemName: "photo")
                                 VStack(alignment: .leading) {
                                     Text("Simon Ng")
                                     Text("Founder of AppCoda")
                                         .font(.subheadline)
                                         .color(.gray)
                                 }
                             }
                     */
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
                
                /*ForEach(0 ..< (data.savedJson!.artists?.artist?.count)!) { value in
                 Text((data.savedJson?.artists?.artist![value].name)!)
                 }
                 */
            }
        }
    }
    
}
/*
 [END]: Artists Top
 */

/*
 [START]: Artists Top
 */
class TracksTopData: ObservableObject {
    @Published var score = 0
}

struct TracksTopView: View {
    
    @EnvironmentObject var data: TracksTopData
    
    var body: some View {
        VStack{
            Text("TracksTopView \(data.score)").onTapGesture(perform: {
                print("tapped")
                data.score += 1
            })
            
        }
    }
    
}
/*
 [END]: Artists Top
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
    
    init(index: Int, artist: String, listenersCount: String, playCount: String/*, genres: [String]*/) {
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
                Group{
                    Text(artist).bold()
                    Text("Listeners: " + listenersCount)
                    Text("Play Count: " + playCount)
                }.padding()
                .frame(maxWidth: .infinity)
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
