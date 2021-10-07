//
//  AlbumGetInfo.swift
//  ReScrobbler
//
//  Created by Mac on 03.10.2021.
//

import Foundation

class AlbumInfo: ObservableObject{
    @Published var data : jsonAlbumGetInfo.jsonStruct?

    func getData(
        artist : String? = nil,
        album : String? = nil,
        mbid : String? = nil,
        /*lang : String? = nil,*/
        autocorrect : Int? = nil,
        username : String? = nil
    )/* -> jsonAlbumGetInfo.jsonStruct?*/{
        /**
            Getting info about single album from Internet
         */
        DispatchQueue.global(qos: .background).async {

        let parameters = (
                    ((artist      != nil) ? ("artist="      + String(artist!).urlEncoded!   + "&") : "") +
                    ((album       != nil) ? ("album="       + String(album!).urlEncoded!    + "&") : "") +
                    ((mbid        != nil) ? ("mbid="        + String(mbid!).urlEncoded!     + "&") : "") +
                    ((autocorrect != nil) ? ("autocorrect=" + String(autocorrect!)          + "&") : "") +
                    ((username    != nil) ? ("username="    + String(username!).urlEncoded! + "&") : "")
        )
        
        if let jsonFromInternet = try? JSONDecoder().decode(jsonAlbumGetInfo.jsonStruct.self, from:getJSONFromUrl("album.getInfo" + "&" + parameters)){
            print("[LOG]:> {AlbumGetInfo} Loaded JSON struct from <internet>.")
            
            DispatchQueue.main.async {
                self.data = jsonFromInternet
            }
            
        }
        else{
            print("[LOG]:> {AlbumGetInfo} An error has occured while getting data from <internet>.")
        }
        }
    }

}

