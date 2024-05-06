//
//  CryptoCell.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 5.05.2024.
//

import UIKit

class CoinCell : UITableViewCell{
    
    
    static let identifier = "CoinCell"
    
    
    private lazy var coinLogo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .black
        return iv
    }()
    private lazy var coinSymbol: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22,weight: .semibold)
        label.text = "BTC"
        return label
    }()
    private lazy var coinName : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        label.text = "Bitcoin"
        return label
    }()
    private lazy var coinPrice: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22,weight: .semibold)
        label.text = "89237"
        return label
    }()
    private lazy var coinChange: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22,weight: .semibold)
        label.text = "-123123"
        return label
    }()
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[coinSymbol,coinName])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[coinPrice,coinChange])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    
    public func configure(with model: Coin){
        coinSymbol.text = model.symbol
        coinName.text = model.name
        coinPrice.text = model.price
        coinChange.text = model.change
    }

    
    
    private func setupUI() {
        addSubview(coinLogo)
        addSubview(nameStackView)
        addSubview(priceStackView)
        
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Coin Logo Constraints
            coinLogo.centerYAnchor.constraint(equalTo: centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            coinLogo.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            
            // Name StackView Constraints
            nameStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameStackView.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 16),
            nameStackView.trailingAnchor.constraint(equalTo: priceStackView.leadingAnchor, constant: -16),
            // Price StackView Constraints
            priceStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            priceStackView.widthAnchor.constraint(equalToConstant: 120)  
        ])
    }

}
