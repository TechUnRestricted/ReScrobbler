//
//  UserTopAlbumsReceiver.swift
//  ReScrobbler
//
//  Created on 15.09.2021.
//

import Foundation

class UserTopAlbums: ObservableObject{
    @Published var data : jsonUserGetTopAlbums.jsonStruct?
    
    func getData(
        user : String,
        period : String? = nil,
        limit : Int? = nil,
        page : Int? = nil
    )/* -> jsonUserGetTopAlbums.jsonStruct?*/{
        
        DispatchQueue.global(qos: .background).async {
        let parameters = (
                    ("user=" + user.urlEncoded! + "&") +
                    ((period != nil) ? ("period="  + String(period!) + "&") : "") +
                    ((limit  != nil) ? ("limit="   + String(limit!)  + "&") : "") +
                    ((page   != nil) ? ("page="    + String(page!)   + "&") : "")
        )
        
        if let jsonFromInternet = try? JSONDecoder().decode(jsonUserGetTopAlbums.jsonStruct.self, from:getJSONFromUrl("user.getTopAlbums" + "&" + parameters)){
            print("[LOG]:> {UserTopAlbumsView} Loaded JSON struct from <internet>")
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
