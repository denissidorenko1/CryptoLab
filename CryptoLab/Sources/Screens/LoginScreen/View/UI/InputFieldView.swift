import UIKit

// MARK: - InputFieldView
final class InputFieldView: UIView {
    private enum UILocalConstants {
        static let cornerRadius: CGFloat = 25
        static let imageSize: CGFloat = 32
        static let horizontalInset: CGFloat = 12
        static let elementHeight: CGFloat = 55
        static let elementSpacing: CGFloat = 10
    }
    
    // MARK: - UI Components
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = UIFont.poppinsRegular(size: 16)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    // MARK: - Initializers
    init(icon: UIImage, placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        setupView()
        configure(icon: icon, placeholder: placeholder, isSecure: isSecure)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = UILocalConstants.cornerRadius
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(iconImageView)
        addSubview(textField)
        

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UILocalConstants.horizontalInset),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: UILocalConstants.imageSize),
            iconImageView.heightAnchor.constraint(equalToConstant: UILocalConstants.imageSize),
            
            textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: UILocalConstants.elementSpacing),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UILocalConstants.horizontalInset),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: UILocalConstants.elementHeight)
        ])
    }
    
    private func configure(icon: UIImage, placeholder: String, isSecure: Bool) {
        iconImageView.image = icon
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGrayText])
        textField.isSecureTextEntry = isSecure
        textField.delegate = self
        textField.keyboardAppearance = .default
    }
}

// MARK: - UITextFieldDelegate
extension InputFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
