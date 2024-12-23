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
                
                //overview
                let price = coinModel.currentPrice.asCurrencyWith6Decimals()
                let pricePercentageChange = coinModel.priceChangePercentage24H
                let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentageChange)
                
                let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
                let pricePercentChange = coinModel.marketCapChangePercentage24H
                let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: pricePercentChange)
                
                let rank = "\(coinModel.rank)"
                let rankStat = StatisticModel(title: "Rank", value: rank)
                
                let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
                let volumeStat = StatisticModel(title: "Volume", value: volume)
                
                let overviewArray: [StatisticModel] = [
                    priceStat, marketCapStat, rankStat, volumeStat
                ]

                //additional
                let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
                let highStat = StatisticModel(title: "High", value: high)
                
                let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
                let lowStat = StatisticModel(title: "Low", value: high)
                
                let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
                let pricePercentChange2 = coinModel.priceChangePercentage24H
                let priceChangeStat = StatisticModel(title: "24h Market Cap Change", value: priceChange, percentageChange: pricePercentChange2)
                
                let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
                let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
                let marketCapChangeStat = StatisticModel(title: "24H Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
                
                let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
                let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
                let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
                
                let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
                let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
                
                let additionalArray: [StatisticModel] = [
                    highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
                ]
                
                return (overviewArray, additionalArray)
            })
            .sink { returnedArrays in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
    }
}
