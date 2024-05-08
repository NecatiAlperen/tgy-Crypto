//
//  CryptoCell.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 5.05.2024.
//

import UIKit
import SDWebImage



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
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        label.text = "BTC"
        return label
    }()
    private lazy var coinName : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20,weight: .bold)
        label.text = "Bitcoin"
        return label
    }()
    private lazy var coinPrice: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18,weight: .medium)
        label.text = "89237"
        return label
    }()
    private lazy var coinChange: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16,weight: .semibold)
        label.text = "-123123"
        return label
    }()
    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[coinName,coinPrice])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    private lazy var rigthStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[coinSymbol,coinChange])
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

    public func configure(with model: Coin) {
        coinSymbol.text = model.symbol
        coinName.text = model.name
        coinPrice.text = model.price
        
        if let changeValue = Double(model.change), changeValue < 0 {
            coinChange.textColor = .red
        } else {
            coinChange.textColor = .green
        }
        coinChange.text = model.change
        
        guard let iconURLString = model.iconUrl else { return }
        var urlString = iconURLString
        if iconURLString.lowercased().hasSuffix(".svg") {
            urlString = iconURLString.replacingOccurrences(of: ".svg", with: ".png")
        }
        guard let url = URL(string: urlString) else { return }
        coinLogo.sd_setImage(with: url, completed: nil)
    }
    
    private func setupUI(){
        
        addSubview(coinLogo)
        addSubview(leftStackView)
        addSubview(rigthStackView)
        
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        rigthStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Coin Logo Constraints
            coinLogo.centerYAnchor.constraint(equalTo: centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            coinLogo.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            
            // Name StackView Constraints
            leftStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftStackView.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 8),
            leftStackView.trailingAnchor.constraint(equalTo: rigthStackView.leadingAnchor, constant: -16),
            leftStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.50),
            
            
            rigthStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rigthStackView.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.2)
        ])
    }
}
