import UIKit

// MARK: - TokenTableViewCell
final class TokenTableViewCell: UITableViewCell {
    
    lazy private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .placeholderTokenIcon
        return imageView
    }()
    
    lazy private var tokenLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 18)
        label.text = "Bitcoin"
        label.textColor = .customDarkText
        return label
    }()
    
    lazy private var tickerLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.text = "BTC"
        label.textColor = .customGrayText
        return label
    }()
    
    lazy private var tokenPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 18)
        label.textColor = .customDarkText
        label.text = "$32,128.80"
        return label
    }()
    
    lazy private var priceChangeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .upArrow
        return imageView
    }()
    
    lazy private var priceChangePercentLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.text = "2.5%"
        label.textColor = .customGrayText
        return label
    }()
    
    // MARK: - Static Properties
    static let reuseIdentifier = "TokenTableViewCell"
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .customBackground
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func setData(with model: Token, image: UIImage? = nil) {
        tokenLabel.text = model.name
        tickerLabel.text = model.symbol
        tokenPriceLabel.text = model.usdPrice.asUSDCurrencyString()
        priceChangePercentLabel.text = model.dayChangePercent.asAbsolutePercentageString()
        priceChangeIcon.image = model.dayChangePercent >= 0 ? .upArrow : .downArrow
        iconImageView.image = image == nil ? .placeholderTokenIcon : image
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(tokenLabel)
        contentView.addSubview(tickerLabel)
        contentView.addSubview(tokenPriceLabel)
        contentView.addSubview(priceChangeIcon)
        contentView.addSubview(priceChangePercentLabel)
    }
    
    private func setupConstraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        
        tokenLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tokenLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            tokenLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 19),
        ])

        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tickerLabel.leadingAnchor.constraint(equalTo: tokenLabel.leadingAnchor),
            tickerLabel.topAnchor.constraint(equalTo: tokenLabel.bottomAnchor, constant: 3)
        ])

        tokenPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tokenPriceLabel.centerYAnchor.constraint(equalTo: tokenLabel.centerYAnchor),
            tokenPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        priceChangeIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceChangeIcon.centerYAnchor.constraint(equalTo: tickerLabel.centerYAnchor),
            priceChangeIcon.heightAnchor.constraint(equalToConstant: 12),
            priceChangeIcon.widthAnchor.constraint(equalToConstant: 12),
        ])
        
        priceChangePercentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceChangePercentLabel.leadingAnchor.constraint(equalTo: priceChangeIcon.trailingAnchor, constant: 5),
            priceChangePercentLabel.centerYAnchor.constraint(equalTo: priceChangeIcon.centerYAnchor),
            priceChangePercentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

