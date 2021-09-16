//
//  UserTopTracksView.swift
//  ReScrobbler
//
//  Created by Mac on 15.09.2021.
//

import SwiftUI

struct UserTopTracksView: View {
    @State var userNameInput : String = ""
    @State var confirmedUserNameInput : String = ""
    
    var body: some View {
        
        ScrollView(.vertical){
            VStack{
                VStack(){
                Text("""
                    Find your stats
                    by your Last.Fm profile
                    username
                    """).multilineTextAlignment(.center)
                    .fixedSize()
                    .font(.system(size: 30))
                    .opacity(0.9)
                
                HStack{
                    TextField("Your Last.Fm profile User Name", text: $userNameInput, onCommit: {
                        confirmedUserNameInput = userNameInput
                    })
                    .frame(maxWidth: 300)
                    
                    Button(action: {
                        confirmedUserNameInput = userNameInput
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                }.padding()
                if confirmedUserNameInput != ""{
                    if let json = getUserTopTracks(user: confirmedUserNameInput, limit: 100), let jsonSimplified = json.toptracks?.track{
                        
                        let vGridLayout = [
                            GridItem(.flexible(maximum: 80), spacing: 0),
                            GridItem(.flexible(maximum: 500), spacing: 0),
                            GridItem(.flexible(), spacing: 0)
                        ]
                        
                        LazyVGrid(columns: vGridLayout, spacing: 0) {
                            ForEach(0 ..< (jsonSimplified.count), id: \.self) { value in
                                let currentColor : Color = {
                                    if (value+1).isMultiple(of: 2){
                                        return Color.gray.opacity(0.1)
                                    } else {
                                        return Color.gray.opacity(0.00001)
                                    }
                                }()
                                
                                Group{
                                    Rectangle()
                                        .foregroundColor(currentColor)
                                        .frame(height: 40)
                                        .overlay(
                                            Text("\(value+1)")
                                                .font(.title2)
                                        )
                                    
                                    Rectangle()
                                        .foregroundColor(currentColor)
                                        .frame(height: 40)
                                        .overlay(
                                            Text(jsonSimplified[value].name ?? "Unknown Track")
                                                .bold()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        )
                                    
                                    Rectangle()
                                        .foregroundColor(currentColor)
                                        .frame(height: 40)
                                        .overlay(
                                                    Text((jsonSimplified[value].artist?.name) ?? "Unknown Artist")
                                                        .fontWeight(.light)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        )
                                    
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
}

struct UserTopTracksView_Previews: PreviewProvider {
    static var previews: some View {
        UserTopTracksView()
    }
}
