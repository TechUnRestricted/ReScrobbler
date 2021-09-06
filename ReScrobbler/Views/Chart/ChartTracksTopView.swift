//
//  TracksTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI

fileprivate func getData() -> getTopTracks.jsonStruct?{
    /**
        Getting data from URL (online) or from Container data (offline)
     */
    let jsonFolder = fileManager?.appendingPathComponent("jsonStructures")
    let jsonFile = jsonFolder?.appendingPathComponent("ChartTracksTop.json")
    
     func loadFromInternet() -> getTopTracks.jsonStruct?{
        if let jsonFromInternet = try? JSONDecoder().decode(getTopTracks.jsonStruct.self, from:getJSONFromUrl("method=chart.gettopTracks&limit=100")){
            print("[LOG]:> {TracksTopView} Loaded JSON struct from <internet>")
            if let encoded = try? JSONEncoder().encode(jsonFromInternet) {
                if let jsonFile = jsonFile{
                    do {
                        try encoded.write(to: jsonFile)
                        print("[LOG]:> JSON <ChartTracksTop.json> has been saved.")

                    } catch {
                        print("[ERROR]:> Can't write <ChartTracksTop.json>. {Message: \(error)}")
                    }
                }
            }
            return jsonFromInternet
        }
        else{
            print("[LOG]:> An error has occured while getting data from Internet.")
            return nil
        }
    }
    
    do {
        if let jsonFolder = jsonFolder{
            try FileManager.default.createDirectory(atPath: jsonFolder.path, withIntermediateDirectories: true, attributes: nil)
            print("[LOG]:> Folder <jsonStructures> has been created.")
        }
    } catch {
        print("[ERROR]:> Can't create folder <jsonStructures>. {Message: \(error)}")
    }
    
    print(jsonFolder?.path ?? "[[Can't get path]]")

    if let jsonFile = jsonFile, FileManager.default.fileExists(atPath: jsonFile.path) {

        do{
            let json = try JSONDecoder().decode(getTopTracks.jsonStruct.self, from: Data(contentsOf: jsonFile))
            print("[LOG]:> Loaded local JSON struct from <ChartTracksTop.json>.")
            return json
        }
        catch{
            print("[ERROR]:> Can't load <ChartTracksTop.json> from App Container. {Message: \(error)}")
            return loadFromInternet()
        }
    }
    else{
       return loadFromInternet()
    }
}



struct ChartTracksTopView: View {
    
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
                                                Text(jsonSimplified[value].name ?? "Unknown Tracks")
                                                    .bold()
                                                Text((jsonSimplified[value].artist?.name) ?? "Unknown Artist")
                                                    .fontWeight(.light)
                                            }
                                        )
                                    
                                    Rectangle()
                                        .foregroundColor(currentColor)
                                        .frame(height: 80)
                                        .overlay(
                                            Text("Listeners: \(jsonSimplified[value].listeners?.roundedWithAbbreviations ?? "Unknown")")
                                        )
                                    
                                    Rectangle()
                                        .foregroundColor(currentColor)
                                        .frame(height: 80)
                                        .overlay(
                                            Text("Play Count: \(jsonSimplified[value].playcount?.roundedWithAbbreviations ?? "Unknown")")
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

