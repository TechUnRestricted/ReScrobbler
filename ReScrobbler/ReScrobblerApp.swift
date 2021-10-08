//
//  ReScrobblerApp.swift
//  ReScrobbler
//
//  Created on 22.06.2021.
//

import SwiftUI

let apiKey = "66d51d73097fc26c35b98daafb7e95ac"
let baseUrl = "https://ws.audioscrobbler.com/2.0/?api_key=" + apiKey + "&format=json&method="

let defaults = UserDefaults.standard

let fileManager = try? FileManager.default.url(for: .documentDirectory,
                                          in: .userDomainMask,
                                          appropriateFor: nil,
                                          create: false)


extension UserDefaults {
    static func resetDefaults() {
        /**
         Function to reset all settings  (defaults)
         in application.
         
         */
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}

extension Color {
    static var random: Color {
        /**
         Function for random color generation.
         */
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1)
    }
}

enum ApiError: Error {
    /**
     Dummy throwable error.
     */
    
    case connectionFailure
}

extension String {
    var withoutHtmlTags: String {
        /**
         Remove all HTML tags from String
         */
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    var urlEncoded: String? {
        /**
         Make String escaped for URL (example: Hello World -> Hello%20World)
         */
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    var convertToDuration: String {
        /**
        Converting track duration from Last.fm API ms to the MM:SS format.
         */
        let duration : Int = Int(self) ?? 0
        var min : Int = 0
        var sec : Int = 0

        min = duration / (60 * 1000)
        sec = (duration % (60 * 1000)) / 1000

        return String(format: "%02d:%02d", min, sec)
    }
    
    var roundedWithAbbreviations: String {
        /**
         Round numbers and add "M" or "K" (millions and thousands)
         at the end of each number.
         */
        
        let number = Double(self) ?? 0
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

func getJSONFromUrl(_ method : String) throws -> Data{
    /**
     Getting JSON from Internet
     */
    
    print("[[[::URL::]]] >> \(baseUrl + method)")
    
    guard let data = try? Data(contentsOf: URL(string: (baseUrl + method))!) else {
        throw ApiError.connectionFailure
    }
    return data
}


func scream() -> String {
    /**
     Dummy function for debugging.
     */
    
    let randomDebugValue = arc4random()
    print("[SCREAM -> \(randomDebugValue)]")
    return " [SCREAM -> \(randomDebugValue)] "
}

func toggleSidebar() {
    /**
     "Collapse/Expand" feature for Sidebar
     */
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

@main
struct ReScrobblerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(
                minWidth: 680,
                idealWidth: 960,
                maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                minHeight: 420,
                idealHeight: 510,
                maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }.commands {
            
            CommandGroup(after: .systemServices) {
                Button(action: {
                    UserDefaults.resetDefaults()
                    if let jsonFolder = fileManager?.appendingPathComponent("jsonStructures"){
                    try? FileManager.default.removeItem(at: jsonFolder)
                    }
                    print("Reset complete.")
                }) {
                    Text("Reset all Settings")
                    
                }
            }
            
        }
    }
    
    
    
}
