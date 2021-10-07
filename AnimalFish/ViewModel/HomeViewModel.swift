//
//  HomeViewModel.swift
//  AnimalSeaCreatures

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var fishies: [Value] = []
    var cancellationToken: [AnyCancellable] = []
    
    init() {
        loadData()
    }
        
    func loadData() {
        let token = APIManager.shared.loadSeaFeature()
            .sink(receiveCompletion: { completion in
                print(completion)
            }) { (seaFeature) in
                self.fishies =
                    seaFeature
                        .map({ $0.value })
                        .sorted(by: { $0.id < $1.id })
        }
        cancellationToken += [token]
    }
    
    
    

}

