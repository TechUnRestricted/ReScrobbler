//
//  SimilarArtistButtonView.swift
//  ReScrobbler
//
//  Created on 15.09.2021.
//

import SwiftUI

struct SimilarArtistButton: View {
    /**
     Styled buttons for Similar Artists in info pop up
     */
    
    var artistName: String
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
                Text(artistName)
                    .padding([.top, .bottom, .trailing])
                Spacer()
            }
                
            .frame(minWidth: 50, maxWidth: .infinity)
                //.padding(4.5)
                .contentShape(Rectangle())
                .background(color.opacity(0.4))
                .clipShape(Capsule())
            
        }.buttonStyle(PlainButtonStyle())
    }
}
