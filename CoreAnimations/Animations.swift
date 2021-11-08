import UIKit

/// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html
struct Animations {

    typealias KeyPath = String
    typealias Values = [Any]
    typealias KeyTimes = [NSNumber]

    struct Properties {
        let keyPath: KeyPath
        let values: Values
        let keyTimes: KeyTimes
        let duration: CFTimeInterval
        let repetitions: Float

        init(_ keyPath: KeyPath, _ values: Values, _ keyTimes: [NSNumber] = [0, 0.5, 1], _ duration: CFTimeInterval = 0.3, _ repetitions: Float = 5) {
            self.keyPath = keyPath
            self.values = values
            self.keyTimes = keyTimes
            self.duration = duration
            self.repetitions = repetitions
        }
    }

    var count: Int { properties.count }

    private let properties: [Properties] = [
        Properties("anchorPoint", [CGPoint(x: 0, y: 0), CGPoint(x: 0.1, y: 0.1), CGPoint(x: 0, y: 0)]),
        Properties("backgroundColor", [UIColor.systemRed.cgColor, UIColor.systemYellow.cgColor, UIColor.systemGreen.cgColor]),
        Properties("backgroundFilters", [/*todo*/]),
        Properties("borderColor", [UIColor.systemRed.cgColor, UIColor.systemYellow.cgColor, UIColor.systemGreen.cgColor]),
        Properties("transform.scale", [1.0, 1.2, 1.0]),
        Properties("transform.rotation.y", [1.0, 1.5, 1.0]),
        Properties("transform.rotation.x", [1.0, 1.5, 1.0]),
        Properties("transform.rotation.z", [1.0, 1.5, 1.0]),
    ]

    func name(at index: Int) -> String? {
        guard index < count else {
            return nil
        }
        return properties[index].keyPath
    }

    func animation(at index: Int) -> CAPropertyAnimation? {
        guard index < count else {
            return nil
        }

        return makeAnimation(properties: properties[index])
    }

    func makeAnimation(properties: Properties) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: properties.keyPath)
        animation.values = properties.values
        animation.keyTimes = properties.keyTimes
        animation.duration = properties.duration
        animation.repeatCount = properties.repetitions
        return animation
    }

    func makeBasicAnimation(properties: Properties) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: properties.keyPath)
        animation.fromValue = properties.values.first
        animation.toValue = properties.values.last
        animation.duration = properties.duration
        animation.repeatCount = properties.repetitions
        return animation
    }

}
