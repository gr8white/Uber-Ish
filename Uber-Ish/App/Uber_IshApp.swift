//
//  Uber_IshApp.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/4/23.
//

import SwiftUI
import Firebase

@main
struct Uber_IshApp: App {
    @StateObject var locationSearchViewModel = LocationSearchViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationSearchViewModel)
        }
    }
}
