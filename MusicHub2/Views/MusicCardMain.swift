//
//  MusicCardMain.swift
//  MusicHub2
//
//  Created by suranaree06 on 12/5/2565 BE.
//

import SwiftUI

struct MusicCardMain: View {
    var body: some View {
        VStack{
            Image("san").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            Text("Light").font(.system(size: 20)).foregroundColor(Color.black).bold().padding(.top,8)
                Text("San Holo")
                    .font(.system(size: 13)).foregroundColor(Color.gray).bold().padding(.top,8)
                    
           
        }
    }
}

struct MusicCardMain_Previews: PreviewProvider {
    static var previews: some View {
        MusicCardMain()
    }
}
