//
//  FavoritesVC.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 8.05.2024.
//

import UIKit

final class FavoritesVC: UIViewController {
    
    //MARK: -- VARIABLES
    private let webservice = Webservice()
    private let noFavoriteView = NoFavoritesView()
    
    private var coins: [Coin] = [] {
        didSet {
            filterCoins()
        }
    }
    private var favoriteCoins: [Coin] = [] {
        didSet {
            if favoriteCoins.isEmpty {
                tableView.backgroundView = noFavoriteView
            } else {
                tableView.backgroundView = nil
                tableView.reloadData()
            }
        }
    }
    
    private var coinsUUID = [String]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    //MARK: -- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Favorites"
        setupUI()
        fetchCoins()
        getData()
        filterCoins()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    //MARK: -- FUNCTIONS
    private func filterCoins(){
        favoriteCoins = coins.filter { coinsUUID.contains($0.uuid ?? "")
        }
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
    
    private func getData() {
        if let savedCoins = UserDefaults.standard.array(forKey: "favoriteList") as? [String] {
            coinsUUID = savedCoins
            filterCoins()
        } else {
            print("get data else")
        }
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
//MARK: -- EXTENSIONS
extension FavoritesVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            self?.removeFavoriteCoin(at: indexPath)
            completionHandler(true)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = true
        return swipeConfiguration
    }
    
    private func removeFavoriteCoin(at indexPath: IndexPath) {
        let removedCoin = favoriteCoins.remove(at: indexPath.row)
        if let index = coinsUUID.firstIndex(of: removedCoin.uuid ?? "") {
            coinsUUID.remove(at: index)
            UserDefaults.standard.set(coinsUUID, forKey: "favoriteList")
        }
        tableView.reloadData()
    }
}

extension FavoritesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError("CoinCell cannot be dequeued")
        }
        let favoriteCoin = favoriteCoins[indexPath.row]
        cell.configure(with: favoriteCoin)
        return cell
    }
}



