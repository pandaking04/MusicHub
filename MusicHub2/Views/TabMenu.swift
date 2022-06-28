//
//  TabMenu.swift
//  MusicHub2
//
//  Created by suranaree06 on 10/5/2565 BE.
//

import SwiftUI

struct TabMenu: View {
    init(){
        UITabBar.appearance().backgroundColor = UIColor.gray
    }
    var body: some View {
        TabView{
            Music()
                .tabItem {
                    Image(systemName: "music.note"); Text("Music")
                }
            Search()
            .tabItem {
                Image(systemName: "magnifyingglass"); Text("Genre")
            }
           Favorite()
            .tabItem {
                Image(systemName: "heart"); Text("Favorite")
            }
            Profile()
            .tabItem {
                Image(systemName: "person.crop.circle.fill"); Text("Profile")
            }
        }
    }
}

struct TabMenu_Previews: PreviewProvider {
    static var previews: some View {
        TabMenu()
    }
}
