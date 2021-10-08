//
//  TagGetInfo.swift
//  ReScrobbler
//
//  Created by Mac on 08.10.2021.
//

import Foundation

class TagInfo: ObservableObject{
    @Published var data : jsonTagGetInfo.jsonStruct?

    func getData(
        lang : String? = nil,
        tag : String

    )/* -> jsonTagGetInfo.jsonStruct?*/{
        /**
            Getting info about single Tag from Internet
         */
        DispatchQueue.global(qos: .background).async {

        let parameters = (
                    ((lang      != nil) ? ("lang=" + String(lang!).urlEncoded! + "&") : "") +
                    (                     ("tag="  + tag.urlEncoded!           + "&"))
                    
        )
        
        if let jsonFromInternet = try? JSONDecoder().decode(jsonTagGetInfo.jsonStruct.self, from:getJSONFromUrl("tag.getInfo" + "&" + parameters)){
            print("[LOG]:> {TagGetInfo} Loaded JSON struct from <internet>.")
            
            DispatchQueue.main.async {
                self.data = jsonFromInternet
            }
            
        }
        else{
            print("[LOG]:> {TagGetInfo} An error has occured while getting data from <internet>.")
        }
        }
    }

}

