//
//  TagsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI

fileprivate func getData() -> getTopTags.jsonStruct?{
    /**
        Getting data from URL (online) or from Container data (offline)
     */
    let jsonFolder = fileManager?.appendingPathComponent("jsonStructures")
    let jsonFile = jsonFolder?.appendingPathComponent("ChartTagsTop.json")
    
     func loadFromInternet() -> getTopTags.jsonStruct?{
        if let jsonFromInternet = try? JSONDecoder().decode(getTopTags.jsonStruct.self, from:getJSONFromUrl("method=chart.gettopTags&limit=100")){
            print("[LOG]:> {TagsTopView} Loaded JSON struct from <internet>")
            if let encoded = try? JSONEncoder().encode(jsonFromInternet) {
                if let jsonFile = jsonFile{
                    do {
                        try encoded.write(to: jsonFile)
                        print("[LOG]:> JSON <ChartTagsTop.json> has been saved.")

                    } catch {
                        print("[ERROR]:> Can't write <ChartTagsTop.json>. {Message: \(error)}")
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
            let json = try JSONDecoder().decode(getTopTags.jsonStruct.self, from: Data(contentsOf: jsonFile))
            print("[LOG]:> Loaded local JSON struct from <ChartTagsTop.json>.")
            return json
        }
        catch{
            print("[ERROR]:> Can't load <ChartTagsTop.json> from App Container. {Message: \(error)}")
            return loadFromInternet()
        }
    }
    else{
       return loadFromInternet()
    }
}


struct ChartTagsTopView: View {
    
    var body: some View {
        ScrollView(.vertical){

            VStack{
                if let json = getData(){
                    if let jsonSimplified = json.tags?.tag{
                        let vGridLayout = [
                            GridItem(.flexible(maximum: 80), spacing: 0),
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
                                                
                                            }
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

struct TagsTopEntry: View {
    var index: Int
    var tag: String
    
    
    var body: some View {
        VStack(){
            Divider()
            HStack{
                Text(String(index))
                    .font(.title2)
                    .frame(width: 80)
                Text(tag)
                    .bold()
                    .frame(width: 600, alignment: .leading)
            }.padding()
        }.lineLimit(1)
        Divider()
    }
}





