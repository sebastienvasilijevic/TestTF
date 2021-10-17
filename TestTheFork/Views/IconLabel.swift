//
//  IconLabel.swift
//  TestTheFork
//
//  Created by VASILIJEVIC Sebastien on 16/10/2021.
//

import UIKit

class IconLabel: UIView {
    private lazy var stackView: UIStackView = {
        let view: UIStackView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = Constants.margins/2
        return view
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let view: UIImageView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private(set) lazy var textLabel: UILabel = {
        let label: UILabel = .init()
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize-2, weight: .light)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .darkText
        label.numberOfLines = 1
        return label
    }()
    
    init(frame: CGRect, icone: UIImage?, text: String) {
        super.init(frame: frame)
        
        imageView.image = icone
        textLabel.text = text
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
    
    public func setText(_ text: String, hideIconIfEmpty: Bool) {
        self.textLabel.text = text
        
        if hideIconIfEmpty {
            self.imageView.isHidden = self.textLabel.text?.isEmpty ?? false
        }
    }
}
