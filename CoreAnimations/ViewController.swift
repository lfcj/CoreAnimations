import UIKit

final class ViewController: UIViewController {

    private let image = #imageLiteral(resourceName: "animation")
    private let animations = Animations()

    private lazy var imageView = makeImageView()
    private lazy var startAnimationButton = makeButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
    }

    @objc private func animate() {
        imageView.layer.removeAllAnimations()
        imageView.layer.add(animations.makeDepthRotationTransform(), forKey: nil)
    }

}

// MARK: - View Configuration

private extension ViewController {

    func addViews() {
        view.addSubview(imageView)
        view.addSubview(startAnimationButton)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            startAnimationButton.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            startAnimationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startAnimationButton.widthAnchor.constraint(equalToConstant: 150),
            startAnimationButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

}

// MARK: - Factory

private extension ViewController {

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
