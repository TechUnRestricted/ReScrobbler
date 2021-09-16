//
//  TagsTopEntriesView.swift
//  ReScrobbler
//
//  Created on 15.09.2021.
//

import SwiftUI

fileprivate let vGridLayout = [
    GridItem(.flexible(maximum: 80), spacing: 0),
    GridItem(.flexible(), spacing: 0)
]

struct TagsTopEntries: View {
    var limit : Int
    
    var body: some View {
        VStack{
            if let json = getChartTagsTop(limit: limit), let jsonSimplified = json.tags?.tag{
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
                                .frame(height: 40)
                                .overlay(
                                    Text("\(value+1)")
                                        .font(.title2)
                                )
                            
                            Rectangle()
                                .foregroundColor(currentColor)
                                .frame(height: 40)
                                .overlay(
                                    VStack{
                                        Text(jsonSimplified[value].name ?? "Unknown")
                                            .bold()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                    }
                                )
                            
                        }
                    }
                }
            }
        }
    }
}
