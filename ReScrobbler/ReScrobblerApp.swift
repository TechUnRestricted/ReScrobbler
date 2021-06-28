//
//  ReScrobblerApp.swift
//  ReScrobbler
//
//  Created on 22.06.2021.
//

import SwiftUI

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}

@main
struct ReScrobblerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            //Test()
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.left")
                    })
                }
            }
            
            
        }.commands {
            CommandGroup(after: .systemServices) {
                Button(action: {
                    UserDefaults.resetDefaults()
                    print("Reset complete.")
                }) {
                    Text("Reset all Settings")
                    
                }
            }
            
        }
    }
    func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
