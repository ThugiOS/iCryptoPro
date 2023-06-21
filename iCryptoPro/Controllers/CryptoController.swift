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
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.symbol)
        self.contentView.addSubview(self.coinLogo)
        self.contentView.addSubview(self.percentView)
        self.percentView.addSubview(self.percentChangeLabel)
        self.percentView.addSubview(self.percentChange1h)
        self.percentView.addSubview(self.percentChange24h)
        self.percentView.addSubview(self.percentChange7d)
        self.contentView.addSubview(self.vStack)
        self.contentView.addSubview(self.buttonMarketCap)

        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.symbol.translatesAutoresizingMaskIntoConstraints = false
        self.coinLogo.translatesAutoresizingMaskIntoConstraints = false
        self.percentView.translatesAutoresizingMaskIntoConstraints = false
        self.percentChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.percentChange1h.translatesAutoresizingMaskIntoConstraints = false
        self.percentChange24h.translatesAutoresizingMaskIntoConstraints = false
        self.percentChange7d.translatesAutoresizingMaskIntoConstraints = false
        self.vStack.translatesAutoresizingMaskIntoConstraints = false
        self.buttonMarketCap.translatesAutoresizingMaskIntoConstraints = false

        let height = self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            self.scrollView.heightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.heightAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            self.symbol.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.symbol.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40.0),
            
            self.coinLogo.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.coinLogo.topAnchor.constraint(equalTo: self.symbol.bottomAnchor, constant: 10.0),
            self.coinLogo.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.coinLogo.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.coinLogo.heightAnchor.constraint(equalToConstant: 200.0),

            self.percentChangeLabel.topAnchor.constraint(equalTo: self.coinLogo.bottomAnchor, constant: 15.0),
            self.percentChangeLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            self.percentView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.percentView.topAnchor.constraint(equalTo: self.percentChangeLabel.bottomAnchor, constant: 5.0),
            self.percentView.widthAnchor.constraint(equalToConstant: 300.0),
            self.percentView.heightAnchor.constraint(equalToConstant: 50.0),
            
            self.percentChange24h.centerYAnchor.constraint(equalTo: self.percentView.centerYAnchor),
            self.percentChange24h.centerXAnchor.constraint(equalTo: self.percentView.centerXAnchor),

            self.percentChange1h.centerYAnchor.constraint(equalTo: self.percentView.centerYAnchor),
            self.percentChange1h.trailingAnchor.constraint(equalTo: self.percentChange24h.leadingAnchor, constant: -15.0),

            self.percentChange7d.centerYAnchor.constraint(equalTo: self.percentView.centerYAnchor),
            self.percentChange7d.leadingAnchor.constraint(equalTo: self.percentChange24h.trailingAnchor, constant: 15.0),
            
            self.buttonMarketCap.topAnchor.constraint(equalTo: self.percentView.bottomAnchor, constant: 20.0),
            self.buttonMarketCap.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.buttonMarketCap.widthAnchor.constraint(equalToConstant: 300.0),
            self.buttonMarketCap.heightAnchor.constraint(equalToConstant: 55.0),
            
            self.vStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.vStack.topAnchor.constraint(equalTo: self.buttonMarketCap.bottomAnchor, constant: 20.0),
            self.vStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.vStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.vStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }

    // MARK: - Selectors
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



