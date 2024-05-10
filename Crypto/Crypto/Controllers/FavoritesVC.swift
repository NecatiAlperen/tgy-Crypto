//
//  FavoritesVC.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 8.05.2024.
//

import UIKit
import CoreData

final class FavoritesVC: UIViewController {
    
    private let webservice = Webservice()
    
    private var coins: [Coin] = [] {
        didSet {
            filterCoins()
        }
    }
    
    private var coinsUUID = [String]()
    
    
    private var favoriteCoins = [Coin]()
    
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Favorites"
        setupUI()
        fetchCoins()
        getData()
    }
    
    
    private func filterCoins(){
        favoriteCoins = coins.filter { coinsUUID.contains($0.uuid!)
        }
        tableView.reloadData()
    }
        private func fetchCoins() {
            
            webservice.fetchCoins { result in
                switch result {
                case .success(let coins):
                    self.coins = coins
                case .failure(let error):
                    print("Error fetching coins: \(error.localizedDescription)")
                }
            }
        }
        
        
        
        func getData() {
            
            coinsUUID.append("razxDUgYGNAdQ")
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//            let context = appDelegate.persistentContainer.viewContext
//            
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteCoin")
//            do {
//                let favoriteCoins = try context.fetch(fetchRequest)
//                for favoriteCoin in favoriteCoins {
//                    if let uuid = favoriteCoin.value(forKey: "uuid") as? String {
//                        coinsUUID.append(uuid)
//                    }
//                }
//            } catch let error as NSError {
//                print("Could not fetch. \(error), \(error.userInfo)")
//            }
        }
        
        private func setupUI(){
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        }
    }
    
    extension FavoritesVC : UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            80
        }
    }
    
    
    extension FavoritesVC : UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            favoriteCoins.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
                fatalError()
            }
            let favoriteCoin = favoriteCoins[indexPath.row]
            cell.textLabel?.text = favoriteCoin.price
            return cell
        }
        
        
    }
