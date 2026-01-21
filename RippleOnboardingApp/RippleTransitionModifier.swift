
import SwiftUI

/// A simple SwiftUI-based "ripple" overlay effect.
/// This does not use Metal, but simulates a ripple-like expansion from the center.
struct RippleOverlay: View {
    var progress: CGFloat
    var color: Color

    var body: some View {
        GeometryReader { proxy in
            let size = max(proxy.size.width, proxy.size.height) * 1.4
            ZStack {
                Circle()
                    .strokeBorder(color.opacity(0.6), lineWidth: 4)
                    .frame(width: size * progress, height: size * progress)
                    .opacity(progress > 0.01 ? 1 : 0)

                Circle()
                    .strokeBorder(color.opacity(0.35), lineWidth: 2)
                    .frame(width: size * max(progress - 0.2, 0), height: size * max(progress - 0.2, 0))
                    .opacity(progress > 0.3 ? 1 : 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scaleEffect(1.05)
            .animation(.easeOut(duration: 0.6), value: progress)
        }
        .allowsHitTesting(false)
    }
}
