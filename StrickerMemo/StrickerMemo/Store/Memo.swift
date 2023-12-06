//
//  Memo.swift
//  StrickerMemo
//
//  Created by 송성욱 on 12/6/23.
//

import Foundation
import SwiftUI

struct Memo: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var desc: String
    var date: Date
    var colorIndex: Int = 0
    
    var color: Color {
        get {
        switch colorIndex {
            case 0:
                return .cyan
            case 1:
                return .purple
            case 2:
                return .blue
            case 3:
                return .yellow
            case 4:
                return .brown
            default:
                return .white
            }
        }
        
        set {
            switch newValue {
            case .cyan:
                colorIndex = 0
            case .purple:
                colorIndex = 1
            case .blue:
                colorIndex = 2
            case .yellow:
                colorIndex = 3
            case .brown:
                colorIndex = 4
            default:
                colorIndex = 5
            }
        }
    }
    
    var dateString: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd EE HH:mm"
        return dateFormatter.string(from: date)
    }
}
