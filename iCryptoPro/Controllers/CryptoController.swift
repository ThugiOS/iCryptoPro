//
//  CryptoController.swift
//  iCryptoPro
//
//  Created by Никитин Артем on 15.06.23.
//

import UIKit

class CryptoController: UIViewController {

    // MARK: - Variables
    var viewModel: CryptoControllerViewModel
    
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
       let sv = UIScrollView()
        return sv
    }()
    
    private let contentView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let symbol: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.text = "Error"
        return label
    }()
    
    private let coinLogo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark.app")
        iv.tintColor = .label
        return iv
    }()
    
    private let lastUpdated: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Error"
        label.textColor = .init(named: "priceColor")
        return label
    }()
    
    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private var percentView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    private let percentChangeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 2
        label.text = "Percent change:\n1h        24h        7d"
        return label
    }()
    
    private let percentChange1h: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .init(named: "customGreen")
        return label
    }()
    
    private let percentChange24h: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .init(named: "customGreen")
        return label
    }()
    
    private let percentChange7d: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .init(named: "customGreen")
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [rankLabel, priceLabel, marketCapLabel, lastUpdated])
        vStack.axis = .vertical
        vStack.spacing = 5
        vStack.alignment = .center
        vStack.distribution = .fill
        return vStack
    }()
    
    private var buttonMarketCap: UIButton = {
        let button = UIButton()
        button.setTitle("Go CoinMarketCap", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        return button
    }()
    
    // MARK: - LifeCycle
    init(_ viewModel: CryptoControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()

        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = self.viewModel.coin.name
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        
        self.symbol.text = self.viewModel.symbol
        self.coinLogo.sd_setImage(with: self.viewModel.coin.logoURL)
        self.lastUpdated.text = self.viewModel.lastUpdated
        self.rankLabel.text = self.viewModel.rankLabel
        self.priceLabel.text = self.viewModel.priceLabel.description
        self.marketCapLabel.text = self.viewModel.marketCapLabel
        
        if self.viewModel.percentChange1h <= 0 { percentChange1h.textColor = .red }
        if self.viewModel.percentChange24h <= 0 { percentChange24h.textColor = .red }
        if self.viewModel.percentChange7d <= 0 { percentChange7d.textColor = .red }
        self.percentChange1h.text = "\(self.viewModel.percentChange1h.description)%"
        self.percentChange24h.text = "\(self.viewModel.percentChange24h)%"
        self.percentChange7d.text = "\(self.viewModel.percentChange7d)%"
        
        self.buttonMarketCap.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(symbol)
        self.contentView.addSubview(coinLogo)
        self.contentView.addSubview(percentView)
        self.percentView.addSubview(percentChangeLabel)
        self.percentView.addSubview(percentChange1h)
        self.percentView.addSubview(percentChange24h)
        self.percentView.addSubview(percentChange7d)
        self.contentView.addSubview(vStack)
        self.contentView.addSubview(buttonMarketCap)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        symbol.translatesAutoresizingMaskIntoConstraints = false
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        percentView.translatesAutoresizingMaskIntoConstraints = false
        percentChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        percentChange1h.translatesAutoresizingMaskIntoConstraints = false
        percentChange24h.translatesAutoresizingMaskIntoConstraints = false
        percentChange7d.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        buttonMarketCap.translatesAutoresizingMaskIntoConstraints = false

        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            symbol.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            symbol.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40.0),
            
            coinLogo.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            coinLogo.topAnchor.constraint(equalTo: self.symbol.bottomAnchor, constant: 10.0),
            coinLogo.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            coinLogo.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            coinLogo.heightAnchor.constraint(equalToConstant: 200.0),

            percentChangeLabel.topAnchor.constraint(equalTo: coinLogo.bottomAnchor, constant: 15.0),
            percentChangeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            percentView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            percentView.topAnchor.constraint(equalTo: self.percentChangeLabel.bottomAnchor, constant: 5.0),
            percentView.widthAnchor.constraint(equalToConstant: 300.0),
            percentView.heightAnchor.constraint(equalToConstant: 50.0),
            
            percentChange24h.centerYAnchor.constraint(equalTo: percentView.centerYAnchor),
            percentChange24h.centerXAnchor.constraint(equalTo: percentView.centerXAnchor),

            percentChange1h.centerYAnchor.constraint(equalTo: percentView.centerYAnchor),
            percentChange1h.trailingAnchor.constraint(equalTo: percentChange24h.leadingAnchor, constant: -15.0),

            percentChange7d.centerYAnchor.constraint(equalTo: percentView.centerYAnchor),
            percentChange7d.leadingAnchor.constraint(equalTo: percentChange24h.trailingAnchor, constant: 15.0),
            
            buttonMarketCap.topAnchor.constraint(equalTo: percentView.bottomAnchor, constant: 20.0),
            buttonMarketCap.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonMarketCap.widthAnchor.constraint(equalToConstant: 300.0),
            buttonMarketCap.heightAnchor.constraint(equalToConstant: 55.0),
            
            vStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: buttonMarketCap.bottomAnchor, constant: 20.0),
            vStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }

    // MARK: - Selectors
//    @objc func buttonTapped() {
//        viewModel.goToCoinMarketCap()
//    }
    @objc private func buttonTapped() {
        UIView.animate(withDuration: 0.08, animations: {
            self.buttonMarketCap.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        }) { (_) in
            UIView.animate(withDuration: 0.08) {
                self.buttonMarketCap.transform = CGAffineTransform.identity
            }
            
            self.viewModel.goToCoinMarketCap()
        }
    }
}



