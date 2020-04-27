//
//  FeedTableViewCell.swift
//  devslopes-social
//
//  Created by Jose Monge on 4/27/20.
//  Copyright © 2020 Jose Monge. All rights reserved.
//

import UIKit
import FirebaseStorage

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

    func bind(aPost: Post, img: UIImage? = nil) {
        self.caption.text = aPost.caption
        self.likesLbl.text = "\(aPost.likes)"
        
        if nil == img {
            let ref = Storage.storage().reference(forURL: aPost.imageUrl)
            ref.getData(maxSize: 2 * 1014 * 1024, completion: { (data, error) in
                if nil != error {
                    print("Could not get image due to: \(String(describing: error))")
                } else {
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedViewController.imageCache.setObject(img, forKey: aPost.imageUrl as NSString)
                        }
                    }
                }
            })
        } else {
            self.postImg.image = img
        }
        
    }
    
}
