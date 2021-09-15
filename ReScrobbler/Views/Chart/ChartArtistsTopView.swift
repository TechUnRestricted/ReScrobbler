//
//  ArtistsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI

fileprivate var chosenArtistName : String = ""

struct ChartArtistsTopView: View {
    @State var showingModal = false
    var body: some View {
        ScrollView(.vertical){
            VStack{
                
                if let json = getChartArtistsTop(limit: 100){
                    if let jsonSimplified = json.artists?.artist{
                        
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
                            
                            
                        }
                    }
                    
                }
                
                Spacer()
            }
            
        }
        .sheet(
            isPresented: $showingModal,
            content: {ArtistInfoPopUp(chosenArtistName: chosenArtistName, showingModal: $showingModal) }
        )
    }
}


