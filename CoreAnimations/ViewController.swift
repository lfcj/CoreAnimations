import UIKit

final class ViewController: UIViewController {

    private let image = #imageLiteral(resourceName: "animation")
    private let animations = Animations()

    private lazy var headerLabel = makeHeaderLabel()
    private lazy var pickerTitleLabel = makePickerTitleLabel()
    private lazy var animationPickerView = makePickerView()
    private lazy var imageBackgroundView = makeImageBackgroundView()
    private lazy var imageView = makeImageView()
    private lazy var gradientLayer = makeGradientLayer()
    private lazy var shapeLayer = makeShapeLayer()
    private lazy var textLayer = makeTextLayer()
    private lazy var emitterLayer = makeEmitterLayer()
    private lazy var replicatorLayer = makeReplicatorLayer()
    private lazy var startAnimationButton = makeStartAnimationButton()
    private lazy var seeCodeButton = makeCodeButton()

    private var animatableViews: [UIView] {
        [imageView, imageBackgroundView]
    }

    private var layers: [CALayer] {
        [gradientLayer, shapeLayer, textLayer, emitterLayer, replicatorLayer]
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

        let isImageViewHidden = !animations.showsImage(at: currentIndex)
        let animatedView = isImageViewHidden ? imageBackgroundView : imageView
        imageView.isHidden = isImageViewHidden
        imageView.layer.masksToBounds = animations.masksToBounds(at: currentIndex)
        layers.forEach { $0.removeFromSuperlayer() }
        animateLayerIfPossible(gradientLayer, to: animatedView, animation: animation, keyPaths: Animations.gradientLayerKeyPaths)
        animateLayerIfPossible(shapeLayer, to: animatedView, animation: animation, keyPaths: Animations.shapeLayerKeyPaths)
        animateLayerIfPossible(textLayer, to: animatedView, animation: animation, keyPaths: Animations.textLayerKeyPaths)
        animateLayerIfPossible(emitterLayer, to: animatedView, animation: animation, keyPaths: Animations.emitterLayerKeyPaths)
        animateLayerIfPossible(replicatorLayer, to: animatedView, animation: animation, keyPaths: Animations.replicatorLayerKeyPaths)
        animatableViews.forEach { $0.layer.add(animation, forKey: animation.keyPath) }
    }

    @objc private func showCode() {
        let currentIndex = animationPickerView.selectedRow(inComponent: 0)
        let codeViewController = CodeViewController(code: animations.code(at: currentIndex))
        codeViewController.modalPresentationStyle = .formSheet
        present(codeViewController, animated: false)
    }

    func animateLayerIfPossible<Layer: CALayer>(_ layer: Layer, to view: UIView, animation: CAPropertyAnimation, keyPaths: [String]) {
        guard let keyPath = animation.keyPath, keyPaths.contains(keyPath) else {
            return
        }

        view.layer.addSublayer(layer)
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
        view.addSubview(headerLabel)
        view.addSubview(imageBackgroundView)
        view.addSubview(imageView)
        view.addSubview(pickerTitleLabel)
        view.addSubview(animationPickerView)
        view.addSubview(startAnimationButton)
        view.addSubview(seeCodeButton)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 24),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -24),

            imageBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -54),
            imageBackgroundView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            imageBackgroundView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            imageBackgroundView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            imageView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor),

            pickerTitleLabel.centerYAnchor.constraint(equalTo: animationPickerView.centerYAnchor),
            pickerTitleLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            pickerTitleLabel.heightAnchor.constraint(equalToConstant: 20),

            animationPickerView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            animationPickerView.leadingAnchor.constraint(equalTo: pickerTitleLabel.trailingAnchor, constant: 8),
            animationPickerView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            animationPickerView.heightAnchor.constraint(equalToConstant: 80),

            startAnimationButton.bottomAnchor.constraint(equalTo: seeCodeButton.topAnchor, constant: -8),
            startAnimationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startAnimationButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            startAnimationButton.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            startAnimationButton.heightAnchor.constraint(equalToConstant: 48),

            seeCodeButton.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor, constant: -16),
            seeCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            seeCodeButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            seeCodeButton.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
        ])

        pickerTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
    }

}

// MARK: - Factory

private extension ViewController {

    func makeHeaderLabel() -> UILabel {
        let label = UILabel()
        label.text = "Core Animations Lab"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Didot", size: 200)
        label.contentMode = .top
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        label.baselineAdjustment = .alignCenters
        return label
    }

    func makePickerTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Select an animation:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }

    func makePickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.layer.cornerRadius = 12
        return pickerView
    }

    func makeImageBackgroundView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func makeImageView() -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .yellow
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: -1, height: 3)
        imageView.layer.shadowRadius = 10
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.main.scale
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true

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
        layer.frame = CGRect(x: 20, y: 20, width: 350, height: 80)
        layer.fontSize = 60
        layer.font = UIFont.boldSystemFont(ofSize: 60)
        layer.foregroundColor = #colorLiteral(red: 0.951250835, green: 0.9686274529, blue: 0.1545007536, alpha: 1).cgColor
        return layer
    }

    func makeEmitterLayer() -> CAEmitterLayer {
        let layer = CAEmitterLayer()
        layer.emitterShape = .line

        let cell = CAEmitterCell()
        cell.birthRate = 2
        cell.lifetime = 1
        cell.velocity = 200
        cell.scale = 0.05

        cell.emissionRange = CGFloat.pi * 2.0
        cell.contents = #imageLiteral(resourceName: "animation").cgImage

        layer.emitterCells = [cell]
        return layer
    }

    func makeReplicatorLayer() -> CAReplicatorLayer {
        let layer = CAReplicatorLayer()
        let width = CGFloat(40)
        layer.frame = CGRect(
            origin: CGPoint(x: imageView.bounds.width / 2 - width, y: imageView.bounds.height / 2 ),
            size: CGSize(width: width * 4, height: width)
        )

        let circle = CALayer()
        circle.frame = CGRect(origin: .zero, size: CGSize(width: width, height: width))
        circle.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        circle.cornerRadius = 1
        circle.position = CGPoint(x: 0, y: 0)
        layer.addSublayer(circle)

        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1
        fadeOut.toValue = 0
        fadeOut.duration = 0.5
        fadeOut.repeatCount = 10
        circle.add(fadeOut, forKey: nil)

        let instanceCount = 4
        layer.instanceCount = instanceCount
        layer.instanceColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        layer.instanceDelay = 1 / CFTimeInterval(instanceCount)

        layer.instanceTransform = CATransform3DTranslate(layer.instanceTransform, width + 4, 0, 0)
        return layer
    }

    func makeStartAnimationButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start animation", for: .normal)
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGreen, for: .highlighted)
        button.backgroundColor = .darkGray
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.cornerRadius = 8
        return button
    }

    func makeCodeButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show animation code", for: .normal)
        button.addTarget(self, action: #selector(showCode), for: .touchUpInside)
        button.setTitleColor(.systemPurple, for: .normal)
        return button
    }

}
