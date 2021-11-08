import UIKit

final class ViewController: UIViewController {

    private let image = #imageLiteral(resourceName: "animation")
    private lazy var imageView = makeImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
    }

}

// MARK: - View Configuration

private extension ViewController {

    func addViews() {
        view.addSubview(imageView)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
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

}
