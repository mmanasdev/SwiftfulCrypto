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
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins
            .filter {   $0.name.lowercased().contains(lowercasedText) ||
                $0.symbol.lowercased().contains(lowercasedText) ||
                $0.id.lowercased().contains(lowercasedText)
            }
    }
}
