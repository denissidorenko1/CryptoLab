import UIKit

// MARK: - CustomSegmentedControlDelegate
protocol CustomSegmentedControlDelegate: AnyObject {
    func segmentedControlDidSelect(index: Int)
}

// MARK: - CustomSegmentedControl
final class CustomSegmentedControl: UIView {
    // MARK: - UILocalConstants
    private enum UILocalConstants {
        static let backgroundCornerRadius: CGFloat = 30
        static let segmentCornerRadius: CGFloat = 25
        static let damping: CGFloat = 0.7
        static let springVelocity: CGFloat = 0.7
        static let indicatorHorizontalOffset: CGFloat = 4
        static let indicatorVerticallOffset: CGFloat = 4
        static let indicatorShadowOpacity: Float = 0.1
        static let indicatorShadowRadius: CGFloat = 4
        static let indicatorShadowOffset: CGSize = CGSize(width: 0, height: 4)
    }
    
    // MARK: - Properties
    private let segments: [String]
    private var buttons: [UIButton] = []
    private let selectionIndicator = UIView()
    
    weak var delegate: CustomSegmentedControlDelegate?
    private var selectedIndex: Int = 0
    
    // MARK: - Initializers
    init(segments: [String]) {
        self.segments = segments
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        updateSelectionIndicator(animated: false)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        backgroundColor = .customDarkBackground
        layer.cornerRadius = UILocalConstants.backgroundCornerRadius
        clipsToBounds = true
        
        selectionIndicator.backgroundColor = .customBrightBackground
        selectionIndicator.layer.shadowColor = UIColor.customBlack.cgColor
        
        selectionIndicator.layer.cornerRadius = UILocalConstants.segmentCornerRadius
        selectionIndicator.layer.shadowOpacity = UILocalConstants.indicatorShadowOpacity
        selectionIndicator.layer.shadowOffset = UILocalConstants.indicatorShadowOffset
        selectionIndicator.layer.shadowRadius = UILocalConstants.indicatorShadowRadius
        
        addSubview(selectionIndicator)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        for (index, title) in segments.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = .poppinsMedium(size: 14)
            button.setTitleColor(.customGrayText, for: .normal)
            button.addTarget(self, action: #selector(segmentTapped(_:)), for: .touchUpInside)
            button.tag = index
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func updateSelectionIndicator(animated: Bool) {
        guard !buttons.isEmpty else { return }
        
        buttons.forEach { $0.setTitleColor(.customGrayText, for: .normal) }
        
        let selectedButton = buttons[selectedIndex]
        
        let buttonFrame = selectedButton.frame
        selectedButton.setTitleColor(.customDarkText, for: .normal)
        
        UIView.animate(
            withDuration: UIGlobalConstants.animationDuration,
            delay: 0,
            usingSpringWithDamping: UILocalConstants.damping,
            initialSpringVelocity: UILocalConstants.springVelocity,
            options: .curveEaseOut
        ) {
            self.selectionIndicator.frame = CGRect(
                x: buttonFrame.origin.x + UILocalConstants.indicatorHorizontalOffset,
                y: buttonFrame.origin.y + UILocalConstants.indicatorVerticallOffset,
                width: buttonFrame.width - UILocalConstants.indicatorHorizontalOffset*2,
                height: buttonFrame.height - UILocalConstants.indicatorVerticallOffset*2
            )
        }
    }
    
    // MARK: - Actions
    @objc private func segmentTapped(_ sender: UIButton) {
        let index = sender.tag
        guard index != selectedIndex else { return }
        
        selectedIndex = index
        updateSelectionIndicator(animated: true)
        delegate?.segmentedControlDidSelect(index: index)
    }
}
