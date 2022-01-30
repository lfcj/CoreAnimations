import UIKit

/// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html
struct Animations {

    typealias KeyPath = String
    typealias Values = [Any]
    typealias KeyTimes = [NSNumber]

    static let gradientLayerKeyPaths = ["colors", "locations", "endPoint", "startPoint"]
    static let shapeLayerKeyPaths = [
        "fillColor",
        "lineDashPhase",
        "lineWidth",
        "miterLimit",
        "strokeColor",
        "strokeStart",
        "strokeEnd"
    ]
    static let textLayerKeyPaths = ["fontSize", "foregroundColor"]
    static let emitterLayerKeyPaths = ["emitterPosition", "emitterPosition.x", "emitterPosition.y", "emitterSize", "emitterSize.width"]
    static let replicatorLayerKeyPaths = ["instanceDelay", "instanceTransform", "instanceRedOffset", "instanceGreenOffset", "instanceColor"]

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
        let showsImage: Bool
        let masksToBounds: Bool

        init(
            _ keyPath: KeyPath,
            _ values: Values,
            _ keyTimes: [NSNumber] = [0, 0.5, 1],
            duration: CFTimeInterval = 1,
            kind: Kind = .keyframe,
            repetitions: Float = 1,
            autoreverses: Bool = false,
            showsImage: Bool = true,
            masksToBounds: Bool = true
        ) {
            self.keyPath = keyPath
            self.values = values
            self.keyTimes = keyTimes
            self.duration = duration
            self.kind = kind
            self.repetitions = repetitions
            self.autoreverses = autoreverses
            self.showsImage = showsImage
            self.masksToBounds = masksToBounds
        }
    }

    var count: Int { properties.count }

    private let properties: [Properties] = [
        Properties("anchorPoint", [CGPoint(x: 0, y: 0.01), CGPoint(x: -0.01, y: 0.0), CGPoint(x: 0.01, y: 0.01)]),
        Properties("anchorPoint.x", [0.2, 0]),
        Properties("anchorPoint.y", [0.2, 0]),
        Properties("backgroundColor", [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor], showsImage: false),
        Properties("borderColor", [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor]),
        Properties("borderWidth", [30, 3, 30]),
        Properties(
            "bounds",
            [
                CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.7)),
                CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.5)),
                CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.8)),
            ]
        ),
        Properties("bounds.size.width", [UIScreen.main.bounds.width * 0.7, UIScreen.main.bounds.width * 0.5, UIScreen.main.bounds.width * 0.8]),
        Properties("bounds.size.height", [UIScreen.main.bounds.height * 0.7, UIScreen.main.bounds.height * 0.5, UIScreen.main.bounds.height * 0.8]),
        Properties("cornerRadius", [30, 100, 50]),
        Properties(
            "contentsRect",
            [
                CGRect(origin: .zero, size: CGSize(width: 200, height: 400)),
                CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.5)),
                CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width * 1.2, height: UIScreen.main.bounds.height * 1.2)),
            ]
        ),
        Properties("hidden", [false, true, false], duration: 1.2),
        Properties("opacity", [0.1, 0.5, 0.1]),
        Properties("position", [CGPoint(x: 250, y: 250), CGPoint(x: 120, y: 220), CGPoint(x: 0, y: 250)]),
        Properties(
            "position.x",
            [
                Int(UIScreen.main.bounds.width * 0.8),
                Int(UIScreen.main.bounds.width * 0.5),
                Int(UIScreen.main.bounds.width * 0.8)
            ],
            duration: 2
        ),
        Properties(
            "position.y",
            [
                Int(UIScreen.main.bounds.width * 0.8),
                Int(UIScreen.main.bounds.width * 0.5),
                Int(UIScreen.main.bounds.width * 0.8)
            ],
            duration: 2
        ),
        Properties("shadowColor", [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor], masksToBounds: false),
        Properties(
            "shadowOffset",
            [CGSize(width: -20, height: -40), CGSize(width: 20, height: 40), CGSize(width: -4, height: -12)],
            duration: 2,
            masksToBounds: false
        ),
        Properties("shadowOpacity", [0.1, 0.5, 1], duration: 0.7, masksToBounds: false),
        Properties(
            "shadowPath",
            [
                UIBezierPath(rect: .zero).cgPath,
                UIBezierPath(
                    rect: CGRect(
                        origin: .zero,
                        size: CGSize(
                            width: UIScreen.main.bounds.height * 0.7,
                            height: UIScreen.main.bounds.height * 0.7
                        )
                    )
                ).cgPath,
                UIBezierPath(rect: .zero).cgPath
            ],
            duration: 1.5,
            masksToBounds: false
        ),
        Properties("shadowRadius", [20, 40, 100], masksToBounds: false),
