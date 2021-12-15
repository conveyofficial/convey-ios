//
//  LoadingAnimation.swift
//  Convey (iOS)
//
//  Created by Galen Quinn on 8/19/21.
//

import SwiftUI

struct LoadingAnimation: View {
    
    @State var animation = false

    var body: some View {
        
        ZStack {
            
            Color.gray.opacity(0.5).ignoresSafeArea()
        
            VStack {
                
                Circle()
                    .trim(from: 0, to: 0.8)
                    .stroke(Color.blue, lineWidth: 5)
                    .frame(width: 75, height: 75)
                    .rotationEffect(.init(degrees: animation ? 360 : 0))
                    .padding(50)
                
            }
            .onAppear(perform: {
                withAnimation(Animation.linear(duration: 1)) {
                    animation.toggle()
                }
            })
            
            
        }
    }

}
