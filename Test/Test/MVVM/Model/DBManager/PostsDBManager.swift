//
//  PostsDBManager.swift
//  Test
//
//  Created by Mher Movsisyan on 10/10/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import RealmSwift

class PostsDBManager {

    static let shared = PostsDBManager()
    
    private init() {}
    
    func addPost(_ post: Post) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(post, update: true)
            }
        } catch let error {
            print("Got error when access to realm \(error.localizedDescription)")
        }
    }
    
    func addPosts(_ posts: [Post]) {
        posts.forEach{addPost($0)}
    }
    
    func getUser() -> Results<Post>? {
        do {
            let realm = try Realm()
            return realm.objects(Post.self)
        } catch let error {
            print("Got error when access to realm \(error.localizedDescription)")
            return nil
        }
    }
}
