//
//  ArtistsTopEntriesView.swift
//  ReScrobbler
//
//  Created on 15.09.2021.
//

import SwiftUI

fileprivate var chosenArtistName : String = ""

fileprivate let vGridLayout = [
    GridItem(.flexible(maximum: 80), spacing: 0),
    GridItem(.flexible(), spacing: 0),
    GridItem(.flexible(), spacing: 0),
    GridItem(.flexible(), spacing: 0)
]

struct ChartTopArtistsEntriesView: View {
    @State var showingModal = false
    
    var limit : Int
    
    var body: some View{
        VStack{
            if let json = getChartArtistsTop(limit: limit), let jsonSimplified = json.artists?.artist{
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
                                .frame(height: 50)
                                .overlay(
                                    Text("\(value+1)")
                                        .font(.title2)
                                )
                            
                            Rectangle()
                                .foregroundColor(currentColor)
                                .frame(height: 50)
                                .overlay(
                                    Text(jsonSimplified[value].name ?? "Unknown Tag")
                                        .bold()
                                )
                            
                            Rectangle()
                                .foregroundColor(currentColor)
                                .frame(height: 50)
                                .overlay(
                                    Text("Listeners: \(jsonSimplified[value].listeners?.roundedWithAbbreviations ?? "Unknown")")
                                    
                                )
                            
                            Rectangle()
                                .foregroundColor(currentColor)
                                .frame(height: 50)
                                .overlay(
                                    Text("Play Count: \(jsonSimplified[value].playcount?.roundedWithAbbreviations ?? "Unknown")")
                                )
                            
                        }
                        
                        .onTapGesture{
                            if let artistName = jsonSimplified[value].name{
                                print("Pressing -> \(artistName)")
                                chosenArtistName = artistName
                                showingModal = true
                            }
                            
                        }
                    }
                    
                    
                }.sheet(
                    isPresented: $showingModal,
                    content: {ArtistInfoPopUp(chosenArtistName: chosenArtistName, showingModal: $showingModal) }
                )
            }
        
    }
    
    }
    
}
