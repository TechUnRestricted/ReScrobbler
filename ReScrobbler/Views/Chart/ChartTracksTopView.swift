//
//  TracksTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI


struct ChartTracksTopView: View {
    
    var body: some View {
        ScrollView(.vertical){
            
            VStack{
                if let json = getChartTracksTop(limit: 100){
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

                            }
                            
                            
                        }
                        
                    }
                }
                Spacer()
            }
        }
    }
    
}


