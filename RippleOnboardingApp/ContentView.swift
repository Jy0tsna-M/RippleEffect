//
//  Contentview.swift
//  RippleOnboardingApp
//
//  Created by SaiJyotsna on 28/11/25.
//

import SwiftUI

import SwiftUI

// MARK: - Content View
/// Displays a full-screen image carousel with a touch-triggered ripple effect.
/// Each tap/press advances the image and emits a ripple from the touch point.

struct ContentView: View {

    @StateObject private var ripple = TouchRippleModel()
    private let images = ["lion", "tiger", "horse", "wolf"]
    @State private var currentIndex = 0

    var body: some View {
        ZStack {
            // Falls back gracefully on older OS versions.
            if #available(iOS 17.0, *) {
                Image(images[currentIndex])
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    // Custom ripple shader / modifier
                    .rippleTouchEffect(
                        progress: ripple.isActive ? ripple.progress : 0,
                        origin: ripple.origin
                    )
            } else {
                // Fallback: image-only interaction
                Image(images[currentIndex])
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
        .contentShape(Rectangle())
        // Using DragGesture with zero distance allows us to capture a precise touch location like a tap.
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded { value in
                    // Cycle to the next image
                    currentIndex = (currentIndex + 1) % images.count
                    // Trigger ripple from the exact touch point
                    ripple.trigger(at: value.location)
                }
        )
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
