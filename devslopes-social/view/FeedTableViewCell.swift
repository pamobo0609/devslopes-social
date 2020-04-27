//
//  FeedTableViewCell.swift
//  devslopes-social
//
//  Created by Jose Monge on 4/27/20.
//  Copyright © 2020 Jose Monge. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var content: FancyView!
    @IBOutlet weak var profileImg: FancyRoundImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        content.addShadow()
        profileImg.circle()
        
    }

    func bind(aPost: Post) {
        caption.text = aPost.caption
        likesLbl.text = "\(aPost.likes)"
    }
    
}
