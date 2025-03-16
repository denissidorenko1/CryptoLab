import UIKit

// MARK: - HomeScreenView
final class HomeScreenView: UIViewController {
    // MARK: UI Components
    private lazy var towerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .tower
        imageView.layer.shadowRadius = 95
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.75
        return imageView
    }()
    
    private lazy var homeLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.textColor = .white
        label.font = .poppinsSemiBold(size: 32)
        return label
    }()
    
    private lazy var menuIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .menuIcon
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenuButton))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var menu: CustomMenuView = {
        let items: [MenuItemModel] = [
            MenuItemModel(icon: .rocketIcon, title: "Обновить", action: { [weak self] in
                self?.viewModel.fetchTokens()
            }),
            MenuItemModel(icon: .trashcanIcon, title: "Выйти", action: { [weak self] in
                self?.viewModel.logout()
                guard let coordinator = self?.coordinator as? HomeTabCoordinator else { return }
                coordinator.popTabBar()
            })
        ]
        let menu = CustomMenuView(items: items)
        menu.isHidden = true
        return menu
    }()
    
    private lazy var affilateLabel: UILabel = {
        let label = UILabel()
        label.text = "Affilate program"
        label.font = .poppinsMedium(size: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var sheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .customBackground
        view.layer.cornerRadius = 40
        return view
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending"
        label.textColor = .customBlack
        label.font = .poppinsMedium(size: 20)
        return label
    }()
    
    private lazy var tokenTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .customBackground
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var filterIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .decreasingIcon
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSortImageView))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .customBackground
        view.layer.cornerRadius = 35/2
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Learn more"
        label.font = .poppinsSemiBold(size: 14)
        label.textColor = .customDarkText
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Properties
    private var viewModel: HomeScreenViewModel
    private var coordinator: Coordinator
    
    // MARK: - Initializers
    init(viewModel: HomeScreenViewModel, coordinator: Coordinator) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        addSubviews()
        setupConstraints()
        viewModel.delegate = self
        viewModel.fetchTokens()
    }
    
    // MARK: UI methods
    private func setupTabBarItem() {
        tabBarItem = UITabBarItem(title: nil, image: .homeTabBarIcon, tag: 0)
        tabBarItem.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -15, right: 0)
    }
    
    private func setupTableView() {
        tokenTableView.register(TokenTableViewCell.self, forCellReuseIdentifier: TokenTableViewCell.reuseIdentifier)
        tokenTableView.delegate = self
        tokenTableView.dataSource = self
        tokenTableView.separatorStyle = .none
    }
    
    private func setupUI() {
        view.backgroundColor = .customPink
    }
    
    private func addSubviews() {
        view.addSubview(towerImageView)
        view.addSubview(homeLabel)
        view.addSubview(menuIcon)
        view.addSubview(menu)
        view.addSubview(affilateLabel)
        view.addSubview(infoView)
        view.addSubview(infoLabel)
        
        view.addSubview(sheetView)
        view.addSubview(activityIndicator)
        sheetView.addSubview(headerLabel)
        sheetView.addSubview(filterIcon)
        sheetView.addSubview(tokenTableView)
    }
    
    private func setupConstraints() {
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: homeLabel.leadingAnchor, constant: -25),
            view.layoutMarginsGuide.topAnchor.constraint(equalTo: homeLabel.topAnchor, constant: 0)
        ])
        
        menuIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuIcon.centerYAnchor.constraint(equalTo: homeLabel.centerYAnchor),
            menuIcon.heightAnchor.constraint(equalToConstant: 48),
            menuIcon.widthAnchor.constraint(equalToConstant: 48),
            menuIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
        
        menu.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menu.topAnchor.constraint(equalTo: menuIcon.bottomAnchor, constant: 8),
            menu.trailingAnchor.constraint(equalTo: menuIcon.trailingAnchor, constant: -8),
            menu.heightAnchor.constraint(equalToConstant: 102),
            menu.widthAnchor.constraint(equalToConstant: 157)
            
        ])
        
        affilateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: affilateLabel.leadingAnchor, constant: -25),
            affilateLabel.topAnchor.constraint(equalTo: homeLabel.bottomAnchor, constant: 45)
        ])
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoView.heightAnchor.constraint(equalToConstant: 35),
            infoView.widthAnchor.constraint(equalToConstant: 127),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            infoView.topAnchor.constraint(equalTo: affilateLabel.bottomAnchor, constant: 12)
        ])
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor)
        ])
        
        towerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            towerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            towerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 101)
            
        ])
        
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sheetView.topAnchor.constraint(equalTo: view.topAnchor, constant: 258),
            sheetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 40)
        ])
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 25),
            headerLabel.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 25)
        ])
        
        
        filterIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterIcon.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            filterIcon.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -25)
            
        ])
        
        tokenTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tokenTableView.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 25),
            tokenTableView.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -25),
            tokenTableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 25),
            tokenTableView.bottomAnchor.constraint(equalTo: sheetView.bottomAnchor, constant: -40)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 25),
        ])
    }
    
    // MARK: - Actions
    @objc private func didTapSortImageView() {
        viewModel.toggleSorting()
    }
    
    @objc private func didTapMenuButton() {
        UIView.transition(with: menu, duration: 0.3, options: .transitionCrossDissolve) { [weak self] in
            self?.menu.isHidden.toggle()
        }
    }
}

// MARK: - HomeScreenViewModelDelegate
extension HomeScreenView: HomeScreenViewModelDelegate {
    func didUpdateSortOrder(_ order: SortingOrder) {
        UIView.transition(with: filterIcon, duration: 0.3, options: .transitionFlipFromTop) { [weak self] in
            self?.filterIcon.image = order == .ascending ? .increasingIcon : .decreasingIcon
        }
    }
    
    func didUpdateTokens() {
        UIView.transition(with: tokenTableView, duration: 0.3, options: .transitionCrossDissolve) { [weak self] in
            self?.tokenTableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: any Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func didUpdateLoadingState(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

// MARK: - UITableViewDataSource
extension HomeScreenView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tokens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TokenTableViewCell.reuseIdentifier, for: indexPath) as? TokenTableViewCell else {
            return UITableViewCell()
        }
        let token = viewModel.tokens[indexPath.row]
        let tokenIcon = findTokenIcon(ticker: token.symbol)
        cell.setData(with: token, image: tokenIcon)
        return cell
    }
    
    private func findTokenIcon(ticker: String) -> UIImage? {
        switch ticker {
        case "BTC":
            return .btcIcon
        case "NEO":
            return .neoIcon
        case "ACT":
            return .achainIcon
        default:
            return nil
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeScreenView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let coordinator = coordinator as? HomeTabCoordinator else { return }
        let token = viewModel.tokens[indexPath.row]
        coordinator.pushDetailedInfoScreenView(with: token)
    }
}

