//
//  UserGetTopArtistsReceiver.swift
//  ReScrobbler
//
//  Created by Mac on 16.09.2021.
//

import Foundation

class UserTopArtists: ObservableObject{
    @Published var data : jsonUserGetTopArtists.jsonStruct?
    
    func getData(
        user : String,
        period : String? = nil,
        limit : Int? = nil,
        page : Int? = nil
    )/* -> jsonUserGetTopArtists.jsonStruct?*/{
        DispatchQueue.global(qos: .background).async {
            
            let parameters = (
                ("user=" + user.urlEncoded! + "&") +
                    ((period != nil) ? ("period="  + String(period!) + "&") : "") +
                    ((limit  != nil) ? ("limit="   + String(limit!)  + "&") : "") +
                    ((page   != nil) ? ("page="    + String(page!)   + "&") : "")
            )
            
            if let jsonFromInternet = try? JSONDecoder().decode(jsonUserGetTopArtists.jsonStruct.self, from:getJSONFromUrl("user.getTopArtists" + "&" + parameters)){
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


