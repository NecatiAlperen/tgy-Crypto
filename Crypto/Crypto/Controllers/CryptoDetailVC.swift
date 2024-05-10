//
//  CryptoDetailVC.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 6.05.2024.
//

import UIKit
import CoreData

class CryptoDetailVC: UIViewController {
    
    private let coin:Coin
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
        return label
    }()
    private lazy var coinChange : UILabel = {
        let label = UILabel()
        label.text = "-3.61"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        return label
    }()
    private lazy var coinVolume : UILabel = {
        let label = UILabel()
        label.text = "123.123"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        return label
    }()
    private lazy var coinMarketCap : UILabel = {
        let label = UILabel()
        label.text = "123123"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,weight: .semibold)
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
        setData()
        self.navigationItem.title = self.coin.name
        view.backgroundColor = .white
        let heartImage = UIImage(systemName: "heart.fill")
        let heartButton = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(saveClicked))
        navigationItem.rightBarButtonItem = heartButton
    }
    
    
    @objc private func saveClicked(){
        print("save clicked")
        
        guard let coinUUIDString = coin.uuid, let coinUUID = UUID(uuidString: coinUUIDString) else {
            print("coin UUID: \(coin.uuid ?? "nil")")
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteCoin", in: context) else {
            fatalError("Entity bulunamadı")
        }
        
        let favoriteCoin = NSManagedObject(entity: entity, insertInto: context)
        favoriteCoin.setValue(coinUUID, forKey: "uuid")
        
        do {
            try context.save()
        } catch {
            print("Error saving favorite coin: \(error)")
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
            coinLogo.widthAnchor.constraint(equalToConstant: 100),
            coinLogo.heightAnchor.constraint(equalToConstant: 100),
            
            coinSymbol.centerXAnchor.constraint(equalTo: coinLogo.centerXAnchor),
            coinSymbol.topAnchor.constraint(equalTo: coinLogo.bottomAnchor, constant: 10),
            
            coinPrice.topAnchor.constraint(equalTo: coinSymbol.bottomAnchor,constant: 10),
            coinPrice.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            coinChange.topAnchor.constraint(equalTo: coinPrice.bottomAnchor, constant: 10),
            coinChange.leadingAnchor.constraint(equalTo: coinPrice.leadingAnchor),
            
            coinVolume.topAnchor.constraint(equalTo: coinChange.bottomAnchor, constant: 10),
            coinVolume.leadingAnchor.constraint(equalTo: coinChange.leadingAnchor),
            
            coinMarketCap.topAnchor.constraint(equalTo: coinVolume.bottomAnchor, constant: 10),
            coinMarketCap.leadingAnchor.constraint(equalTo: coinVolume.leadingAnchor)
            
        ])
    }
    
    
    
    
    
    
}
