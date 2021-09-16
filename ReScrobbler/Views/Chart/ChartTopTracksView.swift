//
//  TracksTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI



struct ChartTopTracksView: View {
    
    var body: some View {
        ScrollView(.vertical){
            VStack{
                ChartTopTracksEntriesView(limit: 100)
            }
        }
    }
    
}


