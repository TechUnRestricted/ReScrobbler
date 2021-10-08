//
//  TracksInAlbumButtonView.swift
//  ReScrobbler
//
//  Created by Mac on 07.10.2021.
//

import SwiftUI

struct TracksInAlbumButton: View {
    /**
     Styled buttons for Similar Artists in info pop up
     */
    var trackName : String
    var trackDurationUnFormatted : Int
    var index: Int
    var action: () -> Void
    var color: Color = Color.pink
    
    var body: some View {
        Button(action: action) {
            HStack{
                Text("\(index)")
                    .font(.title)
                    .fontWeight(.thin)
                    .padding(.horizontal)
                    Spacer()
                Text(trackName)
                    .padding([.top, .bottom, .trailing])
                Spacer()
                Text("\(trackDurationUnFormatted)")
                    .font(.title)
                    .fontWeight(.thin)
                    .padding(.horizontal)
            }
                
            .frame(minWidth: 50, maxWidth: .infinity)
                //.padding(4.5)
                .contentShape(Rectangle())
                .background(color.opacity(0.4))
                .clipShape(Capsule())
            
        }.buttonStyle(PlainButtonStyle())
    }
}


