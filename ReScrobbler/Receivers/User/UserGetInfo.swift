//
//  UserGetInfo.swift
//  ReScrobbler
//
//  Created by Mac on 17.09.2021.
//

import Foundation

func getUserInfo(
    user : String
) -> jsonUserGetInfo.jsonStruct?{
    
    let parameters = (
                ("user=" + user.urlEncoded!)
    )
    
    if let jsonFromInternet = try? JSONDecoder().decode(jsonUserGetInfo.jsonStruct.self, from:getJSONFromUrl("user.getInfo" + "&" + parameters)){
        print("[LOG]:> {\(#file)} Loaded JSON struct from <internet>")
        return jsonFromInternet
    }
    else{
        print("[LOG]:> An error has occured while getting data from Internet.")
        return nil
    }
    
}
