//
//  ChartArtistsTopViewReceiver.swift
//  ReScrobbler
//
//  Created on 15.09.2021.
//

import Foundation

class ChartTopArtists: ObservableObject{
    @Published var data : jsonChartGetTopArtists.jsonStruct?
    
    func getData(
        page : String? = nil,
        limit : Int? = nil
    ){
        
        /**
         Getting data from URL (online) or from Container data (offline)
         */
        
        DispatchQueue.global(qos: .background).async {
            
            let parameters = (
                ((page   != nil) ? ("page="    + String(page!)   + "&") : "") +
                    ((limit  != nil) ? ("limit="   + String(limit!)  + "&") : "")
            )
            
            let jsonFolder = fileManager?.appendingPathComponent("jsonStructures")
            let jsonFile = jsonFolder?.appendingPathComponent("ChartArtistsTop.json")
            
            func loadFromInternet() -> jsonChartGetTopArtists.jsonStruct?{
                
                if let jsonFromInternet = try? JSONDecoder().decode(jsonChartGetTopArtists.jsonStruct.self, from:getJSONFromUrl("chart.getTopArtists" + "&" + parameters)){
                    print("[LOG]:> {ArtistsTopView} Loaded JSON struct from <internet>")
                    if let encoded = try? JSONEncoder().encode(jsonFromInternet) {
                        if let jsonFile = jsonFile{
                            do {
                                try encoded.write(to: jsonFile)
                                print("[LOG]:> JSON <ChartArtistsTop.json> has been saved.")
                                
                            } catch {
                                print("[ERROR]:> Can't write <ChartArtistsTop.json>. {Message: \(error)}")
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
                    let json = try JSONDecoder().decode(jsonChartGetTopArtists.jsonStruct.self, from: Data(contentsOf: jsonFile))
                    print("[LOG]:> Loaded local JSON struct from <ChartArtistsTop.json>.")
                    DispatchQueue.main.async {
                        self.data = json
                    }
                }
                catch{
                    print("[ERROR]:> Can't load <ChartArtistsTop.json> from App Container. {Message: \(error)}")
                    DispatchQueue.main.async {
                        self.data = loadFromInternet()
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    self.data = loadFromInternet()
                }
                
            }
        }
        
    }
}

