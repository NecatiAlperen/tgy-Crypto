//
//  CryptoDetailVC.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 6.05.2024.
//

import UIKit

class CryptoDetailVC: UIViewController {
    
    private let coin:Coin
    
    private lazy var coinLogo : UIImageView = {
        let imageView = UIImageView()
        view.contentMode = .scaleAspectFit
        imageView.image = .noresult
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var coinSymbol : UILabel = {
        let label = UILabel()
        label.text = "btc"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var coinPrice : UILabel = {
        let label = UILabel()
        label.text = "1$"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var coinChange : UILabel = {
        let label = UILabel()
        label.text = "-3.61"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var coinVolume : UILabel = {
        let label = UILabel()
        label.text = "123.123"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var coinMarketCap : UILabel = {
        let label = UILabel()
        label.text = "123123"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(_ coin: Coin){
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.navigationItem.title = self.coin.name
    }
    
    private func setupUI(){
        
        view.addSubview(coinLogo)
        view.addSubview(coinSymbol)
        view.addSubview(coinPrice)
        view.addSubview(coinChange)
        view.addSubview(coinVolume)
        view.addSubview(coinMarketCap)
        
        NSLayoutConstraint.activate([
        
//            coinLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
//            coinLogo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
//            coinLogo.topAnchor.constraint(equalTo: view.topAnchor),
//            coinLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            coinSymbol.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
//            coinSymbol.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
//            coinSymbol.topAnchor.constraint(equalTo: coinLogo.bottomAnchor, constant: 20),
//            coinSymbol.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            
//            
//            coinPrice.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
//            coinPrice.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
//            coinPrice.topAnchor.constraint(equalTo: coinSymbol.bottomAnchor, constant: 20),
//            coinPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
        ])
        
    }

    

}
