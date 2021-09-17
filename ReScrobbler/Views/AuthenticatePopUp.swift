//
//  AuthenticatePopUp.swift
//  ReScrobbler
//
//  Created by Mac on 16.09.2021.
//

import SwiftUI

struct AuthenticatePopUp: View {
    @Binding var showingModal : Bool
    @Binding var confirmedUsername : String
    @State var typedUsername : String = ""
    var body: some View {
        VStack(){
            ZStack{
                HStack{
                    ColoredRoundedButton(title: "Close", action:{ showingModal = false}, color: Color.purple)
                    Spacer()
                }
                Text("Sign In")
                    .font(.title)
                
                
            }.padding()
            TextField("Last.Fm Username", text: $typedUsername, onCommit: {
                confirmedUsername = typedUsername
                showingModal = false
                
            })
            .font(.system(size: 22))
            .padding()
            
            Spacer()
            ColoredRoundedButton(title: "Save Settings", action:{
                confirmedUsername = typedUsername
                showingModal = false
            }, color: Color.gray)
            Spacer()
            
        }.frame(minWidth: 590, maxWidth: 590, minHeight: 220, maxHeight: 220)
    }
}

struct AuthenticatePopUp_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatePopUp(showingModal: .constant(true), confirmedUsername: .constant(""))
        
    }
}
