//
//  PostDetailViewController.swift
//  insta
//
//  Created by Nancy Gomez on 2/26/18.
//  Copyright © 2018 Nancy Gomez. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

    @IBAction func onHomePage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homePageViewController = storyboard.instantiateViewController(withIdentifier: "homePageViewController")
        self.present(homePageViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
