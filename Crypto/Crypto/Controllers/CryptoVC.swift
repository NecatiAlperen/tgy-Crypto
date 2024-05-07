//
//  CryptoVC.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 5.05.2024.
//

import UIKit

class CryptoVC: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier) // Corrected register method
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.placeholder = "Search"
            searchBar.delegate = self
            return searchBar
        }()
    
    
    private let webservice = Webservice()
    
    private var coins: [Coin] = [] {
            didSet {
                tableView.reloadData()
            }
        }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cryptos"
        setupUI()
        fetchCoins()
        
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
    private func setupUI(){
            view.backgroundColor = .systemBlue
            view.addSubview(searchBar)
            view.addSubview(tableView)
            
            // Set searchBar's constraints
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            // Set tableView's constraints
            tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
}





// MARK: - UITableViewDataSource
extension CryptoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError()
        }
        
        cell.configure(with: coins[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

// MARK: - UITableViewDelegate
extension CryptoVC: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
    }
}

extension CryptoVC : UISearchBarDelegate {
    
}
