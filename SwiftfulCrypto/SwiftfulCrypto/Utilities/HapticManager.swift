//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by Miguel Mañas Alvarez on 14/12/24.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
