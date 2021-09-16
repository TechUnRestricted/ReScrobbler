//
//  ArtistGetInfo.swift
//  ReScrobbler
//
//  Created by Mac on 15.09.2021.
//

import Foundation

func getArtistInfo(
    artist : String? = nil,
    mbid : String? = nil,
    lang : String? = nil,
    autocorrect : Int? = nil,
    username : String? = nil
) -> jsonArtistGetInfo.jsonStruct?{
    /**
        Getting info about single artist from Internet
     */
    
    let parameters = (
                ((artist      != nil) ? ("artist="      + String(artist!).urlEncoded!   + "&") : "") +
                ((mbid        != nil) ? ("mbid="    + String(mbid!).urlEncoded!         + "&") : "") +
                ((lang        != nil) ? ("lang="        + String(lang!)                 + "&") : "") +
                ((autocorrect != nil) ? ("autocorrect=" + String(autocorrect!)          + "&") : "") +
                ((username    != nil) ? ("username="    + String(username!).urlEncoded! + "&") : "")
    )
    
    if let jsonFromInternet = try? JSONDecoder().decode(jsonArtistGetInfo.jsonStruct.self, from:getJSONFromUrl("artist.getInfo" + "&" + parameters)){
        print("[LOG]:> {ArtistInfoPopUpView} Loaded JSON struct from <internet>")
        
        return jsonFromInternet
    }
    else{
        print("[LOG]:> An error has occured while getting data from Internet.")
    }
    return nil
}