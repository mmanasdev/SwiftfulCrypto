//
//  HomeStatsView.swift
//  SwiftfulCrypto
//
//  Created by Miguel Mañas Alvarez on 8/12/24.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeStatsView(showPortolio: .constant(false))
                .environmentObject(dev.homeVM)
        }
    }
}
