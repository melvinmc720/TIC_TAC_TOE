import Foundation
import SwiftUI
import Lottie
import UIKit

struct Animation:UIViewRepresentable{
    typealias UIViewType = UIView
    
    var animationFile:String
    
    init(_ animationFile: String) {
        self.animationFile = animationFile
    }
    
    func makeUIView(context: UIViewRepresentableContext<Animation> ) -> UIView{
        let view = UIView(frame: .zero)
        let lottie = LottieAnimationView()
        lottie.animation = LottieAnimation.named(self.animationFile)
        lottie.loopMode = .loop
        lottie.contentMode = .scaleAspectFit
        lottie.play()
        lottie.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottie)
        NSLayoutConstraint.activate([
            lottie.widthAnchor.constraint(equalTo: view.widthAnchor),
            lottie.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // do nothing
    }
    
    
}
