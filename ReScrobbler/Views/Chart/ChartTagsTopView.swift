//
//  TagsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI


struct ChartTagsTopView: View {
    
    var body: some View {
        ScrollView(.vertical){

            VStack{
                TagsTopEntries(limit: 100)
            }
        }
        
    }
}







