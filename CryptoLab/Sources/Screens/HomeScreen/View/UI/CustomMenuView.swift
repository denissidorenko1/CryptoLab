import UIKit

// MARK: - Custom Menu View
final class CustomMenuView: UIView {
    // MARK: - UILocalConstants
    private enum UILocalConstants {
        static let cornerRadius: CGFloat = 16
    }
    
    // MARK: - UI Elements
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Initializers
    init(items: [MenuItemModel]) {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        setupUI()
        configureMenu(items: items)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = UILocalConstants.cornerRadius
    }
    
    private func configureMenu(items: [MenuItemModel]) {
        items.forEach { item in
            let itemView = MenuItemView()
            itemView.configure(with: item)
            stackView.addArrangedSubview(itemView)
        }
    }
}
