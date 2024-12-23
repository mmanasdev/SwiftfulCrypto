//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Miguel Mañas Alvarez on 22/12/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []

    
    @Published var coin: CoinModel
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailDataService
            .$coinDetails
            .combineLatest($coin)
            .map({ coinDetailModel, coinModel -> (overview: [StatisticModel], additional: [StatisticModel]) in
                return ([], [])
            })
            .sink { returnedArrays in
                
            }
            .store(in: &cancellables)
    }
}
