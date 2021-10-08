//
//  TagInfoPopUpView.swift
//  ReScrobbler
//
//  Created by Mac on 08.10.2021.
//

import SwiftUI

struct TagInfoPopUpView: View {
    var chosenTag : String
    @Binding var showingModal : Bool
    @StateObject var receiver = TagInfo()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                if (receiver.data == nil){
                    VStack{
                        Spacer()
                        HStack(spacing: 10){
                            Text("Loading...")
                            ProgressView()
                        }
                        Spacer()
                    }
                }
                ZStack{
                    Text(chosenTag)
                        .font(.largeTitle)
                    HStack{
                        Spacer()
                        ColoredRoundedButton(title: "Close", action:{showingModal = false}, color: Color.purple)
                    }
                }
                if let tagInfo = receiver.data?.tag?.wiki?.content{
                    Text(tagInfo.withoutHtmlTags)
                }
                else{
                    Text("No information")
                }
            }.padding()
        }
        .frame(minWidth: 700, minHeight: 320)
        .onAppear(perform: {
            if receiver.data == nil{
                receiver.getData(tag: chosenTag)
            }
        })
    }
}

struct TagInfoPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        //TagInfoPopUpView()
        EmptyView()
    }
}
