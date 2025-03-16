import UIKit

// MARK: - DetailedInfoScreenView
final class DetailedInfoScreenView: UIViewController {
    // MARK: - UILocalConstants
    private enum UILocalConstants {
        static let backIconSize: CGFloat = 48
        static let priceChangeIconSize: CGFloat = 12
        static let priceChangeTrailingOffset: CGFloat = 20
        static let priceChangeIconTopOffset: CGFloat = 3
        static let tokenPriceTopOffset: CGFloat = 20
        static let priceChangeLabelHorizontalOffset: CGFloat = 5
        static let sheetHeight: CGFloat = 160
        static let timeSegmentedControlHeight: CGFloat = 56
        static let horizontalSpacing: CGFloat = 20
        static let marketDataVerticalOffset: CGFloat = 15
        static let segmentedControlTopOffset: CGFloat = 20
        static let marketStatisticsTopOffset: CGFloat = 25
    }
    
    // MARK: - Properties
    private let coordinator: Coordinator
    private let viewModel: DetailedInfoScreenViewModel
    
    // MARK: - UI Elements
    private lazy var backIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .backIcon
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackIcon))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var tokenLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.textColor = .customDarkText
        return label
    }()
    
    private lazy var tokenPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 28)
        label.textColor = .customDarkText
        return label
    }()
    
    private lazy var priceChangeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .upArrow
        return imageView
    }()
    
    private lazy var priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.textColor = .customGrayText
        return label
    }()
    
    private lazy var timespanSegmentedControl: CustomSegmentedControl = {
        let timePeriods = ["24H", "1W", "1Y", "ALL", "Point"]
        let segmentedControl = CustomSegmentedControl(segments: timePeriods)
        segmentedControl.delegate = self
        return segmentedControl
    }()
    
    private lazy var sheetView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40
        view.backgroundColor = .customBrightBackground
        return view
    }()
    
    private lazy var marketStatisticLabel: UILabel = {
        let label = UILabel()
        label.text = "Market Statistic"
        label.font = .poppinsMedium(size: 20)
        label.textColor = .customDarkText
        return label
    }()
    
    private lazy var marketCapitalizationLabel: UILabel = {
        let label = UILabel()
        label.text = "Market capitalization"
        label.font = .poppinsMedium(size: 14)
        label.textColor = .customGrayText
        return label
    }()
    
    private lazy var circulatingSupplyLabel: UILabel = {
        let label = UILabel()
        label.text = "Circulating supply"
        label.font = .poppinsMedium(size: 14)
        label.textColor = .customGrayText
        return label
    }()
    
    private lazy var marketCapitalizationValueLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 14)
        label.textColor = .customDarkText
        return label
    }()
    
    private lazy var circulatingSupplyValueLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 14)
        label.textColor = .customDarkText
        return label
    }()
    
    // MARK: - Initializers
    init(viewModel: DetailedInfoScreenViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBackground
        addSubviews()
        setupConstraints()
        setData()
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        view.addSubview(backIcon)
        view.addSubview(tokenLabel)
        view.addSubview(tokenPriceLabel)
        view.addSubview(priceChangeIcon)
        view.addSubview(priceChangeLabel)
        view.addSubview(timespanSegmentedControl)
        
        view.addSubview(sheetView)
        sheetView.addSubview(marketStatisticLabel)
        sheetView.addSubview(marketCapitalizationLabel)
        sheetView.addSubview(marketCapitalizationValueLabel)
        sheetView.addSubview(circulatingSupplyLabel)
        sheetView.addSubview(circulatingSupplyValueLabel)
    }
    
    private func setupConstraints() {
        backIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backIcon.widthAnchor.constraint(equalToConstant: UILocalConstants.backIconSize),
            backIcon.heightAnchor.constraint(equalToConstant: UILocalConstants.backIconSize),
            backIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIGlobalConstants.horizontalInset),
            backIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        tokenLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tokenLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tokenLabel.centerYAnchor.constraint(equalTo: backIcon.centerYAnchor)
        ])
        
        tokenPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tokenPriceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tokenPriceLabel.topAnchor.constraint(equalTo: tokenLabel.bottomAnchor, constant:  UILocalConstants.tokenPriceTopOffset)
        ])
        
        priceChangeIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceChangeIcon.heightAnchor.constraint(equalToConstant: UILocalConstants.priceChangeIconSize),
            priceChangeIcon.widthAnchor.constraint(equalToConstant: UILocalConstants.priceChangeIconSize),
            priceChangeIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -UILocalConstants.priceChangeTrailingOffset),
            priceChangeIcon.topAnchor.constraint(equalTo: tokenPriceLabel.bottomAnchor, constant: UILocalConstants.priceChangeIconTopOffset)
            
        ])
        
        priceChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceChangeLabel.centerYAnchor.constraint(equalTo: priceChangeIcon.centerYAnchor),
            priceChangeLabel.leadingAnchor.constraint(equalTo: priceChangeIcon.trailingAnchor, constant: UILocalConstants.priceChangeLabelHorizontalOffset)
        ])
        
        timespanSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timespanSegmentedControl.topAnchor.constraint(equalTo: priceChangeLabel.bottomAnchor, constant: UILocalConstants.segmentedControlTopOffset),
            timespanSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIGlobalConstants.horizontalInset),
            timespanSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIGlobalConstants.horizontalInset),
            timespanSegmentedControl.heightAnchor.constraint(equalToConstant: UILocalConstants.timeSegmentedControlHeight)
        ])
        
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sheetView.heightAnchor.constraint(equalToConstant: UILocalConstants.sheetHeight+UIGlobalConstants.sheetCornerRadius),
            sheetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: UIGlobalConstants.sheetCornerRadius)
        ])
        
        marketStatisticLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            marketStatisticLabel.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: UIGlobalConstants.horizontalInset),
            marketStatisticLabel.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: UILocalConstants.marketStatisticsTopOffset)
        ])
        
        marketCapitalizationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            marketCapitalizationLabel.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: UIGlobalConstants.horizontalInset),
            marketCapitalizationLabel.topAnchor.constraint(equalTo: marketStatisticLabel.bottomAnchor, constant: UILocalConstants.marketDataVerticalOffset)
        ])
        
        marketCapitalizationValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            marketCapitalizationValueLabel.centerYAnchor.constraint(equalTo: marketCapitalizationLabel.centerYAnchor),
            marketCapitalizationValueLabel.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -UIGlobalConstants.horizontalInset)
        ])
        
        circulatingSupplyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circulatingSupplyLabel.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: UIGlobalConstants.horizontalInset),
            circulatingSupplyLabel.topAnchor.constraint(equalTo: marketCapitalizationLabel.bottomAnchor, constant: UILocalConstants.marketDataVerticalOffset)
        ])
        
        circulatingSupplyValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circulatingSupplyValueLabel.centerYAnchor.constraint(equalTo: circulatingSupplyLabel.centerYAnchor),
            circulatingSupplyValueLabel.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -UIGlobalConstants.horizontalInset)
        ])
    }
    
    private func setData() {
        tokenLabel.text = "\(viewModel.model.name) (\(viewModel.model.symbol))"
        tokenPriceLabel.text = "\(viewModel.model.usdPrice.asUSDCurrencyString())"
        priceChangeIcon.image = viewModel.model.dayChangePercent >= 0 ? .upArrow : .downArrow
        priceChangeLabel.text = "\(viewModel.model.dayChangePercent.asAbsolutePercentageString())"
        setMarketStatistics(capitalization: viewModel.model.marketVolume, supply: viewModel.model.supply)
    }
    
    private func setMarketStatistics(capitalization: Double?, supply: Double?) {
        marketCapitalizationValueLabel.text = "\(capitalization?.asUSDCurrencyString() ?? "N/A")"
        circulatingSupplyValueLabel.text = "\(supply ?? 0) \(viewModel.model.symbol)"
    }
    
    private func toggleMarketStatistics(with index: Int) {
        
        switch index {
        // 24H
        case 0:
            setMarketStatistics(capitalization: viewModel.model.marketVolume, supply: viewModel.model.supply)
        // 1W
        case 1:
            setMarketStatistics(capitalization: viewModel.model.marketVolume, supply: viewModel.model.supply)
        // 1Y
        case 2:
            setMarketStatistics(capitalization: viewModel.model.marketVolume, supply: viewModel.model.supply)
        // ALL
        case 3:
            setMarketStatistics(capitalization: viewModel.model.marketVolume, supply: viewModel.model.supply)
        // Point
        case 4:
            setMarketStatistics(capitalization: nil, supply: nil)
        default:
            setMarketStatistics(capitalization: nil, supply: nil)
        }
    }
    
    // MARK: - Actions
    @objc func didTapBackIcon() {
        guard let coordinator = coordinator as? HomeTabCoordinator else { return }
        coordinator.popDetailedInfoScreenView()
    }
    
}

// MARK: - CustomSegmentedControlDelegate
extension DetailedInfoScreenView: CustomSegmentedControlDelegate {
    func segmentedControlDidSelect(index: Int) {
        toggleMarketStatistics(with: index)
    }
}

