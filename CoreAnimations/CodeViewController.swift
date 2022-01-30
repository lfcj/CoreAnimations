import UIKit

final class CodeViewController: UIViewController {

    private lazy var closeButton = makeCloseButton()
    private lazy var codeTextView = makeCodeTextView()
    private lazy var copyButton = makeCopyCodeButton()

    private let code: String

    init(code: String) {
        self.code = code
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        code = ""
        super.init(coder: coder)
    }

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
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        return button
    }

    func makeCodeTextView() -> UITextView {
        let textView = UITextView()

        textView.isEditable = false

        let textFont = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        let textColor = UIColor.darkGray

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 10
        paragraphStyle.lineSpacing = 4

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        textView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        textView.translatesAutoresizingMaskIntoConstraints = false

        let text =
"""
let gradient = CAGradientLayer()
gradient.frame = imageView.bounds
gradient.colors = [#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor , #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor]
gradient.startPoint = CGPoint(x: 0, y: 0)
gradient.endPoint = CGPoint(x: 1, y: 1)
gradient.locations =  [0, 0.5, 1]
return gradient
"""
        let attributedText = NSAttributedString(string: text, attributes: textFontAttributes)
        textView.attributedText = attributedText
        return textView
    }

    func makeCopyCodeButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Copy to pasteboard", for: .normal)
        button.addTarget(self, action: #selector(copyCode(_:)), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGreen, for: .highlighted)
        button.backgroundColor = .darkGray
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.cornerRadius = 8
        return button
    }
 
    func addViews() {
        view.addSubview(closeButton)
        view.addSubview(codeTextView)
        view.addSubview(copyButton)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 48),
            closeButton.widthAnchor.constraint(equalToConstant: 48),
            closeButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            closeButton.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),

            codeTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeTextView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            codeTextView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            codeTextView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
            codeTextView.bottomAnchor.constraint(equalTo: copyButton.topAnchor, constant: -16),

            copyButton.heightAnchor.constraint(equalToConstant: 48),
            copyButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            copyButton.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            copyButton.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor, constant: -16),
        ])
    }

}

// MARK: - Actions

@objc extension CodeViewController {

    func close(_ sender: UIButton) {
        dismiss(animated: false)
    }

    func copyCode(_ sender: UIButton) {
        UIPasteboard.general.string = code
    }

}
