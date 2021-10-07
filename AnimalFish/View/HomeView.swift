//
//  HomeView.swift
//  AnimalSeaCreatures


import SwiftUI
import ASCollectionView
import Combine

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3), content: {
                    ForEach(viewModel.fishies, id: \.name) { fish in
                        NavigationLink(destination: FishDetailView(seaFeature: fish, hide: false)) {
                            FishView(fish: fish)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                })
                .background(Color.init(red: 187/255, green: 1, blue: 1))
                .navigationBarTitle("鱼图鉴", displayMode: .inline)
            })
            
//            ASCollectionView(data: viewModel.fishies, dataID: \.name) { item, _ in
//                NavigationLink(destination: FishDetailView(seaFeature: item, hide: false)) {
//                    FishView(fish: item)
//                }
//                .buttonStyle(PlainButtonStyle())
//            }
//            .layout {
//                .grid(layoutMode: .adaptive(withMinItemSize: UIScreen.main.bounds.width / 3),
//                      itemSpacing: 5,
//                      lineSpacing: 25,
//                      itemSize: .absolute(UIScreen.main.bounds.width / 3))
//            }
            
        }
        
    }
}
