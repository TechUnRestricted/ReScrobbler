//
//  TagsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI

func getData() -> getTopTags.jsonStruct?{
    /**
        Getting data from URL (online) or from defaults (offline)
     */
    if let savedJson = defaults.object(forKey: "SavedTagsTop") as? Data {
        if let loadedJson = try? JSONDecoder().decode(getTopTags.jsonStruct.self, from: savedJson) {
            print("[LOG]:> {TagsTopView} Loaded local JSON struct from <defaults>.")
            return loadedJson
        }
    }
    else{
        if let jsonFromInternet = try? JSONDecoder().decode(getTopTags.jsonStruct.self, from:getJSONFromUrl("method=chart.gettopTags&limit=100")){
            print("[LOG]:> {TagsTopView} Loaded JSON struct from <internet>")
            if let encoded = try? JSONEncoder().encode(jsonFromInternet) {
                defaults.set(encoded, forKey: "SavedTagsTop")
            }
            return jsonFromInternet
        }
        else{
            print("[LOG]:> An error has occured while getting data from Internet.")
        }
    }
    return nil
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


struct AlbumCard: View {
    var imageUrl: String
    var artist: String
    var album: String
    

    
    var body: some View {
        let nsImage = NSImage(contentsOf: URL(string: imageUrl)!)

        VStack(){
            HStack(){
                
                Image(nsImage: nsImage!)
                    .frame(width: 200, height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.3), lineWidth: 5).blur(radius: 0.5)
                    )
                    .cornerRadius(20)
                    .padding()
                
                VStack(alignment: .leading){
                    Group(){
                        Text(artist)
                            .frame(minWidth: 200, alignment: .leading)
                            .font(.title2)
                            .padding()
                        
                        
                        
                        Text(album)
                            .fontWeight(.bold)
                            .frame(minWidth: 300, alignment: .leading)
                            .font(.largeTitle)
                            .padding()

                    }
                    .foregroundColor(Color.white)
                    .background(Color.white.opacity(0.5))
                    
                    .opacity(0.8)
                    
                    .cornerRadius(20)
                    
                }
            }
            .frame(width: 700, alignment: .leading)
            .background(
                ZStack{
                    Image(nsImage: nsImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .blur(radius: 4.0, opaque: true)
                    Color.black.opacity(0.2)
                }
            )

            .cornerRadius(25)
        }
    }
}



