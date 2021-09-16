//
//  UserTopTracksEntriesView.swift
//  ReScrobbler
//
//  Created by Mac on 16.09.2021.
//

import SwiftUI

fileprivate let vGridLayout = [
    GridItem(.flexible(maximum: 80), spacing: 0),
    GridItem(.flexible(maximum: 500), spacing: 0),
    GridItem(.flexible(), spacing: 0)
]

struct UserTopTracksEntriesView: View {
    var userNameInput : String
    var limit : Int
    
    var body: some View{
        if let json = getUserTopTracks(user: userNameInput, limit: limit), let jsonSimplified = json.toptracks?.track{
        
            LazyVGrid(columns: vGridLayout, spacing: 0) {
                ForEach(0 ..< (jsonSimplified.count), id: \.self) { value in
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
                            .frame(height: 60)
                            .overlay(
                                Text("\(value+1)")
                                    .font(.title2)
                            )
                        
                        Rectangle()
                            .foregroundColor(currentColor)
                            .frame(height: 60)
                            .overlay(
                                VStack{
                                Text(jsonSimplified[value].name ?? "Unknown Track")
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Text(jsonSimplified[value].artist?.name ?? "Unknown Artist")
                                        .fontWeight(.light)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                    
                                }
                            )
                        
                        Rectangle()
                            .foregroundColor(currentColor)
                            .frame(height: 60)
                            .overlay(
                                Text("Play Count: \(jsonSimplified[value].playcount ?? "Unknown")")
                                            .fontWeight(.light)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                            )
                        
                    }
                }
            }
        }
     
    }
}
