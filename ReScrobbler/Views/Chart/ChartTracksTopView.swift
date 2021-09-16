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
                TracksTopEntries(limit: 100)
            }
        }
    }
    
}


