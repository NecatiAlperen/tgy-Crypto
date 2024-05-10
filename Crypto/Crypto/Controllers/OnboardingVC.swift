//
//  OnboardingVC.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 5.05.2024.
//

import UIKit

class OnBoardingViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let pageControl = UIPageControl()
    let skipButton = UIButton()

    var pages = [UIViewController]()
    let initialPage = 0
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension OnBoardingViewController {
    
    func setup() {
        // Onboarding sayfaları
        let page1 = createPage(imageName: "1", titleText: "Welcome To Cryptos", subtitleText: "You can easily track your cryptos")
        let page2 = createPage(imageName: "2", titleText: "Make your own list", subtitleText: "kendi favoriler listeni oluşturalabilir...")
        let page3 = createPage(imageName: "3", titleText: "Search what do you want", subtitleText: "ulaşmak istediğin coin için kolay arama yapabilirsin")
        
        pages = [page1, page2, page3]
        
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        view.addSubview(pageControl)
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitle("Tanıtımı Atla", for: .normal)
        skipButton.setTitleColor(.systemBlue, for: .normal)
        skipButton.addTarget(self, action: #selector(skipTapped(_:)), for: .primaryActionTriggered)
        view.addSubview(skipButton)
    }
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    func createPage(imageName: String, titleText: String, subtitleText: String) -> UIViewController {
        let page = UIViewController()
        let stackView = UIStackView()
        let imageView = UIImageView()
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = titleText
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        stackView.addArrangedSubview(titleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = subtitleText
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        stackView.addArrangedSubview(subtitleLabel)
        
        page.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: page.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: page.view.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: page.view.widthAnchor, multiplier: 0.5)
        ])
        
        return page
    }
    
    @objc func skipTapped(_ sender: UIButton) {
        let tabbar = TabbarController()
        tabbar.modalPresentationStyle = .fullScreen
        present(tabbar, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource

extension OnBoardingViewController {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
}

// MARK: - UIPageViewControllerDelegate

extension OnBoardingViewController {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentViewController = pageViewController.viewControllers?.first,
              let currentIndex = pages.firstIndex(of: currentViewController) else { return }
        pageControl.currentPage = currentIndex
    }
}

