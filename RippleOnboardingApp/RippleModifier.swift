
import SwiftUI

// MARK: - Ripple Touch View Modifier (iOS 17+)
/// Applies a shader-based distortion that radiates from a touch point.
///  The effect is driven entirely by an external progress value.

@available(iOS 17.0, *)
struct RippleTouchModifier: ViewModifier {
    // Controls how far the ripple has expanded
    var progress: CGFloat
    var origin: CGPoint

    func body(content: Content) -> some View {
        content
            // Shader-based distortion for smooth GPU animation
            .distortionEffect(
                ShaderLibrary.ripple(
                    .float2(origin),
                    .float(Double(progress)),
                    .float(1.0)
                ),
                // Keeps the effect performant and visually tight
                maxSampleOffset: CGSize(width: 60, height: 60)
            )
    }
}

// MARK: - View Convenience API
/// Makes the ripple modifier read naturally at the call site.

extension View {
    @available(iOS 17.0, *)
    func rippleTouchEffect(
        progress: CGFloat,
        origin: CGPoint
    ) -> some View {
        modifier(
            RippleTouchModifier(
                progress: progress,
                origin: origin
            )
        )
    }
}

// MARK: - Touch Ripple Model
/// Manages ripple lifecycle: start, animate, and reset.
/// Kept separate from the view to keep rendering declarative.

final class TouchRippleModel: ObservableObject {

    @Published var origin: CGPoint = .zero
    @Published var progress: CGFloat = 0
    @Published var isActive: Bool = false

    // Triggers a new ripple from a given touch point
    func trigger(at point: CGPoint) {
        // Reset state for a fresh ripple
        origin = point
        progress = 0
        isActive = true
        withAnimation(.easeOut(duration: 0.6)) {
            progress = 1.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.isActive = false
            self.progress = 0
        }
    }
}
