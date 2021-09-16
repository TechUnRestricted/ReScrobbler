//
//  ArtistsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI



struct ChartTopArtistsView: View {
    var body: some View {
        ScrollView(.vertical){
            VStack(){
                ChartTopArtistsEntriesView(limit: 100)
            }
            
        }
        
    }
}