//        Properties("zPosition", [-5, 20, 5], duration: 1.2), TODO
        // CAGradientLayer
        Properties(
            "colors",
            [
                [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor, #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).cgColor, #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1).cgColor],
                [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor],
                [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor]
            ],
            duration: 2,
            kind: .basic
        ),
        Properties("locations", [[0, 0.2, 0.4], [0.6, 0.8, 1]], duration: 1.5),
        Properties("startPoint", [CGPoint.zero, CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1)], duration: 1.5),
        Properties("endPoint", [CGPoint.zero, CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1)], duration: 1.5),
        // CAShapeLayer
        Properties("fillColor", [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor], duration: 0.9, showsImage: false),
        Properties("lineDashPhase", [0, 25], duration: 0.9, kind: .basic, showsImage: false),
        Properties("miterLimit", [0, 2, 4, 8, 16], duration: 0.9, showsImage: false),
        Properties("lineWidth", [0, 8, 16, 32, 40], showsImage: false),
        Properties("strokeColor", [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor], showsImage: false),
        Properties("strokeStart", [0, 0.2, 0.4, 0.6, 0.8, 1], duration: 2, showsImage: false),
        Properties("strokeEnd", [0, 0.2, 0.4, 0.6, 0.8, 1, 1.2, 1.4, 1.6, 1.8, 2, 2.2, 2.4, 2.6, 2.8, 3], duration: 2, showsImage: false),
        // CATextLayer
        Properties("fontSize", [20, 40, 80, 70, 60], duration: 1, repetitions: 1),
        Properties("foregroundColor",  [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor]),
        // CAEmitterLayer
        //Properties("emitterPosition", [CGPoint(x: 300, y: 600), CGPoint(x: 0.1, y: 0.1), CGPoint(x: 80, y: 50)]), // TODO
        //Properties("emitterPosition.x", [200, 500, 0, 100]), // TODO
        //Properties("emitterPosition.y", [0, 100, 200, 300, 400, 500, 600]), // TODO
        //Properties("emitterSize", [CGSize(width: 20, height: 40), CGSize(width: 200, height: 400), CGSize(width: 4, height: 12)]), //TODO
        // CAReplicatorLayer
        Properties("instanceDelay", stride(from: 10, to: 1000, by: 5).map { 1 / $0 }, duration: 1, showsImage: false),
        Properties(
            "instanceTransform",
            [
                CATransform3DMakeRotation(-CGFloat.pi * 2 / CGFloat(10), 1, 0, 0),
                CATransform3DMakeRotation(-CGFloat.pi * 2 / CGFloat(10), 0, 1, 0),
                CATransform3DMakeRotation(-CGFloat.pi * 2 / CGFloat(10), 1, 0, 0),
                CATransform3DMakeRotation(-CGFloat.pi * 2 / CGFloat(10), 0, 1, 0),
                CATransform3DMakeRotation(-CGFloat.pi * 2 / CGFloat(20), 1, 0, 1),
                CATransform3DMakeRotation(-CGFloat.pi * 2 / CGFloat(20), 0, 1, 1),
                CATransform3DMakeRotation(-CGFloat.pi * 2 / CGFloat(20), 1, 0, 1),
                CATransform3DMakeRotation(-CGFloat.pi * 2 / CGFloat(20), 0, 1, 1),
            ],
            duration: 3,
            showsImage: false
        ),
        Properties("instanceColor", [UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.purple.cgColor], duration: 2, showsImage: false),
        Properties("instanceRedOffset", stride(from: 1, to: 100, by: 1).map { 1 / $0 }, duration: 2, showsImage: false),
        Properties("instanceGreenOffset", stride(from: 1, to: 100, by: 1).map { 1 / $0 }, duration: 2, showsImage: false),
        // CATransform3D
        Properties("transform.scale.x", [1.0, 1.2, 1.0]),
        Properties("transform.scale.y", [1.0, 1.2, 1.0]),
        //Properties("transform.scale.z", [1.0, 1.2, 1.0]), // TODO
        Properties("transform.scale", [1.0, 1.2, 1.0]),
        Properties("transform.translation.x", [50.0, 20, 100]),
        Properties("transform.translation.y", [50.0, 20, 100]),
        Properties("transform.translation.z", [50.0, 20, 100]),
        //Properties("transform.translation", [50.0, 20, 50]), // TODO
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

    func showsImage(at index: Int) -> Bool {
        guard index < count else {
            return true
        }

        return properties[index].showsImage
    }

    func masksToBounds(at index: Int) -> Bool {
        guard index < count else {
            return true
        }

        return properties[index].masksToBounds
    }

    func code(at index: Int) -> String {
        guard index < properties.count else {
            return "No animation at index: \(index)"
        }

        let property = properties[index]
        switch property.kind {
        case .basic:
            return
"""
let animation = CABasicAnimation(keyPath: \(property.keyPath))
animation.fromValue = \(String(describing: property.values.first))
animation.toValue = \(String(describing: property.values.last))
animation.duration = \(property.duration)
animation.repeatCount = \(property.repetitions)
return animation
"""
        case .keyframe:
            return
"""
let animation = CAKeyframeAnimation(keyPath: \(property.keyPath))
animation.values = \(property.values)
animation.keyTimes = \(property.keyTimes)
animation.duration = \(property.duration)
animation.repeatCount = \(property.repetitions)
return animation
"""
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
