//
//  DataService.swift
//  devslopes-social
//
//  Created by Jose Monge on 4/27/20.
//  Copyright © 2020 Jose Monge. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

let DB_BASE = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_POST_IMAGES: StorageReference {
        return _REF_POST_IMAGES
    }
    
    func createFirebaseUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }

    func createPost(aPost: Post) {
        REF_POSTS.childByAutoId().updateChildValues(["caption": aPost.caption, "imageUrl": aPost.imageUrl, "likes": aPost.likes])
    }
    
}
