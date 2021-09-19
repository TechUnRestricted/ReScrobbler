//
//  UserGetInfo.swift
//  ReScrobbler
//
//  Created by Mac on 17.09.2021.
//

import Foundation
class UserInfo: ObservableObject{
    @Published var data : jsonUserGetInfo.jsonStruct?
    
    func getData(
        user : String
    )/* -> jsonUserGetInfo.jsonStruct?*/{
        
        DispatchQueue.global(qos: .background).async {
            let parameters = (
                ("user=" + user.urlEncoded!)
            )
            
            if let jsonFromInternet = try? JSONDecoder().decode(jsonUserGetInfo.jsonStruct.self, from:getJSONFromUrl("user.getInfo" + "&" + parameters)){
                print("[LOG]:> {\(#file)} Loaded JSON struct from <internet>")
                DispatchQueue.main.async {
                    self.data = jsonFromInternet
                }
                
            }
            else{
                print("[LOG]:> An error has occured while getting data from Internet.")
            }
        }
    }
}


