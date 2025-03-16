import UIKit

final class InputFieldView: UIView {
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
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    // MARK: - Initialization
    init(icon: UIImage, placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        setupView()
        configure(icon: icon, placeholder: placeholder, isSecure: isSecure)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 25
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(iconImageView)
        addSubview(textField)
        

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32),
            
            textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    // MARK: - Configuration Method
    private func configure(icon: UIImage, placeholder: String, isSecure: Bool) {
        iconImageView.image = icon
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        textField.delegate = self
        textField.keyboardAppearance = .default
    }
}

extension InputFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
