//
//  UserTopAlbumsReceiver.swift
//  ReScrobbler
//
//  Created on 15.09.2021.
//

import Foundation

func getUserTopTracks(
    user : String,
    period : String? = nil,
    limit : Int? = nil,
    page : Int? = nil
) -> jsonUserGetTopTracks.jsonStruct?{
    
    let parameters = (
                ("user=" + user.urlEncoded! + "&") +
                ((period != nil) ? ("period="  + String(period!) + "&") : "") +
                ((limit  != nil) ? ("limit="   + String(limit!)  + "&") : "") +
                ((page   != nil) ? ("page="    + String(page!)   + "&") : "")
    )
    
    if let jsonFromInternet = try? JSONDecoder().decode(jsonUserGetTopTracks.jsonStruct.self, from:getJSONFromUrl("user.getTopTracks" + "&" + parameters)){
        print("[LOG]:> {UserTopTracksView} Loaded JSON struct from <internet>")
        return jsonFromInternet
    }
    else{
        print("[LOG]:> An error has occured while getting data from Internet.")
        return nil
    }
    
}
