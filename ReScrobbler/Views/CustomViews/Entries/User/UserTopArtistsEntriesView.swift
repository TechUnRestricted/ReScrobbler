//
//  UserTopArtistsEntriesView.swift
//  ReScrobbler
//
//  Created by Mac on 16.09.2021.
//

import SwiftUI

fileprivate var chosenArtistName : String = ""

fileprivate let vGridLayout = [
    GridItem(.flexible(maximum: 80), spacing: 0),
    GridItem(.flexible(maximum: 500), spacing: 0),
    GridItem(.flexible(), spacing: 0)
]

struct UserTopArtistsEntriesView: View{
    @Binding var userNameInput : String
    @Binding var limit : Int
    @StateObject var receiver = UserTopArtists()
    
    @State var showingModal = false

    var body: some View{
        if (receiver.data == nil){
            HStack(spacing: 10){
                Text("Loading...")
                ProgressView()
            }
        }
        LazyVGrid(columns: vGridLayout, spacing: 0) {
            if let json = receiver.data, let jsonSimplified = json.topartists?.artist{
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
                                Text(jsonSimplified[value].name ?? "Unknown Artist")
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            )
                        
                        Rectangle()
                            .foregroundColor(currentColor)
                            .frame(height: 40)
                            .overlay(
                                Text("Play Count: \(jsonSimplified[value].playcount ?? "Unknown")")
                                            .fontWeight(.light)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                            )
                        
                    }.onTapGesture{
                        if let artistName = jsonSimplified[value].name{
                            print("Pressing -> \(artistName)")
                            chosenArtistName = artistName
                            showingModal = true
                        }
                        
                    }
                }
            }
        }.sheet(
            isPresented: $showingModal,
            content: {ArtistInfoPopUp(chosenArtistName: chosenArtistName, showingModal: $showingModal) }
        )
        .onAppear(perform: {
            if receiver.data == nil{
            receiver.getData(user: userNameInput)
            }
        })
        .onChange(of: userNameInput, perform: { value in
            receiver.data = nil
            receiver.getData(user: value)
        })
    }
}
