//
//  UserTopAlbums.swift
//  ReScrobbler
//
//  Created by Mac on 07.09.2021.
//

import SwiftUI


struct UserTopAlbumsView: View {
    @State var userNameInput : String = ""
    @State var confirmedUserNameInput : String = ""
    
    var body: some View {
        
        ScrollView(.vertical){
            VStack{
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
                if confirmedUserNameInput != ""{
                    UserTopAlbumsGridEntriesView(userNameInput: confirmedUserNameInput)
                }
            }.padding()
        }
    }
    
}


struct UserTopAlbums_Previews: PreviewProvider {
    static var previews: some View {
        UserTopAlbumsView()
    }
}
