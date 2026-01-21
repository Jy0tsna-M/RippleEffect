
import SwiftUI

@available(iOS 17.0, *)
struct RippleTouchModifier: ViewModifier {
    var progress: CGFloat
    var origin: CGPoint

    func body(content: Content) -> some View {
        content
            .distortionEffect(
                ShaderLibrary.ripple(
                    .float2(origin),
                    .float(Double(progress)),
                    .float(1.0)
                ),
                maxSampleOffset: CGSize(width: 60, height: 60)
            )
    }
}

extension View {
    @available(iOS 17.0, *)
    func rippleTouchEffect(progress: CGFloat, origin: CGPoint) -> some View {
        modifier(RippleTouchModifier(progress: progress, origin: origin))
    }
}

final class TouchRippleModel: ObservableObject {
    @Published var origin: CGPoint = .zero
    @Published var progress: CGFloat = 0
    @Published var isActive: Bool = false

    func trigger(at point: CGPoint) {
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
