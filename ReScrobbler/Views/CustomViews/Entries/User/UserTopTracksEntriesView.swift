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
    @Binding var userNameInput : String
    @Binding var limit : Int
    @StateObject var receiver = UserTopTracks()
    
    var body: some View{
        
        if (receiver.data == nil){
            HStack(spacing: 10){
                Text("Loading...")
                ProgressView()
            }
        }
        
        LazyVGrid(columns: vGridLayout, spacing: 0) {
            if let json = receiver.data, let jsonSimplified = json.toptracks?.track{
                
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
        .onAppear(perform: {
            if receiver.data == nil{
            receiver.getData(user: userNameInput)
            }
        })
        .onChange(of: userNameInput, perform: { value in
            receiver.data = nil
            receiver.getData(user: value)
        })
        
    }
}
