//
//  TagsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI

func getData() -> getTopTags.jsonStruct?{
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

struct TagsTopView: View {
    
    var body: some View {
        ScrollView(.vertical){

            VStack{
                if let json = getData(){
                    if let jsonSimplified = json.tags?.tag{
                        ForEach(0 ..< (jsonSimplified.count)) { value in
                            TagsTopEntry(
                                index: value+1,
                                tag: jsonSimplified[value].name ?? "Unknown Tag"
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




