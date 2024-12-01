//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Miguel Mañas Alvarez on 16/11/24.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
