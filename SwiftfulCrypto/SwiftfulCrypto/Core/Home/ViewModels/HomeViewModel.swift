//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Miguel Mañas Alvarez on 1/12/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = [
            StatisticModel(title: "Title", value: "Value", percentageChange: 1),
            StatisticModel(title: "Title", value: "Value"),
            StatisticModel(title: "Title", value: "Value"),
            StatisticModel(title: "Title", value: "Value", percentageChange: -7)
        ]
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
