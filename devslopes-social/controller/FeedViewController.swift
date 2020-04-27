//
//  FeedViewController.swift
//  devslopes-social
//
//  Created by Jose Monge on 4/25/20.
//  Copyright © 2020 Jose Monge. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var feedContainer: FancyView!
    @IBOutlet weak var newPostContainer: FancyView!
    @IBOutlet weak var postButton: FancyRoundButton!
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedContainer.addShadow()
        newPostContainer.addShadow()
        postButton.circle()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { snapshot in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                
                self.posts.removeAll()
                
                for snap in snapshot {

                    if let postDict = snap.value as? Dictionary<String, Any> {
                        let post = Post(postId: snap.key, postData: postDict)
                        self.posts.append(post)
                    }
                    
                }
                print(self.posts.count)
            }
            self.tableView.reloadData()
        })
        
    }
    
    @IBAction func onSignOutClick(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print("Sign out failed due to: \(error)")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let aCell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier) as? FeedTableViewCell {
            aCell.bind(aPost: posts[indexPath.row])
            return aCell
        }
        return UITableViewCell()
    }
    
}
