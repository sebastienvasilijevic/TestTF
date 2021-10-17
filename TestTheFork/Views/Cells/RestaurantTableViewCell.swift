//
//  RestaurantTableViewCell.swift
//  TestTheFork
//
//  Created by VASILIJEVIC Sebastien on 15/10/2021.
//

import UIKit

typealias RestaurantCellHandler = ((RestaurantTableViewCell) -> Void)

class RestaurantTableViewCell: UITableViewCell {
    
    static let identifier = "RestaurantTableViewCell"
    
    static let cellHeight: CGFloat = 400
    
    public var favoriteHandler: RestaurantCellHandler?
    
    private(set) var restaurant: Restaurant? {
        didSet {
            self.fillFields()
        }
    }
    
    // MARK: - Views
    
    private lazy var pictureImageView: UIImageView = {
        let view: UIImageView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button: UIButton = .init(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constants.Images.solidHeart), for: .normal)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.layer.cornerRadius = 18
        button.addAction(for: .touchUpInside) { control in
            self.favoriteHandler?(self)
        }
        return button
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let view: UIStackView = .init()
        view.axis = .horizontal
        view.spacing = Constants.margins*2
        return view
    }()
    
    private lazy var infoStackView: UIStackView = {
        let view: UIStackView = .init()
        view.axis = .vertical
        view.spacing = Constants.margins/2
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .darkText
        label.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize+6)
        label.adjustsFontSizeToFitWidth = true
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var addressIconLabel: IconLabel = {
        let iconLabel: IconLabel = .init(frame: .zero, icone: .init(named: Constants.Images.location), text: "")
        self.configureIconLabel(iconLabel)
        return iconLabel
    }()
    
    private lazy var foodIconLabel: IconLabel = {
        let iconLabel: IconLabel = .init(frame: .zero, icone: .init(named: Constants.Images.food), text: "")
        self.configureIconLabel(iconLabel)
        return iconLabel
    }()
    
    private lazy var priceIconLabel: IconLabel = {
        let iconLabel: IconLabel = .init(frame: .zero, icone: .init(named: Constants.Images.cash), text: "")
        self.configureIconLabel(iconLabel)
        return iconLabel
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let view: UIStackView = .init()
        view.axis = .vertical
        view.spacing = Constants.margins/2
        return view
    }()
    
    private lazy var tfIconLabel: IconLabel = {
        let iconLabel: IconLabel = .init(frame: .zero, icone: .init(named: Constants.Images.tfLogo), text: "")
        self.configureIconLabel(iconLabel)
        return iconLabel
    }()
    
    private lazy var taIconLabel: IconLabel = {
        let iconLabel: IconLabel = .init(frame: .zero, icone: .init(named: Constants.Images.taLogo), text: "")
        self.configureIconLabel(iconLabel)
        return iconLabel
    }()
    
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Methods
    
    private func configure() {
        self.selectionStyle = .none
        self.clipsToBounds = true
        
        let mainStackView: UIStackView = .init(arrangedSubviews: [pictureImageView, titleLabel, detailsStackView])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.clipsToBounds = true
        mainStackView.axis = .vertical
        mainStackView.spacing = Constants.margins
        self.contentView.addSubview(mainStackView)
        self.contentView.addSubview(favoriteButton)
        
        detailsStackView.addArrangedSubview(infoStackView)
        detailsStackView.addArrangedSubview(ratingStackView)
        
        infoStackView.addArrangedSubview(addressIconLabel)
        infoStackView.addArrangedSubview(foodIconLabel)
        infoStackView.addArrangedSubview(priceIconLabel)
        
        ratingStackView.addArrangedSubview(tfIconLabel)
        ratingStackView.addArrangedSubview(taIconLabel)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.margins),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.margins),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.margins),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.margins),
            mainStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -Constants.margins*2),
            
            favoriteButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Constants.margins*2),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.margins*2),
            favoriteButton.widthAnchor.constraint(equalToConstant: 36),
            favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor),
            
            pictureImageView.heightAnchor.constraintPriority999(equalToConstant: RestaurantTableViewCell.cellHeight/2),
            addressIconLabel.heightAnchor.constraintPriority999(equalToConstant: 22),
            foodIconLabel.heightAnchor.constraintPriority999(equalToConstant: 22),
            priceIconLabel.heightAnchor.constraintPriority999(equalToConstant: 22),
            tfIconLabel.heightAnchor.constraintPriority999(equalToConstant: 36),
            taIconLabel.heightAnchor.constraintPriority999(equalToConstant: 36),
        ])
    }
    
    private func configureIconLabel(_ iconLabel: IconLabel) {
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.clipsToBounds = true
        iconLabel.imageView.contentMode = .center
        iconLabel.imageView.backgroundColor = Constants.Colors.mainGreen.withAlphaComponent(0.2)
        iconLabel.imageView.layer.cornerRadius = 4
    }
    
    public func configure(with restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
    private func fillFields() {
        self.pictureImageView.download(from: self.restaurant?.mainPhoto?.uri ?? "", completion: nil)
        self.titleLabel.text = self.restaurant?.name ?? ""
        self.addressIconLabel.setText(self.restaurant?.address?.fullAddress() ?? "", hideIconIfEmpty: true)
        self.foodIconLabel.setText(self.restaurant?.servesCuisine ?? "", hideIconIfEmpty: true)
        self.priceIconLabel.setText(String(format: "%@ %@ %@", "average_price".localized, "\(self.restaurant?.priceRange ?? 0)", self.restaurant?.currenciesAccepted?.getCurrencySymbol() ?? ""), hideIconIfEmpty: true)
        
        self.tfIconLabel.setText(self.restaurant?.aggregateRatings?.getTheForkRating() ?? "", hideIconIfEmpty: true)
        self.taIconLabel.setText(self.restaurant?.aggregateRatings?.getTripAdvisorkRating() ?? "", hideIconIfEmpty: true)
        
        self.updateFavoriteButton()
        
        self.contentView.layoutIfNeeded()
    }
    
    private func updateFavoriteButton() {
        if CoreDataServices.isRestaurantExists(for: self.restaurant) {
            favoriteButton.setImage(UIImage(named: Constants.Images.filledHeart), for: .normal)
            
        } else {
            favoriteButton.setImage(UIImage(named: Constants.Images.solidHeart), for: .normal)
        }
    }
}
