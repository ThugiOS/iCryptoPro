//
//  CoinCell.swift
//  iCryptoPro
//
//  Created by Никитин Артем on 14.06.23.
//

import UIKit

class CoinCell: UITableViewCell {
    
    static let identifier = "CoinCell"
    
    // MARK: - Variables
    private(set) var coin: Coin!
    
    // MARK: - UI Components
    private let coinLogo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark.app")
        iv.tintColor = .black
        iv.backgroundColor = .systemBackground
        return iv
    }()
    
    private let coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with coin: Coin) {
        self.coin = coin
        
        self.coinName.text = coin.name
        
        DispatchQueue.global().async { [weak self] in
            if let logoURL = coin.logoURL,
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.coinLogo.image = logoImage
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coinName.text = nil
        self.coinLogo.image = nil
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(coinLogo)
        self.addSubview(coinName)

        self.coinLogo.translatesAutoresizingMaskIntoConstraints = false
        self.coinName.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.coinLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.coinLogo.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.coinLogo.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            self.coinLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            self.coinName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.coinName.leadingAnchor.constraint(equalTo: self.coinLogo.trailingAnchor, constant: 16.0),
        ])
    }
}

