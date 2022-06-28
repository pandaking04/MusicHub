//
//  MusicHub2App.swift
//  MusicHub2
//
//  Created by suranaree06 on 3/5/2565 BE.
//

import SwiftUI
import Firebase
@main
struct MusicHub2App: App {
    
    init(){
        FirebaseApp.configure()
    }
    @StateObject private var dataModel = DataModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(dataModel)
        }
    }
}
