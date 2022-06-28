//
//  ContentView.swift
//  MusicHub2
//
//  Created by suranaree06 on 3/5/2565 BE.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel:DataModel
    var body: some View {
        if dataModel.isLogin{
            TabMenu()
        }else{
            Login()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
