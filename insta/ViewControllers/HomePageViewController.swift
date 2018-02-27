//
//  HomePageViewController.swift
//  insta
//
//  Created by Nancy Gomez on 2/25/18.
//  Copyright © 2018 Nancy Gomez. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomePageViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    var refreshControl : UIRefreshControl!
    
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
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomePageViewController.didPullToReFresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        fetchPosts()
    }
    
    @objc func didPullToReFresh(_ refreshControl: UIRefreshControl){
        fetchPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Posts count: ", posts.count)
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.postCaptionLabel.text = post.caption
        print(post.media)
        print(cell.postImageView)
        cell.postImageView.file = post.media
        cell.postImageView.loadInBackground()
        return cell
    }
    
    // Pass information to the detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetail") {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                print("TYPE OF: ", type(of: post))
                let postDetailViewController = segue.destination as! PostDetailViewController
                postDetailViewController.post = post
            }
        }
    }
    
    func goBack(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homePageViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
        self.present(homePageViewController, animated: true, completion: nil)
    }

}
