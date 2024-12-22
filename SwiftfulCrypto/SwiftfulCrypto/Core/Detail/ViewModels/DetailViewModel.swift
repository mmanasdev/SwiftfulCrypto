//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Miguel Mañas Alvarez on 22/12/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailDataService
            .$coinDetails
            .sink { returnedDetailCoin in
                
            }
            .store(in: &cancellables)
    }
}
