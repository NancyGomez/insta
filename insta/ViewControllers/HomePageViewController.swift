//
//  HomePageViewController.swift
//  insta
//
//  Created by Nancy Gomez on 2/25/18.
//  Copyright © 2018 Nancy Gomez. All rights reserved.
//

import UIKit
import Parse

class HomePageViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
     var posts: [Post] = []
    
    @IBAction func onLogOut(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    func fetchPosts(){
        let query = Post.query()
        query?.limit = 20
        query?.order(byDescending: "_created_at")
        // fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts, error) in
            if  posts != nil {
                // do something with the data fetched
                self.posts = posts as! [Post]
                self.tableView.reloadData()
            } else {
                // handle error
                print(error?.localizedDescription)
            }
        })
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
//        let post = posts[indexPath.section]
//        cell.postCaptionLabel.text = post.caption
//        cell.postImageView.file = post.media
//        cell.postImageView.loadInBackground()
        return cell
    }

}
