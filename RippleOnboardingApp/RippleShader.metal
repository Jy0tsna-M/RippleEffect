
#include <metal_stdlib>
using namespace metal;

// A simple radial ripple distortion function for SwiftUI's distortionEffect.
/// - Parameters:
///   - position: The pixel position inside the view.
///   - size: The full size of the view.
///   - progress: 0 -> 1 value that drives the ripple outward.
///   - intensity: Strength of the displacement.
/// - Returns: New position from which the underlying content will be sampled.

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
float2 ripple(float2 position,
              float2 origin,
              float time,
              float amplitude)
{
    float2 diff = position - origin;
    float dist = length(diff);

    if (dist == 0.0) return position;

    float wave = sin(dist * 0.03 - time * 8.0);
    float falloff = exp(-dist * 0.01);
    float offset = wave * falloff * amplitude * 12.0;

    float2 dir = diff / dist;
    return position + dir * offset;
}
