//
//  ProfileIconView.swift
//  ReScrobbler
//
//  Created by Mac on 19.09.2021.
//

import SwiftUI


struct ProfileIconView: View{
    var username : String = ""
    @StateObject var receiver = UserInfo()

    var body: some View{
        VStack{
            if let path = receiver.data?.user?.image?.last?.text, let url = URL(string: path), let image = NSImage(contentsOf: url), username != ""{
                Image(nsImage: image)
                    .resizable()
                    .clipShape(Circle())
                
            }
            else {
                DefaultProfilePictureView()
            }
        }.onAppear(perform: {
            if receiver.data == nil{
                receiver.getData(user: username)
            }
        })
        .onChange(of: username, perform: { chosenUsername in
             receiver.data = nil
             receiver.getData(user: chosenUsername)
        })

    }
}
