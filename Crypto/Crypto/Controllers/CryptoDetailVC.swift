//
//  CryptoDetailVC.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 6.05.2024.
//

import UIKit

final class CryptoDetailVC: UIViewController {
    
    
    //MARK: -- VARIABLES
    
    private let coin:Coin
    private var isFavorite: Bool = false
    
    private lazy var coinLogo : UIImageView = {
        let imageView = UIImageView()
        view.contentMode = .scaleAspectFit
        imageView.image = .noresult
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var coinSymbol : UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        return label
    }()
    
    private lazy var coinPrice : UILabel = {
        let label = UILabel()
        label.text = "1$"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 16
        return label
    }()
    private lazy var coinChange : UILabel = {
        let label = UILabel()
        label.text = "-3.61"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 16
        return label
    }()
    private lazy var coinVolume : UILabel = {
        let label = UILabel()
        label.text = "123.123"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 16
        return label
    }()
    private lazy var coinMarketCap : UILabel = {
        let label = UILabel()
        label.text = "123123"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 16
        return label
    }()
    private lazy var heartButton: UIBarButtonItem = {
        let heartImage = UIImage(systemName: "heart.fill")
        let button = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(saveClicked))
        return button
    }()
    
    //MARK: -- LIFECYCLE
    
    init(_ coin: Coin){
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
        if let favoriteList = UserDefaults.standard.array(forKey : "favoriteList") as? [String] {
            isFavorite = favoriteList.contains(coin.uuid ?? "" )
        }
        updateHeartButtonAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
        self.navigationItem.title = self.coin.name
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = heartButton
    }
    
    //MARK: -- FUNCTIONS
    
    @objc private func saveClicked() {
        
        var favoriteList = UserDefaults.standard.array(forKey: "favoriteList") as? [String]
        
        if isFavorite {
            favoriteList?.removeAll(where: { coinId in
                coinId == coin.uuid
            })
        }else{
            favoriteList?.append(coin.uuid ?? "")
            print(favoriteList?.first)
        }
        isFavorite.toggle()
        UserDefaults.standard.set(favoriteList, forKey: "favoriteList")
        updateHeartButtonAppearance()
    }
    
    private func updateHeartButtonAppearance() {
        if isFavorite {
            heartButton.tintColor = .red
        } else {
            heartButton.tintColor = .blue
        }
    }
    
    private func setData() {
        guard let iconURLString = coin.iconUrl else { return }
        var urlString = iconURLString
        if iconURLString.lowercased().hasSuffix(".svg") {
            urlString = iconURLString.replacingOccurrences(of: ".svg", with: ".png")
        }
        guard let url = URL(string: urlString) else { return }
        coinLogo.sd_setImage(with: url, completed: nil)
        coinSymbol.text = coin.symbol
        coinPrice.text = "Coin Price: \(coin.price)$ "
        coinChange.text = "Coin Change: \(coin.change)% "
        coinVolume.text = "Coin Volume: \(coin.volume) "
        coinMarketCap.text = "Coin Market Cap: \(coin.marketCap) "
    }
    private func setupUI() {
        
        view.addSubview(coinLogo)
        view.addSubview(coinSymbol)
        view.addSubview(coinPrice)
        view.addSubview(coinChange)
        view.addSubview(coinVolume)
        view.addSubview(coinMarketCap)
        
        NSLayoutConstraint.activate([
            
            coinLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            coinLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinLogo.widthAnchor.constraint(equalToConstant: screenWidth * 0.5),
            coinLogo.heightAnchor.constraint(equalToConstant: screenHeigth * 0.2),
            
            coinSymbol.centerXAnchor.constraint(equalTo: coinLogo.centerXAnchor),
            coinSymbol.topAnchor.constraint(equalTo: coinLogo.bottomAnchor, constant: 10),
            
            
            coinPrice.topAnchor.constraint(equalTo: coinSymbol.bottomAnchor,constant: 10),
            coinPrice.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinPrice.heightAnchor.constraint(equalToConstant: screenHeigth * 0.05),
            coinPrice.widthAnchor.constraint(equalToConstant: screenWidth * 0.9),
            
            coinChange.topAnchor.constraint(equalTo: coinPrice.bottomAnchor, constant: 10),
            coinChange.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinChange.heightAnchor.constraint(equalToConstant: screenHeigth * 0.05),
            coinChange.widthAnchor.constraint(equalToConstant: screenWidth * 0.9),
            
            coinVolume.topAnchor.constraint(equalTo: coinChange.bottomAnchor, constant: 10),
            coinVolume.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinVolume.heightAnchor.constraint(equalToConstant: screenHeigth * 0.05),
            coinVolume.widthAnchor.constraint(equalToConstant: screenWidth * 0.9),
            
            coinMarketCap.topAnchor.constraint(equalTo: coinVolume.bottomAnchor, constant: 10),
            coinMarketCap.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinMarketCap.heightAnchor.constraint(equalToConstant: screenHeigth * 0.05),
            coinMarketCap.widthAnchor.constraint(equalToConstant: screenWidth * 0.9),
            
        ])
    }
}
