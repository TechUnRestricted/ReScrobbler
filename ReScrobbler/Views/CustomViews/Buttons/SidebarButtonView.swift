//
//  SidebarButtonView.swift
//  ReScrobbler
//
//  Created by Mac on 27.08.2021.
//

import SwiftUI


struct SidebarButton: View {
    /**
      Styled Button used for navigating in Sidebar
     */
    var title: String
    var tag: String
    var image: String
    var action: () -> Void
    @Binding var currentTab : String
    
    var body: some View {

        Button(action: action) {
            HStack{
                Image(systemName: image)
                    .padding(.leading)
                    .frame(width: 25, alignment: .center)
                Text(title)
                    .padding(.leading, 5)
            }.frame(minWidth: 10, maxWidth: .infinity, minHeight: 35, maxHeight: 35, alignment: .leading)
            .contentShape(Rectangle())
            .background(
                /* Change button color on click */
                currentTab == tag ? Color.gray.opacity(0.2) : .clear
            )
            .cornerRadius(6)
            
        }.buttonStyle(PlainButtonStyle())
    }
}
