import UIKit

// MARK: - LoginButton
final class LoginButton: UIView {
    // MARK: - UI Elements
    let label: UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initialization
    init(text: String) {
        super.init(frame: .zero)
        setupView()
        configure(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = .customBlack
        layer.cornerRadius = 25
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configure(text: String) {
        label.text = text
    }
}
