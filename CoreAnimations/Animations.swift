import UIKit

struct Animations {

    typealias KeyPath = String
    typealias Value = [Any]

    private static let keyTimes:  [NSNumber] = [0, 0.5, 1]
    private static let shortDuration: CFTimeInterval = 0.3
    private static let repetitions: Float = 5

    private let propertiesAndValues: [(KeyPath, Value)] = [
    ]

    func makeAnimation(
        keyPath: KeyPath,
        values: Value? = nil,
        keyTimes: [NSNumber] = Self.keyTimes,
        duration: CFTimeInterval = Self.shortDuration,
        repetitions: Float = Self.repetitions
    ) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.values = values
        animation.keyTimes = keyTimes
        animation.duration = duration
        animation.repeatCount = repetitions
        return animation
    }

    func makeAnchorPointAnimation() -> CAKeyframeAnimation {
        makeAnimation(keyPath: "transform.scale", values: [1.0, 1.2, 1.0])
    }

    func makeHorizontalRotationTransform() -> CAKeyframeAnimation {
        makeAnimation(keyPath: "transform.rotation.y", values: [1.0, 1.5, 1.0])
    }

    func makeVerticalRotationTransform() -> CAKeyframeAnimation {
        makeAnimation(keyPath: "transform.rotation.x", values: [1.0, 1.5, 1.0])
    }

    func makeDepthRotationTransform() -> CAKeyframeAnimation {
        makeAnimation(keyPath: "transform.rotation.z", values: [1.0, 1.5, 1.0])
    }
}
