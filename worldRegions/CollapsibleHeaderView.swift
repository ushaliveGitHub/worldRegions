//
//  CollapsibleHeaderView.swift
//  worldRegions
//
//  Created by Usha Natarajan on 8/29/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import UIKit
protocol CollapsibleHeaderViewDelegate{
    func toggleSection(header:CollapsibleHeaderView, section: Int)
}

class CollapsibleHeaderView: UITableViewHeaderFooterView {
    var delegate: CollapsibleHeaderViewDelegate?
    var section: Int!
    var arrowLabel = UILabel()
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textLabel?.textColor = UIColor.white
        self.contentView.backgroundColor = UIColor.darkGray
    }
    
    func customInit(title:String,expanded:Bool,section:Int,delegate:CollapsibleHeaderViewDelegate){
        self.textLabel?.text = title
        self.section = section
        self.setupArrow(expanded:expanded)
        self.delegate = delegate
    }
    
    func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer){
        let cell = gestureRecognizer.view as! CollapsibleHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func setupArrow(expanded:Bool){
        arrowLabel.text = "▼"
        if expanded {
            setCollapsed(collapsed:true)
        }
        arrowLabel.textColor = UIColor.white
        contentView.addSubview(arrowLabel)
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        arrowLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        arrowLabel.trailingAnchor.constraint(
            equalTo:self.trailingAnchor,constant: -20).isActive = true
    }
    
    func setCollapsed(collapsed: Bool) {
        arrowLabel.rotate(collapsed ? .pi : 0.0)
    }
}
