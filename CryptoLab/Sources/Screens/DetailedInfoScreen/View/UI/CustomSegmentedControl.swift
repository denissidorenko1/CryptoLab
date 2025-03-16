import UIKit

// MARK: - CustomSegmentedControlDelegate
protocol CustomSegmentedControlDelegate: AnyObject {
    func segmentedControlDidSelect(index: Int)
}

// MARK: - CustomSegmentedControl
final class CustomSegmentedControl: UIView {
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
        layer.cornerRadius = 30
        clipsToBounds = true
        
        selectionIndicator.backgroundColor = .customBrightBackground
        selectionIndicator.layer.cornerRadius = 25
        
        selectionIndicator.layer.shadowColor = UIColor.customBlack.cgColor
        selectionIndicator.layer.shadowOpacity = 0.1
        selectionIndicator.layer.shadowOffset = CGSize(width: 0, height: 4)
        selectionIndicator.layer.shadowRadius = 4
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
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
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
        
        UIView.animate(withDuration: animated ? 0.3 : 0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            self.selectionIndicator.frame = CGRect(
                x: buttonFrame.origin.x + 4,
                y: buttonFrame.origin.y + 4,
                width: buttonFrame.width - 8,
                height: buttonFrame.height - 8
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
