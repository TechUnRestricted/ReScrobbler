//
//  ArtistsTopEntryView.swift
//  ReScrobbler
//
//  Created on 15.09.2021.
//

import SwiftUI

struct ArtistsTopEntry: View {
    var index: Int
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
