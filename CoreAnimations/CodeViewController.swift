import UIKit

final class CodeViewController: UIViewController {

    private lazy var closeButton = makeCloseButton()
    private lazy var codeLabel = makeCodeLabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        addConstraints()
    }

}

private extension CodeViewController {

    func makeCloseButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.remove, for: .normal)
        button.tintColor = .secondaryLabel
        button.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        return button
    }

    func makeCodeLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = .lightGray.withAlphaComponent(0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =
"""
let gradient = CAGradientLayer()
gradient.frame = imageView.bounds
gradient.colors = [#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor , #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor]
gradient.startPoint = CGPoint(x: 0, y: 0)
gradient.endPoint = CGPoint(x: 1, y: 1)
gradient.locations =  [0, 0.5, 1]
return gradient
"""
        label.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        return label
    }
 
    func addViews() {
        view.addSubview(closeButton)
        view.addSubview(codeLabel)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([

            closeButton.heightAnchor.constraint(equalToConstant: 48),
            closeButton.widthAnchor.constraint(equalToConstant: 48),
            closeButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            closeButton.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),

            codeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            codeLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            codeLabel.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor, constant: -24),
            codeLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
            
        ])
    }

}

// MARK: - Actions

@objc extension CodeViewController {

    func close(_ sender: UIButton) {
        dismiss(animated: false)
    }

}
