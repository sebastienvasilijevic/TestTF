//
//  ListRestaurantsViewController.swift
//  TestTheFork
//
//  Created by VASILIJEVIC Sebastien on 14/10/2021.
//

import UIKit

class ListRestaurantsViewController: UIViewController {
    
    // MARK: - Data
    
    var restaurants: [Restaurant] = [] {
        didSet {
            self.restaurantsTableView.reloadData()
        }
    }
    
    var sortType: SortType = .name {
        didSet {
            sortRestaurants(self.sortType)
        }
    }
    
    
    // MARK: - Views
    
    lazy var restaurantsTableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.separatorColor = .clear
        tableView.layoutMargins = .zero
        tableView.backgroundView = nil
        tableView.isScrollEnabled = true
        tableView.tableHeaderView = nil
        tableView.tableFooterView = nil
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.estimatedRowHeight = RestaurantTableViewCell.cellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
        return tableView
    }()

    override func loadView() {
        super.loadView()
        
        self.configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadRestaurants()
    }
    
    private func configure() {
        self.view.backgroundColor = .white
        
        self.title = "restaurants".localized
        
        self.view.addSubview(restaurantsTableView)
        
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(named: Constants.Images.sort), style: .plain, target: self, action: #selector(sortAction))
        
        NSLayoutConstraint.activate([
            restaurantsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            restaurantsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            restaurantsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            restaurantsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadRestaurants() {
        WebServices.loadRestaurants { restaurants, success in
            guard let restaurants = restaurants else {
                return
            }
            
            self.restaurants = restaurants.data
            self.sortType = .name
        }
    }
    
    private func scrollToTopAndReloadData() {
        if numberOfSections(in: self.restaurantsTableView) > 0 && tableView(self.restaurantsTableView, numberOfRowsInSection: 0) > 0 {
            self.restaurantsTableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: false)
        }
        self.restaurantsTableView.reloadData()
    }
    
    private func sortRestaurants(_ sortType: SortType) {
        switch sortType {
        case .name:
            self.restaurants.sort(by: { ($0.name ?? "") < ($1.name ?? "") })
        case .ratingTheFork:
            self.restaurants.sort(by: { ($0.aggregateRatings?.thefork?.ratingValue ?? 0) > ($1.aggregateRatings?.thefork?.ratingValue ?? 0) })
        case .ratingTripAdvisor:
            self.restaurants.sort(by: { ($0.aggregateRatings?.tripadvisor?.ratingValue ?? 0) > ($1.aggregateRatings?.tripadvisor?.ratingValue ?? 0) })
        }
        
        self.scrollToTopAndReloadData()
    }
    
    @objc func sortAction() {
        let alertController: UIAlertController = .init(title: "sort_by".localized, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(.init(title: "sort_name".localized, style: .default, handler: { [weak self] action in
            self?.sortType = .name
        }))
        
        alertController.addAction(.init(title: "sort_ratingTheFork".localized, style: .default, handler: { [weak self] action in
            self?.sortType = .ratingTheFork
        }))
        
        alertController.addAction(.init(title: "sort_ratingTripAdvisor".localized, style: .default, handler: { [weak self] action in
            self?.sortType = .ratingTripAdvisor
        }))
        
        alertController.addAction(.init(title: "sort_cancel".localized, style: .destructive, handler: { action in
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableView dataSource & delegate
extension ListRestaurantsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 26.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: UILabel = .init(frame: .init(x: Constants.margins, y: 0, width: tableView.frame.width, height: 26.0))
        
        label.text = "sorted_by".localized + " " + "sort_\(self.sortType.rawValue)".localized
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        let labelView: UIView = .init(frame: .init(x: 0, y: 0, width: label.frame.width, height: label.frame.height))
        labelView.backgroundColor = .white
        labelView.addSubview(label)
        
        return labelView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.configure(with: self.restaurants[indexPath.row])
        
        cell.favoriteHandler = { [weak self] cell in
            CoreDataServices.toggleFavoriteRestaurant(for: cell.restaurant)
            self?.restaurantsTableView.reloadData()
        }
        
        return cell
    }
}
