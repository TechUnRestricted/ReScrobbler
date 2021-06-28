//
//  TagsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI

class TagsTopData: ObservableObject {
    @Published var savedJson : getTopTags.jsonStruct?
}

struct TagsTopView: View {
    @EnvironmentObject var data: TagsTopData
    
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
                        if let savedTagsTopDefaults = defaults.object(forKey: "SavedTagsTop") as? Data {
                            if let loadedTagsTopDefaults = try? JSONDecoder().decode(getTopTags.jsonStruct.self, from: savedTagsTopDefaults) {
                                print("Loading from Defaults")
                                data.savedJson = loadedTagsTopDefaults
                            }
                        }
                        else{
                            print("Found nothing in Defaults. Fetching info from Internet.")
                            
                            //Getting JSON from Internet
                            if let jsonFromInternet = try? JSONDecoder().decode(getTopTags.jsonStruct.self, from:getJSONFromUrl("method=chart.gettoptags&limit=100")){
                                data.savedJson = jsonFromInternet
                                
                                print("Successfully got info from Internet")
                                if let encoded = try? JSONEncoder().encode(data.savedJson) {
                                    defaults.set(encoded, forKey: "SavedTagsTop")
                                }
                                
                            }
                            else{
                                print("An error has occured while getting data from Internet.")
                            }
                        }
                        
                    }
                })
                if ((data.savedJson != nil)){
                    let jsonSimplified = data.savedJson!.tags!.tag!
                    ForEach(0 ..< (jsonSimplified.count)) { value in
                        TagsTopEntry(
                            index: value+1,
                            tag: jsonSimplified[value].name!
                            
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
struct TagsTopEntry: View {
    var index: Int = 0
    var tag: String = "Unknown Tag"
    
    
    init(index: Int, tag: String) {
        self.index = index
        self.tag = tag
        
    }
    
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




