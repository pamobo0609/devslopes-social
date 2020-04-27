//
//  FeedTableViewCell.swift
//  devslopes-social
//
//  Created by Jose Monge on 4/27/20.
//  Copyright © 2020 Jose Monge. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var content: FancyView!
    @IBOutlet weak var profileImg: FancyRoundImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var likesButton: UIImageView!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    private var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        content.addShadow()
        profileImg.circle()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onLikeClick))
        tap.numberOfTapsRequired = 1
        likesButton.addGestureRecognizer(tap)
        likesButton.isUserInteractionEnabled = true
        
    }
    
    func bind(aPost: Post, img: UIImage? = nil) {
        self.post = aPost
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
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let likesRef = DataService.ds.REF_USERS.child(uid).child("likes").child(self.post.postId)
        likesRef.observeSingleEvent(of: .value, with: { snapshot in
            if let _ = snapshot.value as? NSNull {
                self.likesButton.image = UIImage(named: "empty-heart")
            } else {
                self.likesButton.image = UIImage(named: "filled-heart")
            }
        })
        
    }
    
    @objc func onLikeClick(sender: UITapGestureRecognizer) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let likesRef = DataService.ds.REF_USERS.child(uid).child("likes").child(self.post.postId)
        likesRef.observeSingleEvent(of: .value, with: { snapshot in
            if let _ = snapshot.value as? NSNull {
                likesRef.setValue(true)
                self.likesButton.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addLike: true)
            } else {
                likesRef.removeValue()
                self.likesButton.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addLike: false)
            }
        })
    }
    
}
