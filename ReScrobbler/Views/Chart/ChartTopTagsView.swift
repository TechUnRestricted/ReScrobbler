//
//  TagsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI


struct ChartTopTagsView: View {
    
    var body: some View {
        ScrollView(.vertical){

            VStack{
                ChartTopTagsEntriesView(limit: 100)
            }
        }
        
    }
}







