import UIKit

final class ViewController: UIViewController {

    private let image = #imageLiteral(resourceName: "animation")
    private let animations = Animations()

    private lazy var animationPickerView = makePickerView()
    private lazy var imageView = makeImageView()
    private lazy var gradientLayer = makeGradientLayer()
    private lazy var shapeLayer = makeShapeLayer()
    private lazy var textLayer = makeTextLayer()
    private lazy var emitterLayer = makeEmitterLayer()
    private lazy var startAnimationButton = makeButton()
    
    private var animatableViews: [UIView] {
        [imageView, startAnimationButton]
    }

    private var layers: [CALayer] {
        [gradientLayer, shapeLayer, textLayer, emitterLayer]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        imageView.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath
    }

    @objc private func animate() {
        animatableViews.forEach { $0.layer.removeAllAnimations() }
        let currentIndex = animationPickerView.selectedRow(inComponent: 0)
        guard let animation = animations.animation(at: currentIndex) else {
            return
        }

        layers.forEach { $0.removeFromSuperlayer() }
        animateLayerIfPossible(gradientLayer, animation: animation, keyPaths: Animations.gradientLayerKeyPaths)
        animateLayerIfPossible(shapeLayer, animation: animation, keyPaths: Animations.shapeLayerKeyPaths)
        animateLayerIfPossible(textLayer, animation: animation, keyPaths: Animations.textLayerKeyPaths)
        animateLayerIfPossible(emitterLayer, animation: animation, keyPaths: Animations.emitterLayerKeyPaths)
        animatableViews.forEach { $0.layer.add(animation, forKey: animation.keyPath) }
    }

    func animateLayerIfPossible<Layer: CALayer>(_ layer: Layer, animation: CAPropertyAnimation, keyPaths: [String]) {
        guard let keyPath = animation.keyPath, keyPaths.contains(keyPath) else {
            return
        }

        imageView.layer.addSublayer(layer)
        layer.removeAllAnimations()
        layer.isHidden = false
        layer.add(animation, forKey: keyPath)
    }

}

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        animations.count
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        50
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        animations.name(at: row)
    }

}

// MARK: - View Configuration

private extension ViewController {

    func addViews() {
        view.addSubview(animationPickerView)
        view.addSubview(imageView)
        view.addSubview(startAnimationButton)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            animationPickerView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 30),
            animationPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationPickerView.heightAnchor.constraint(equalToConstant: 120),
            animationPickerView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            animationPickerView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20),

            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            startAnimationButton.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor, constant: -30),
            startAnimationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startAnimationButton.widthAnchor.constraint(equalToConstant: 150),
            startAnimationButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

}

// MARK: - Factory

private extension ViewController {

    func makePickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.layer.cornerRadius = 12
        return pickerView
    }

    func makeImageView() -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .yellow
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: -1, height: 3)
        imageView.layer.shadowRadius = 10
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.main.scale
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = false

//        let background = CATextLayer()
//        background.string = "background"
//        background.backgroundColor = UIColor.red.cgColor
//        background.alignmentMode = .center
//        background.fontSize = 96
//        background.frame = CGRect(x: 10, y: 10, width: 250, height: 160)
//
//        let foreground = CATextLayer()
//        foreground.string = "foreground"
//        foreground.backgroundColor = UIColor.blue.cgColor
//        foreground.alignmentMode = .center
//        foreground.fontSize = 48
//        foreground.opacity = 0.5
//        foreground.frame = CGRect(x: 20, y: 20, width: 200, height: 60)
//        foreground.masksToBounds = true

//        if let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: [kCIInputRadiusKey: 2]) {
//            foreground.backgroundFilters = [blurFilter]
//        }
//
//        imageView.layer.addSublayer(background)
//        background.addSublayer(foreground)

        return imageView
    }

    func makeGradientLayer()-> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        gradient.colors = [#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor , #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.locations =  [0, 0.5, 1]
        return gradient
    }

    
    func makeShapeLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.frame = imageView.bounds
        layer.path = UIBezierPath(
            roundedRect: imageView.bounds,
            byRoundingCorners: [.bottomLeft, .topRight],
            cornerRadii: CGSize(width: 100, height: 50)).cgPath
        //let circle = UIBezierPath(ovalIn: imageView.bounds).cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 20
        layer.fillColor = UIColor.red.cgColor
        layer.lineDashPattern = [10, 5]
        layer.lineJoin = .miter
        return layer
    }

    func makeTextLayer() -> CATextLayer {
        let layer = CATextLayer()
        layer.string = "Be great"
        layer.frame = CGRect(x: 20, y: 20, width: 250, height: 80)
        layer.fontSize = 60
        layer.font = UIFont.boldSystemFont(ofSize: 60)
        layer.foregroundColor = #colorLiteral(red: 0.951250835, green: 0.9686274529, blue: 0.1545007536, alpha: 1).cgColor
        return layer
    }

    func makeEmitterLayer() -> CAEmitterLayer {
        let layer = CAEmitterLayer()
        layer.frame = CGRect(x: 20, y: 20, width: 250, height: 80)
        layer.emitterPosition = CGPoint(x: 320, y: 320)
        layer.emitterShape = .circle

        let cell = CAEmitterCell()
        cell.birthRate = 2
        cell.lifetime = 10
        cell.velocity = 200
        cell.scale = 0.05

        cell.emissionRange = CGFloat.pi * 2.0
        cell.contents = #imageLiteral(resourceName: "animation").cgImage

        layer.emitterCells = [cell]
        return layer
    }

    func makeButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start animation", for: .normal)
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.systemGreen, for: .highlighted)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }
}
