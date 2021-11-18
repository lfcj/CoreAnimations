import UIKit

final class ViewController: UIViewController {

    private let image = #imageLiteral(resourceName: "animation")
    private let animations = Animations()

    private lazy var animationPickerView = makePickerView()
    private lazy var imageView = makeImageView()
    private lazy var gradientLayer = makeGradientLayer()
    private lazy var startAnimationButton = makeButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        imageView.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.isHidden = true
        imageView.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath
    }

    @objc private func animate() {
        imageView.layer.removeAllAnimations()
        let currentIndex = animationPickerView.selectedRow(inComponent: 0)
        guard let animation = animations.animation(at: currentIndex) else {
            return
        }

        animateColorsIfPossible(animation)
        imageView.layer.add(animation, forKey: animation.keyPath)
        startAnimationButton.layer.add(animation, forKey: animation.keyPath)
    }

    func animateColorsIfPossible(_ animation: CAPropertyAnimation) {
        guard animation.keyPath == "colors" else {
            gradientLayer.isHidden = true
            return
        }

        gradientLayer.isHidden = false
        gradientLayer.add(animation, forKey: animation.keyPath)
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

// MARK: - CAAnimationDelegate

extension ViewController: CAAnimationDelegate {

    func animationDidStart(_ anim: CAAnimation) {}

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {}

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
        gradient.colors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor, #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).cgColor , #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x:0.0, y:0.5)
        gradient.endPoint = CGPoint(x:1.0, y:0.5)
        gradient.locations =  [-0.5, 1.5]
        return gradient
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
