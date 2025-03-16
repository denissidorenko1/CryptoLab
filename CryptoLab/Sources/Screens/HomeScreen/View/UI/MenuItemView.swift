import UIKit

// MARK: - Menu Item Model
struct MenuItemModel {
    let icon: UIImage
    let title: String
    let action: () -> Void
}

// MARK: - Menu Item View
final class MenuItemView: UIView {
    // MARK: - UILocalConstants
    private enum UILocalConstants {
        static let spacing: CGFloat = 8
        static let iconSize: CGFloat = 20
        static let verticalInset: CGFloat = 16
        static let horizontalInset: CGFloat = 20
    }
    
    // MARK: - UI Elements
    private lazy var iconImageView: UIImageView = {
       let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .customDarkText
        return label
    }()
    
    // MARK: - Actions
    private var action: (() -> Void)?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with model: MenuItemModel) {
        iconImageView.image = model.icon
        titleLabel.text = model.title
        action = model.action
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = UILocalConstants.spacing
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UILocalConstants.horizontalInset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UILocalConstants.horizontalInset),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: UILocalConstants.verticalInset),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UILocalConstants.verticalInset),
            
            iconImageView.widthAnchor.constraint(equalToConstant: UILocalConstants.iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: UILocalConstants.iconSize)
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Handlers
    @objc private func didTap() {
        action?()
    }
    

}
