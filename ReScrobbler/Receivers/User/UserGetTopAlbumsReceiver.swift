//
//  UserTopAlbumsReceiver.swift
//  ReScrobbler
//
//  Created on 15.09.2021.
//

import Foundation

func getUserTopAlbums(
    user : String,
    period : String? = nil,
    limit : Int? = nil,
    page : Int? = nil
) -> jsonUserGetTopAlbums.jsonStruct?{
    
    let parameters = (
                ("user=" + user.urlEncoded! + "&") +
                ((period != nil) ? ("period="  + String(period!) + "&") : "") +
                ((limit  != nil) ? ("limit="   + String(limit!)  + "&") : "") +
                ((page   != nil) ? ("page="    + String(page!)   + "&") : "")
    )
    
    if let jsonFromInternet = try? JSONDecoder().decode(jsonUserGetTopAlbums.jsonStruct.self, from:getJSONFromUrl("user.getTopAlbums" + "&" + parameters)){
        print("[LOG]:> {UserTopAlbumsView} Loaded JSON struct from <internet>")
        return jsonFromInternet
    }
    else{
        print("[LOG]:> An error has occured while getting data from Internet.")
        return nil
    }
    
}
