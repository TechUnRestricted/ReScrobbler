//
//  ColoredRoundedButtonView.swift
//  ReScrobbler
//
//  Created on 15.09.2021.
//

import SwiftUI

struct ColoredRoundedButton: View {
    /**
      Styled Button used for "On Tour" and tags
     */
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
