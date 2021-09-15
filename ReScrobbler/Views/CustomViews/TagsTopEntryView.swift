//
//  TagsTopEntryView.swift
//  ReScrobbler
//
//  Created on 15.09.2021.
//

import SwiftUI

struct TagsTopEntry: View {
    var index: Int
    var tag: String
    
    var body: some View {
        VStack(){
            Divider()
            HStack{
                Text(String(index))
                    .font(.title2)
                    .frame(width: 80)
                Text(tag)
                    .bold()
                    .frame(width: 600, alignment: .leading)
            }.padding()
        }.lineLimit(1)
        Divider()
    }
}
