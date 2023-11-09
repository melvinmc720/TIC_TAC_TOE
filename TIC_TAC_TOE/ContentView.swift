import SwiftUI



struct ContentView: View {
    
    @State var player:Bool = true
    @State var computer:Bool = false
    @State var positions = [status?](repeating:nil, count: 9)
    @State var DidGameEnd:Bool = false
    @State var winner:player = .undefined
    @AppStorage("Humanwin") var HumanWinCounter = 0
    @AppStorage("Computerwin") var ComputerWinCounter = 0
    
    private let columns:[GridItem] = [GridItem(.flexible()) , GridItem(.flexible()),GridItem(.flexible()) ]
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                GeometryReader(){ geo in
                    Image("background")
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        HStack{
                            Image(systemName: "person.fill")
                            Text("\(HumanWinCounter)")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            Text("\(ComputerWinCounter)")
                                .font(.title)
                                .fontWeight(.bold)
                            Image(systemName: "laptopcomputer")
                        }
                        .foregroundStyle(.black)
                        .padding()
                        Spacer()
                        LazyVGrid(columns: columns,spacing: 15, content: {
                            ForEach(0..<9, id:\.self){ place in
                                ZStack{
                                    Circle()
                                        .fill(positions[place] != nil ? positions[place]?.color ?? .black: .black)
                                        .frame(width: geo.size.width / 3 - 15, height: geo.size.width / 3 - 15, alignment: .center)
                                    Image(systemName:positions[place] != nil ? positions[place]?.indicator ?? " " : "")
                                        .resizable()
                                        .scaledToFit()
                                    
                                }
                                .onTapGesture {
                                    if !IsThisplaceOcuupied(place){
                                        adding_position(player: .player, position: place)
                                        ChangingTurn()
                                    }
                                    if Winner() == .player {
                                        print("congratulation")
                                        DidGameEnd.toggle()
                                        HumanWinCounter += 1
                                        ChangingTurn()
                                        return
                                    }
                                    if (Winner() == .undefined && positions.compactMap({$0}).count == 9){
                                        print("Draw")
                                        DidGameEnd.toggle()
                                        ChangingTurn()
                                        return
                                    }
                                    if (computer){
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                            let move = computerMove()
                                            adding_position(player: .computer, position: move)
                                            if Winner() == .computer {
                                                print("Try again")
                                                ComputerWinCounter += 1
                                                DidGameEnd.toggle()
                                                ChangingTurn()
                                                return
                                            }
                                            if (Winner() == .undefined && positions.compactMap({$0}).count == 9){
                                                print("Draw")
                                                DidGameEnd.toggle()
                                                ChangingTurn()
                                                return
                                            }
                                            ChangingTurn()
                                        })
                                    }
                                }
                            }
                        })

                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    .disabled(DidGameEnd)
                    .sheet(isPresented: $DidGameEnd, content: {
                        BottomSheet(winner: Winner(), Reset: $positions)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.hidden)
                            .interactiveDismissDisabled()
                    })
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarTrailing, content: {
                            Button(action: {
                                print("chekced")
                                DispatchQueue.main.async(execute:{
                                    HumanWinCounter = 0
                                    ComputerWinCounter = 0
                                    DidGameEnd.toggle()
                                    DidGameEnd.toggle()
                                })
                                
                            }, label: {
                                Image(systemName: "repeat")
                            })
                            .tint(.black)
                        })
                    })
                    .padding()
                }
            }
        }
    }                        

}

#Preview {
    ContentView()
}
