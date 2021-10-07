//
//  MyLoveViewModel.swift
//  AnimalSeaCreatures


import Foundation
import Combine

class MyLoveViewModel: ObservableObject {
    
    @Published var myLoveData: [FishData] = []
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name("refresh"), object: nil)
    }
    
    @objc func loadData() {
        myLoveData = FishDataManager.shared.fetchAll() ?? []
    }
    
}

