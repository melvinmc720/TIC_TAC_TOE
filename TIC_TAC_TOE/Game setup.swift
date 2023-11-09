import Foundation
import SwiftUI
import UIKit

enum player{
    case player
    case computer
    case undefined
}


struct status:Hashable{
    var place:Int
    var player:player
    var indicator:String{
        return player == .player ? "xmark.circle.fill" : "circle.circle.fill"
    }
    var color:Color {
        return player == .player ? .green : .red
    }
}
