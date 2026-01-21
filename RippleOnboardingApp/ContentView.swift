//
//  Contentview.swift
//  RippleOnboardingApp
//
//  Created by SaiJyotsna on 28/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var ripple = TouchRippleModel()

    private let images = ["lion", "tiger", "horse", "wolf"]
    @State private var currentIndex = 0

    var body: some View {
        ZStack {
            if #available(iOS 17.0, *) {
                Image(images[currentIndex])
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .rippleTouchEffect(
                        progress: ripple.isActive ? ripple.progress : 0,
                        origin: ripple.origin
                    )
            } else {
                Image(images[currentIndex])
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded { value in
                    currentIndex = (currentIndex + 1) % images.count
                    ripple.trigger(at: value.location)
                }
        )
    }
}


#Preview {
    ContentView()
}
