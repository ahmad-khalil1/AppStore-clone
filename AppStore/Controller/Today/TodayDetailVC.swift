//
//  TodayDetailVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/13/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class TodayDetailVC: UITableViewController {
    
    //MARK:- VC Properties and objects.

    let headerCellHeight                   : CGFloat  = 480

    var completion : (() -> ())?
    var isCloseButtonHidden : Bool? {
        didSet{
            self.tableView.reloadData()
        }
    } 
    var todayItem : todayItem? {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    //MARK:- UI Elements.

    fileprivate func configureTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        //        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 0 , left: 0, bottom: 20, right: 0)
        tableView.allowsSelection = false
        tableView.register(TableCell.self, forCellReuseIdentifier: "cellId")
    }
    
    //MARK:- Handling Events

    @objc func handelCloseButtonClicked(button : UIButton , gesture : UITapGestureRecognizer? = nil) {
        if let completion  = completion {
            completion()
        }
        button.alpha = 0
    }
    
    //MARK:- View Life Cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cellType = todayItem?.itemCellType else {return UITableViewCell()}
            guard let todayItem = todayItem  else {  return UITableViewCell()}
            
            switch cellType {
            case .list:
                return configureTodayDeatailHeaderCell(todayItem,DailyListCVC())
            case .today:
                return configureTodayDeatailHeaderCell(todayItem,TodayCVC())
            }
        }
        return  TableCell()
    }
    
    fileprivate func configureTodayDeatailHeaderCell(_ todayItem: todayItem  ,_ baseCell : TodayBaseCell ) -> UITableViewCell {
        let cell =  TodayHeaderCell()
        cell.todayCell = baseCell
        cell.todayCell!.todayitem = todayItem
        cell.closeButton.addTarget(self, action: #selector(handelCloseButtonClicked), for: .touchUpInside)
        if let isCloseButtonHidden = self.isCloseButtonHidden {
            cell.closeButton.isHidden = isCloseButtonHidden
        }
        cell.todayCell!.contentView.layer.cornerRadius = 0
        return cell
    }
    

    // MARK: - TableView Delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return headerCellHeight
        }
        return 460
    }


}

//MARK:- TableView Regular cell Class

class TableCell : UITableViewCell {
    let descriptionLabel : UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Great games", attributes: [.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: " are all about the details, from subtle visual effects to imaginative art styles. In these titles, you're sure to find something to marvel at, whether you're into fantasy worlds or neon-soaked dartboards.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.gray]))
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func addingUIElemntsTotheView() {
        addSubview(descriptionLabel)

    }
    
    fileprivate func setupUIConstrains() {
        
        descriptionLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive             = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor , constant: 24  ).isActive    = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor , constant: -24 ).isActive  = true
        //        descriptionLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive       = true
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addingUIElemntsTotheView()
        setupUIConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- TableView Header cell Class


class TodayHeaderCell : UITableViewCell {
    
    var todayCell : TodayBaseCell? {
        didSet{
            addingUIElemntsTotheView()
            setupUIConstrains()
        }
    }
    
    
    let closeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "closeButton"), for: .normal)
//        button.backgroundColor = .lightGray
        button.clipsToBounds = true
        return button
    }()
    
    fileprivate func addingUIElemntsTotheView() {
        if let todayCell = self.todayCell {
            addSubview(todayCell)
        }
        addSubview(closeButton)
    }
    
    fileprivate func setupUIConstrains() {
        
        
        closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor , constant: 30 ).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor , constant: -5 ).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        if let todayCell = self.todayCell {
            todayCell.translatesAutoresizingMaskIntoConstraints = false
            todayCell.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive            = true
            todayCell.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive    = true
            todayCell.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive  = true
            todayCell.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive      = true
        }
       
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addingUIElemntsTotheView()
        setupUIConstrains()
    }
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}


    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        return TodayCVC()
    //    }
//
//
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 400
//    }
//
