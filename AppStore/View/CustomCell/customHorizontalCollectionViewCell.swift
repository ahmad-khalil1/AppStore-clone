//
//  customHorizontalCollectionViewCell.swift
//  AppStore
//
//  Created by ahmad$$ on 2/27/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class customHorizontalCollectionViewCell: UICollectionViewCell {
    
    let iconImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 8
        image.contentMode = .scaleAspectFit
        //image.layer.borderWidth = 0.25
        //image.layer.borderColor = (srgbRed: 1, green: 2, blue: 2, alpha: 2) as! CGColor
        image.clipsToBounds = true
        image.backgroundColor = .black
        //
        return image
    }()
    
    let titleLabel : UILabel = {
        let label                                             = UILabel()
        label.font                                            = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints       = false
        label.text                                            = "AppName"
        label.textColor                                       = .black
        //label.backgroundColor = .black
        
        return label
    }()
    
    let categoryLabel : UILabel = {
        let label                                            = UILabel()
        label.font                                           = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints      = false
        label.text                                           = "AppCategory"
        label.textColor                                      = .black
        //label.backgroundColor = .black


        return label
    }()
    
    let getButton : UIButton = {
        let button                                           = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints     = false
        button.backgroundColor                               = UIColor(white: 0.95, alpha: 1)
        button.layer.cornerRadius                            = 15
        button.titleLabel?.font                              = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("GET", for: .normal)
        button.addTarget(self, action: #selector(getButtonTaped), for: .touchUpInside)
        
        return button
    }()
    
    let horizontalStackView : UIStackView = {
        let stackView                                        = UIStackView()
        stackView.distribution                               = .fillProportionally
        stackView.axis                                       = .horizontal
        stackView.spacing                                    = 14
        stackView.alignment                                  = .center
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        return stackView
    }()
    
    let verticalStackView : UIStackView = {
        let stackView                                        = UIStackView()
        stackView.distribution                               = .fill
        stackView.axis                                       = .vertical
        stackView.spacing                                    = 4
        stackView.alignment                                  = .leading
        stackView.translatesAutoresizingMaskIntoConstraints  = false

        return stackView
    }()
    
    @objc func getButtonTaped(_ sender : UIButton ) {
        sender.backgroundColor = .orange
    }
    
    func addingUIElemntsTotheView(){
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(categoryLabel)

        horizontalStackView.addArrangedSubview(iconImage)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(getButton)
        horizontalStackView.setCustomSpacing(80, after: horizontalStackView.arrangedSubviews[1])

        addSubview(horizontalStackView)

    }
    
    func setupUIConstrains() {

        iconImage.widthAnchor.constraint(equalToConstant: 64).isActive         = true
        iconImage.heightAnchor.constraint(equalToConstant: 64).isActive         = true

        getButton.widthAnchor.constraint(equalToConstant: 70).isActive         = true
        getButton.heightAnchor.constraint(equalToConstant: 32).isActive         = true
//
        horizontalStackView.centerYAnchor.constraint(equalTo: self.layoutMarginsGuide.centerYAnchor).isActive       = true
        horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive       = true
        horizontalStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive       = true
        horizontalStackView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor).isActive      = true
        //horizontalStackView.heightAnchor.constraint(equalToConstant: 69).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addingUIElemntsTotheView()
        setupUIConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
