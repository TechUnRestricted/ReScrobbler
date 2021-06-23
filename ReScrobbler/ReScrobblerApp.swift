//
//  ReScrobblerApp.swift
//  ReScrobbler
//
//  Created on 22.06.2021.
//

import SwiftUI

@main
struct ReScrobblerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.left")
                    })
                }
            }
            
            
        }
    }
    func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
