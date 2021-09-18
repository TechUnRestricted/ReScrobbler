//
//  UserTopArtistsView.swift
//  ReScrobbler
//
//  Created by Mac on 16.09.2021.
//

import SwiftUI


struct UserTopArtistsView: View {
    @State var userNameInput : String = ""
    @State var confirmedUserNameInput : String = ""
    var username : String

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
                    UserTopArtistsEntriesView(userNameInput: $confirmedUserNameInput, limit: .constant(100))
                }
                else if username != ""{
                    UserTopArtistsEntriesView(userNameInput: .constant(username), limit: .constant(100))
                }
            }
        }
    }
}

struct UserTopArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        UserTopArtistsView(username: "eminem")
    }
}
