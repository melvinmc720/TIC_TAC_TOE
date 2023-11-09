import SwiftUI
import UIKit
import Foundation


extension ContentView{
    
     func ChangingTurn(){
        player.toggle()
        computer.toggle()
    }
    
     func IsThisplaceOcuupied(_ position:Int) -> Bool{
        return positions.map{$0?.place}.contains(position)
    }
    
    
     func adding_position(player:player , position:Int){
        positions[position] = status(place: position, player: player)
    }
    
     func computerMove() -> Int {
        let WinningModes:Set<Set<Int?>> = [[0,4,8] , [0,3,6] , [0,1,2] , [1,4,7] , [2,5,8] , [2,4,6] , [3,4,5] , [6,7,8]]
        
        let computer = positions.filter({$0?.player == .computer})
        let Csituations = computer.map{$0?.place}
         
        
        let human = positions.filter({$0?.player == .player})
        let Hsituations = human.map{$0?.place}
        
        for pattern in WinningModes{
            let position = pattern.subtracting(Csituations)
            if position.count == 1{
                let available = !IsThisplaceOcuupied(position.first!!)
                if available{
                    return position.first!!
                }
            }
        }
        
        for pattern in WinningModes{
            let position = pattern.subtracting(Hsituations)
            if position.count == 1{
                let available = !IsThisplaceOcuupied(position.first!!)
                if available{
                    return position.first!!
                }
            }
        }
        
        
        var position = Int.random(in: 0..<9)
        while IsThisplaceOcuupied(position){
            position = Int.random(in: 0..<9)
            if (!IsThisplaceOcuupied(position)){
                break
            }
        }
        return position
    }
    
    func Winner() -> player {
        let WinningModes:Set<Set<Int?>> = [[0,4,8] , [0,3,6] , [0,1,2] , [1,4,7] , [2,5,8] , [2,4,6] , [3,4,5] , [6,7,8]]
        
        let human = positions.filter({$0?.player == .player})
        let Hsituations = human.map{$0?.place}
        
        let computer = positions.filter({$0?.player == .computer})
        let Csituations = computer.map{$0?.place}
        
        for mode in WinningModes{
            if mode.isSubset(of: Set(Hsituations)){
                return .player
            }
            else if mode.isSubset(of: Set(Csituations)){
                return .computer
            }
            else{
                continue
            }
        }
        
        return .undefined
    }
}
