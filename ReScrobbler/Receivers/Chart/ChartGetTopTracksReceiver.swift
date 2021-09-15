//
//  ChartGetTopTracksReceiver.swift
//  ReScrobbler
//
//  Created on 15.09.2021.
//

import Foundation

func getChartTracksTop(
    page : String? = nil,
    limit : Int? = nil
) -> jsonChartGetTopTracks.jsonStruct?{
    /**
        Getting data from URL (online) or from Container data (offline)
     */
    
    let parameters = (
                ((page   != nil) ? ("page="    + String(page!)   + "&") : "") +
                ((limit  != nil) ? ("limit="   + String(limit!)  + "&") : "")
    )
    
    let jsonFolder = fileManager?.appendingPathComponent("jsonStructures")
    let jsonFile = jsonFolder?.appendingPathComponent("ChartTracksTop.json")
    
     func loadFromInternet() -> jsonChartGetTopTracks.jsonStruct?{
        if let jsonFromInternet = try? JSONDecoder().decode(jsonChartGetTopTracks.jsonStruct.self, from:getJSONFromUrl("chart.getTopTracks" + "&" + parameters)){
            print("[LOG]:> {TracksTopView} Loaded JSON struct from <internet>")
            if let encoded = try? JSONEncoder().encode(jsonFromInternet) {
                if let jsonFile = jsonFile{
                    do {
                        try encoded.write(to: jsonFile)
                        print("[LOG]:> JSON <ChartTracksTop.json> has been saved.")

                    } catch {
                        print("[ERROR]:> Can't write <ChartTracksTop.json>. {Message: \(error)}")
                    }
                }
            }
            return jsonFromInternet
        }
        else{
            print("[LOG]:> An error has occured while getting data from Internet.")
            return nil
        }
    }
    
    do {
        if let jsonFolder = jsonFolder{
            try FileManager.default.createDirectory(atPath: jsonFolder.path, withIntermediateDirectories: true, attributes: nil)
            print("[LOG]:> Folder <jsonStructures> has been created.")
        }
    } catch {
        print("[ERROR]:> Can't create folder <jsonStructures>. {Message: \(error)}")
    }
    
    print(jsonFolder?.path ?? "[[Can't get path]]")

    if let jsonFile = jsonFile, FileManager.default.fileExists(atPath: jsonFile.path) {

        do{
            let json = try JSONDecoder().decode(jsonChartGetTopTracks.jsonStruct.self, from: Data(contentsOf: jsonFile))
            print("[LOG]:> Loaded local JSON struct from <ChartTracksTop.json>.")
            return json
        }
        catch{
            print("[ERROR]:> Can't load <ChartTracksTop.json> from App Container. {Message: \(error)}")
            return loadFromInternet()
        }
    }
    else{
       return loadFromInternet()
    }
}
