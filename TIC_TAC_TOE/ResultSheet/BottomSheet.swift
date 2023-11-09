//
//  BottomSheet.swift
//  TIC_TAC_TOE
//
//  Created by milad marandi on 11/2/23.
//

import SwiftUI


struct BottomSheet: View {
    
    var winner:player = .computer
    @Binding var Reset:[status?]
    @Environment(\.dismiss) var dismissed
    
    var body: some View {
        VStack{
            Animation( winner == .player ? "winner": "lost")
                .scaledToFit()
                .scaleEffect(winner == .player ? 1.0 : 0.5)
                .offset(y: winner == .player ? -100: 0)
            Group{
                Button(action: {
                    Reset = [status?](repeating: nil, count: 9)
                    dismissed()
                }, label: {
                    Text("Play")
                        .foregroundStyle(Color(UIColor.label))
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.green)
                        .clipShape(.capsule)
                })
                
            }
        }
    }
}

/*#Preview {
    BottomSheet()
}*/
