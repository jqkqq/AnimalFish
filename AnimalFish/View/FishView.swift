//
//  SeaFeatureView.swift
//  AnimalSeaCreatures


import SwiftUI
import KingfisherSwiftUI

struct FishView: View {
    
    var fish: Value
    
    var body: some View {
        VStack {
            KFImage(URL(string: fish.iconURI))
                .resizable()                
                .placeholder({
                    ProgressView("")
                        .frame(width: 30, height: 30, alignment: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
//                    ActivityIndicator(isAnimating: .constant(true), style: .large)
//                        .frame(width: 30, height: 30, alignment: .center)
//                        .foregroundColor(Color.gray)
                })
                
            if UIDevice.current.userInterfaceIdiom == .phone {
                Text("\(fish.name.nameTWzh)")
            } else {
                Text("\(fish.name.nameTWzh)")
                    .font(.system(size: 30))
            }
            
        }
    }
}
