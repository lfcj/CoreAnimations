import UIKit

final class ViewController: UIViewController {

    private let image = #imageLiteral(resourceName: "animation")
    private let animations = Animations()

    private lazy var animationPickerView = makePickerView()
    private lazy var imageView = makeImageView()
    private lazy var gradientLayer = makeGradientLayer()
    private lazy var shapeLayer = makeShapeLayer()
    private lazy var startAnimationButton = makeButton()
    
    private var animatableViews: [UIView] {
        [imageView, startAnimationButton]
    }

    private var layers: [CALayer] {
        [gradientLayer, shapeLayer]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        imageView.layer.insertSublayer(gradientLayer, at: 0)
        imageView.layer.insertSublayer(shapeLayer, at: 1)
        layers.forEach{ $0.isHidden = true }
        imageView.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath
    }

    @objc private func animate() {
        animatableViews.forEach { $0.layer.removeAllAnimations() }
        let currentIndex = animationPickerView.selectedRow(inComponent: 0)
        guard let animation = animations.animation(at: currentIndex) else {
            return
        }

        animateLayerIfPossible(gradientLayer, animation: animation, keyPaths: Animations.gradientLayersKeyPaths)
        animateLayerIfPossible(shapeLayer, animation: animation, keyPaths: Animations.shapeLayersKeyPaths)
        animatableViews.forEach { $0.layer.add(animation, forKey: animation.keyPath) }
    }

    func animateLayerIfPossible<Layer: CALayer>(_ layer: Layer, animation: CAPropertyAnimation, keyPaths: [String]) {
        guard let keyPath = animation.keyPath, keyPaths.contains(keyPath) else {
            layer.isHidden = true
            return
        }

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
        layer.path = UIBezierPath(ovalIn: imageView.bounds).cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 20
        layer.fillColor = UIColor.red.cgColor
        layer.lineDashPattern = [10, 5, 5, 5]
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
