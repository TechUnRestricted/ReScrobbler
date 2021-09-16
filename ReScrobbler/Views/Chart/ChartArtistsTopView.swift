//
//  ArtistsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI



struct ChartArtistsTopView: View {
    var body: some View {
        ScrollView(.vertical){
            VStack(){
                
                ArtistsTopEntries(limit: 100)

            }
            
        }
        
    }
}

