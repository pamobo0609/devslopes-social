//
//  Post.swift
//  devslopes-social
//
//  Created by Jose Monge on 4/27/20.
//  Copyright © 2020 Jose Monge. All rights reserved.
//

import Foundation

class Post {
    
    private var _postId: String!
    var postId: String {
        return _postId
    }
    
    private var _caption: String!
    var caption: String {
        return _caption
    }
    
    private var _imageUrl: String!
    var imageUrl: String {
        return _imageUrl
    }
    
    private var _likes: Int!
    var likes: Int {
        return _likes
    }
    
    init(caption: String, imageUrl: String, likes: Int) {
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
    }
    
    init(postId: String, postData: Dictionary<String, Any>) {
        self._postId = postId
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
    }
    
}
