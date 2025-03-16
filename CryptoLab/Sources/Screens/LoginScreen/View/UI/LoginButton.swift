import UIKit

// MARK: - LoginButton
final class LoginButton: UIView {
    // MARK: - UILocalConstants
    private enum UILocalConstants {
        static let cornerRadius: CGFloat = 25
        static let elementHeight: CGFloat = 55
    }
    
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
        layer.cornerRadius = UILocalConstants.cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: UILocalConstants.elementHeight)
        ])
    }
    
    private func configure(text: String) {
        label.text = text
    }
}
