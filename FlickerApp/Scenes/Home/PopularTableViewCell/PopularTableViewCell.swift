

//
//  PopularTableViewCell.swift
//  FlickerApp
//
//  Created by Ömer Şahin on 13.06.2019.
//  Copyright © 2019 Ömer Şahin. All rights reserved.
//

import UIKit
import Kingfisher

struct ExploreItem {
    var name:String
    var image:String
    var icon:String
    var ownerName:String
    var ratio:Float
}

class PopularTableViewCell: UITableViewCell {
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var IconView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        IconView.layer.cornerRadius = IconView.frame.size.width / 2
        
    }
    
    func configure(_ item:ExploreItem){
        ImageView.kf.setImage(with: URL(string: item.image))
        ownerLabel.text = item.ownerName
        titleLabel.text = item.name
        IconView.kf.setImage(with: URL(string: item.icon))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

