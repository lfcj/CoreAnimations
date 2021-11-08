import UIKit

final class ViewController: UIViewController {

    private let image = #imageLiteral(resourceName: "animation")
    private let animations = Animations()

    private lazy var animationPickerView = makePickerView()
    private lazy var imageView = makeImageView()
    private lazy var startAnimationButton = makeButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
    }

    @objc private func animate() {
        imageView.layer.removeAllAnimations()
        let currentIndex = animationPickerView.selectedRow(inComponent: 0)
        guard let animation = animations.animation(at: currentIndex) else {
            return
        }
        imageView.layer.add(animation, forKey: nil)
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
        return pickerView
    }

    func makeImageView() -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }

    func makeButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start animation", for: .normal)
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }
}
