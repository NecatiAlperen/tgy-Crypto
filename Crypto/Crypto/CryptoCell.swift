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
    private lazy var priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22,weight: .semibold)
        label.text = "89237"
        return label
    }()
    private lazy var changeLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22,weight: .semibold)
        label.text = "-123123"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }

    
    
    private func setupUI(){
        self.addSubview(coinLogo)
        self.addSubview(coinName)
        self.addSubview(coinSymbol)
        self.addSubview(priceLabel)
        self.addSubview(changeLabel)
        
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        coinName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier:  0.75),
            coinLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier:  0.75),
            
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor,constant: 16),
            coinName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
