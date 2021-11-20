import UIKit

/// See comments in https://luisacastano.com/pages/ca-text-layer-animations.html
final class CATextLayerForegroundColorViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // STEP 1: CREATE LAYER
        func makeTextLayer() -> CATextLayer {
            let layer = CATextLayer()
            layer.string = "Be great"
            layer.frame = CGRect(x: 20, y: 20, width: 250, height: 80)
            layer.fontSize = 60
            layer.font = UIFont.boldSystemFont(ofSize: 60)
            layer.foregroundColor = UIColor.yellow.cgColor
            return layer
        }

        // STEP 2: CREATE THE ANIMATION
        func makeForegroundColorAnimation() -> CAKeyframeAnimation {
            let animation = CAKeyframeAnimation(keyPath: "foregroundColor")
            let colors: [UIColor] = [.yellow, .green, .orange]
            animation.values = colors.map { $0.cgColor }
            animation.keyTimes = [0, 0.5, 1]
            animation.duration = 1
            animation.repeatCount = .infinity
            return animation
        }

        // Step 3: Put it all together inside a view
        let animationView = UIView()
        animationView.frame = CGRect(origin: CGPoint(x: 20, y: 80), size: CGSize(width: 300, height: 400))
        animationView.backgroundColor = .black

        let textLayer = makeTextLayer()
        animationView.layer.addSublayer(textLayer)

        let animation = makeForegroundColorAnimation()
        textLayer.add(animation, forKey: "foregroundColor")

        self.view.addSubview(animationView)
    }
}
