//
//  TrackGetInfo.swift
//  ReScrobbler
//
//  Created by Mac on 27.09.2021.
//

import Foundation

class TrackInfo: ObservableObject{
    @Published var data : jsonTrackGetInfo.jsonStruct?

    func getData(
        track : String? = nil,
        artist : String? = nil,
        mbid : String? = nil,
        /*lang : String? = nil,*/
        autocorrect : Int? = nil,
        username : String? = nil
    )/* -> jsonTrackGetInfo.jsonStruct?*/{
        /**
            Getting info about single track from Internet
         */
        DispatchQueue.global(qos: .background).async {

        let parameters = (
                    ((track       != nil) ? ("track="        + String(track!).urlEncoded!    + "&") : "") +
                    ((artist      != nil) ? ("artist="      + String(artist!).urlEncoded!   + "&") : "") +
                    ((mbid        != nil) ? ("mbid="        + String(mbid!).urlEncoded!     + "&") : "") +
                    ((autocorrect != nil) ? ("autocorrect=" + String(autocorrect!)          + "&") : "") +
                    ((username    != nil) ? ("username="    + String(username!).urlEncoded! + "&") : "")
        )
        
        if let jsonFromInternet = try? JSONDecoder().decode(jsonTrackGetInfo.jsonStruct.self, from:getJSONFromUrl("track.getInfo" + "&" + parameters)){
            print("[LOG]:> {TrackGetInfo} Loaded JSON struct from <internet>.")
            
            DispatchQueue.main.async {
                self.data = jsonFromInternet
            }
            
        }
        else{
            print("[LOG]:> {TrackGetInfo} An error has occured while getting data from <internet>.")
        }
        }
    }

}

