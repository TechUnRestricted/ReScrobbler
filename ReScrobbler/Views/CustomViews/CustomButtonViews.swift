//
//  CustomButtonViews.swift
//  ReScrobbler
//
//  Created by Mac on 27.08.2021.
//

import SwiftUI


struct ActionButton: View {
    var title: String
    //var image: Image?
    var action: () -> Void
    @Binding var currentTab : String
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(minWidth: 10, maxWidth: .infinity, minHeight: 35, maxHeight: 35, alignment: .center)
                .contentShape(Rectangle())
                .background(currentTab == title ? Color.gray.opacity(0.2) : .clear)
                .cornerRadius(6)
            
        }.buttonStyle(PlainButtonStyle())
    }
}

struct ColoredRoundedButton: View {
    var title: String
    var action: () -> Void
    var color: Color
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15))
                .fontWeight(.ultraLight)
                .frame(minWidth: 50)
                .padding(4.5)
                .contentShape(Rectangle())
                .background(color.opacity(0.4))
                .clipShape(Capsule())
            
        }.buttonStyle(PlainButtonStyle())
    }
}

struct SimilarArtistButton: View {
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