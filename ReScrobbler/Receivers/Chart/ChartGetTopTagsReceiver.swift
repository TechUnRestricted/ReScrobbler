//
//  ChartGetTopTags.swift
//  ReScrobbler
//
//  Created on 15.09.2021.
//

import Foundation

class ChartTopTags: ObservableObject{
    @Published var data : jsonChartGetTopTags.jsonStruct?
    
    func getData(
        page : String? = nil,
        limit : Int? = nil
    )/* -> jsonChartGetTopTags.jsonStruct?*/{
        /**
         Getting data from URL (online) or from Container data (offline)
         */
        
        DispatchQueue.global(qos: .background).async {
            let parameters = (
                ((page   != nil) ? ("page="    + String(page!)   + "&") : "") +
                    ((limit  != nil) ? ("limit="   + String(limit!)  + "&") : "")
            )
            
            let jsonFolder = fileManager?.appendingPathComponent("jsonStructures")
            let jsonFile = jsonFolder?.appendingPathComponent("ChartTagsTop.json")
            
            func loadFromInternet() -> jsonChartGetTopTags.jsonStruct?{
                if let jsonFromInternet = try? JSONDecoder().decode(jsonChartGetTopTags.jsonStruct.self, from:getJSONFromUrl("chart.getTopTags" + "&" + parameters)){
                    print("[LOG]:> {TagsTopView} Loaded JSON struct from <internet>")
                    if let encoded = try? JSONEncoder().encode(jsonFromInternet) {
                        if let jsonFile = jsonFile{
                            do {
                                try encoded.write(to: jsonFile)
                                print("[LOG]:> JSON <ChartTagsTop.json> has been saved.")
                                
                            } catch {
                                print("[ERROR]:> Can't write <ChartTagsTop.json>. {Message: \(error)}")
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
                    let json = try JSONDecoder().decode(jsonChartGetTopTags.jsonStruct.self, from: Data(contentsOf: jsonFile))
                    print("[LOG]:> Loaded local JSON struct from <ChartTagsTop.json>.")
                    DispatchQueue.main.async {
                        self.data = json
                    }
                }
                catch{
                    print("[ERROR]:> Can't load <ChartTagsTop.json> from App Container. {Message: \(error)}")
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
