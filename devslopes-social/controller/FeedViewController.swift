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
import FirebaseStorage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,
                            UINavigationControllerDelegate {

    static let imageCache: NSCache<NSString, UIImage> = NSCache()
    
    @IBOutlet weak var feedContainer: FancyView!
    @IBOutlet weak var newPostContainer: FancyView!
    @IBOutlet weak var imageAdd: CircleView!
    @IBOutlet weak var postCaption: UITextField!
    @IBOutlet weak var postButton: FancyRoundButton!
    @IBOutlet weak var tableView: UITableView!
    
    var imagePicker: UIImagePickerController!
    
    var imageSelected = false
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedContainer.addShadow()
        newPostContainer.addShadow()
        postButton.circle()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
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
    
    @IBAction func onSelectImageClick(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onPostClick(_ sender: FancyRoundButton) {
        guard let caption = postCaption.text, caption != "" else {
            print("Caption is mandatory")
            return
        }
        
        guard let image = imageAdd.image, true == imageSelected else {
            print("An image is mandatory")
            return
        }
        
        if let imgData = image.jpegData(compressionQuality: 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let ref = DataService.ds.REF_POST_IMAGES.child(imgUid)
            ref.putData(imgData, metadata: metadata, completion: { (metadata, error) in
                ref.downloadURL(completion: { (url, error) in
                    if nil == error {
                        print("File uploaded. Download url: \(String(describing: url?.absoluteString))")
                        
                        guard let imageUrl = url?.absoluteString else {
                            return
                        }
                        
                        DataService.ds.createPost(aPost: Post(caption: caption, imageUrl: imageUrl, likes: 0))
                        self.postCaption.text = ""
                        self.imageAdd.image = UIImage(named: "add-image")
                        
                    } else {
                        print("Upload failed due to: \(String(describing: error))")
                    }
                })
            })
            
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
            
            let aPost = posts[indexPath.row]
            
            if let img = FeedViewController.imageCache.object(forKey: aPost.imageUrl as NSString) {
                aCell.bind(aPost: aPost, img: img)
            } else {
                aCell.bind(aPost: aPost)
            }
            
            return aCell
        }
        return UITableViewCell()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageAdd.image = image
            imageSelected = true
        } else {
            print("Image not selected!")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
