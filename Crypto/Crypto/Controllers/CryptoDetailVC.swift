//
//  CryptoDetailVC.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 6.05.2024.
//

import UIKit

class CryptoDetailVC: UIViewController {
    
    private lazy var coinLogo : UIImageView = {
        let imageView = UIImageView()
        view.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var coinName : UILabel = {
      let label = UILabel()
        return label
    }()
    
    private lazy var coinSymbol : UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var marketCap : UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var coinPrice : UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var coinChange : UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var coinVolume : UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}
