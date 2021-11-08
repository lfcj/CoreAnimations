import UIKit

/// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html
struct Animations {

    typealias KeyPath = String
    typealias Values = [Any]

    var count: Int { propertiesAndValues.count }

    private static let keyTimes:  [NSNumber] = [0, 0.5, 1]
    private static let shortDuration: CFTimeInterval = 0.3
    private static let repetitions: Float = 5

    private let propertiesAndValues: [(keyPath: KeyPath, values: Values)] = [
        ("transform.scale", [1.0, 1.2, 1.0]),
        ("transform.rotation.y", [1.0, 1.5, 1.0]),
        ("transform.rotation.x", [1.0, 1.5, 1.0]),
        ("transform.rotation.z", [1.0, 1.5, 1.0]),
    ]

    func name(at index: Int) -> String? {
        guard index < count else {
            return nil
        }
        return propertiesAndValues[index].keyPath
    }

    func animation(at index: Int) -> CAKeyframeAnimation? {
        guard index < count else {
            return nil
        }

        let propertyAndValues = propertiesAndValues[index]
        return makeAnimation(keyPath: propertyAndValues.keyPath, values: propertyAndValues.values)
    }

    func makeAnimation(
        keyPath: KeyPath,
        values: Values? = nil,
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
}
