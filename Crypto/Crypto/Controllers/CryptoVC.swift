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
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
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
            updateNoResultViewVisibility()
        }
    }
    private var filteredCoins: [Coin] = [] {
        didSet {
            updateNoResultViewVisibility()
            tableView.reloadData()
            
        }
    }
    private var isFiltering: Bool {
        return !searchBar.text!.isEmpty
    }
    private let noResultView = NoResultView()
    
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
    
    private func setupUI() {
        view.backgroundColor = .systemBlue
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(noResultView)
        
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
        
        // Set noResultView's constraints
        noResultView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noResultView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            noResultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noResultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noResultView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Hide noResultView initially
        noResultView.isHidden = true
    }
    
    private func updateNoResultViewVisibility() {
        noResultView.isHidden = isFiltering ? !filteredCoins.isEmpty : !coins.isEmpty
    }
}

// MARK: - UITableViewDataSource
extension CryptoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCoins.count : coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError()
        }
        let coin = isFiltering ? filteredCoins[indexPath.row] : coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

// MARK: - UITableViewDelegate
extension CryptoVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = coins[indexPath.row]
        let vc = CryptoDetailVC(coin)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension CryptoVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCoins = coins.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
    
}
