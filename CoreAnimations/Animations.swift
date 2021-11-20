import UIKit

/// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html
struct Animations {

    typealias KeyPath = String
    typealias Values = [Any]
    typealias KeyTimes = [NSNumber]

    static let gradientLayersKeyPaths = ["colors", "locations", "endPoint", "startPoint"]
    static let shapeLayersKeyPaths = [
        "fillColor",
        "lineDashPhase",
        "lineWidth",
        "miterLimit",
        "strokeColor",
        "strokeStart",
        "strokeEnd"
    ]
    static let textLayersKeyPaths = ["fontSize", "foregroundColor"]

    enum Kind {
        case keyframe
        case basic
    }

    struct Properties {
        let keyPath: KeyPath
        let values: Values
        let keyTimes: KeyTimes
        let duration: CFTimeInterval
        let kind: Kind
        let repetitions: Float
        let autoreverses: Bool

        init(
            _ keyPath: KeyPath,
            _ values: Values,
            _ keyTimes: [NSNumber] = [0, 0.5, 1],
            duration: CFTimeInterval = 0.3,
            kind: Kind = .keyframe,
            repetitions: Float = 5,
            autoreverses: Bool = false
        ) {
            self.keyPath = keyPath
            self.values = values
            self.keyTimes = keyTimes
            self.duration = duration
            self.kind = kind
            self.repetitions = repetitions
            self.autoreverses = autoreverses
        }
    }

    var count: Int { properties.count }

    private let properties: [Properties] = [
        Properties("anchorPoint", [CGPoint(x: 0, y: 0), CGPoint(x: 0.1, y: 0.1), CGPoint(x: 0, y: 0)]),
        Properties("backgroundColor", [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor]),
        Properties("backgroundFilters", [/*todo*/]),
        Properties("borderColor", [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor]),
        Properties("borderWidth", [10, 3, 10]),
        Properties("bounds", [CGRect.zero, CGRect(origin: .zero, size: CGSize(width: 1000, height: 1000)), CGRect.zero]),
        Properties("cornerRadius", [30, 100, 50]),
        Properties(
            "contentsRect",
            [
                CGRect(origin: .zero, size: CGSize(width: 200, height: 200)),
                CGRect(origin: .zero, size: CGSize(width: 100, height: 100)),
                CGRect(origin: .zero, size: CGSize(width: 50, height: 200)),
            ]
        ),
        Properties("hidden", [true, false, true], duration: 1.2),
        Properties("opacity", [0.1, 0.5, 0.1], duration: 0.7),
        Properties("position", [CGPoint(x: 250, y: 250), CGPoint(x: 120, y: 220), CGPoint(x: 0, y: 250)]),
        Properties("shadowColor", [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor]),
        Properties("shadowOffset", [CGSize(width: -5, height: -10), CGSize(width: 5, height: 10), CGSize(width: -1, height: -3)]),
        Properties("shadowOpacity", [0.1, 0.5, 1], duration: 0.7),
        Properties("shadowPath", [UIBezierPath(rect: .zero).cgPath, UIBezierPath(rect: CGRect(origin: .zero, size: CGSize(width: 400, height: 400))).cgPath, UIBezierPath(rect: .zero).cgPath], duration: 1.5),
        Properties("shadowRadius", [10, 20, 50], duration: 0.7),
        Properties("zPosition", [-5, 20, 5], duration: 1.2),
        // CAGradientLayer
        Properties(
            "colors",
            [
                [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor, #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).cgColor, #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1).cgColor],
                [#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor, #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor]
            ],
            duration: 1,
            kind: .basic
        ),
        Properties("locations", [[0, 0.2, 0.4], [0.6, 0.8, 1]], duration: 1.5),
        Properties("startPoint", [CGPoint.zero, CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1)], duration: 1.5),
        Properties("endPoint", [CGPoint.zero, CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1)], duration: 1.5),
        // CAShapeLayer
        Properties("fillColor", [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor], duration: 0.9),
        Properties("lineDashPhase", [0, 25], duration: 0.9, kind: .basic),
        Properties("miterLimit", [0, 2, 4, 8, 16], duration: 0.9),
        Properties("lineWidth", [0, 2, 4, 8, 10]),
        Properties("strokeColor", [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor]),
        Properties("strokeStart", [0, 0.2, 0.4, 0.6, 0.8, 1]),
        Properties("strokeEnd", [0, 0.2, 0.4, 0.6, 0.8, 1]),
        // CATextLayer
        Properties("fontSize", [20, 40, 80]),
        Properties("foregroundColor",  [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor]),
        // CATransform3D
        Properties("transform.scale.x", [1.0, 1.2, 1.0]),
        Properties("transform.scale.y", [1.0, 1.2, 1.0]),
        Properties("transform.scale.z", [1.0, 1.2, 1.0]),
        Properties("transform.scale", [1.0, 1.2, 1.0]),
        Properties("transform.translation.x", [10.0, 20, 10]),
        Properties("transform.translation.y", [10.0, 20, 10]),
        Properties("transform.translation.z", [10.0, 20, 10]),
        Properties("transform.translation", [10.0, 20, 10]),
        Properties("transform.rotation.y", [1.0, 1.5, 1.0]),
        Properties("transform.rotation.x", [1.0, 1.5, 1.0]),
        Properties("transform.rotation.z", [1.0, 1.5, 1.0]),
        Properties("transform.rotation", [1.0, 1.5, 1.0]),
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

        let property = properties[index]
        switch property.kind {
        case .keyframe:
            return makeAnimation(properties: property)
        case .basic:
            return makeBasicAnimation(properties: property)
        }
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
