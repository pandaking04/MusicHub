//
//  CardView.swift
//  MusicHub2
//
//  Created by suranaree06 on 17/6/2565 BE.
//

import SwiftUI

struct CardView: View {
    
    var genre: String
    var body: some View {
        HStack(alignment: .center){
            Spacer()
            VStack(alignment: .center){
                Text(genre).font(.system(size: 26, weight: .bold, design: .default)).foregroundColor(Color.white)
            }.padding(.trailing,20)
            Spacer()
            
        }.frame(width: .infinity, alignment: .center)
            .background(Color.gray)
            .padding(.all,30)
    }
}



