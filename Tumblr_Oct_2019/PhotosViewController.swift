//
//  PhotosViewController.swift
//  Tumblr_Oct_2019
//
//  Created by KimlyT. on 10/17/19.
//  Copyright © 2019 KimlyT. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    //MARK: -Properties
    
    var posts: [[String: Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrievePosts()
        
      

        // Do any additional setup after loading the view.
    }
    
    //MARK: -retrievePosts() is for network request to tumblr api then it is called in viewDidLoad( )
    
    private func retrievePosts(){
        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
               session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
        if let error = error {
                    print(error.localizedDescription)
                 } else if let data = data,
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(dataDictionary)

                    // TODO: Get the posts and store in posts property
                      let responseDictionary = dataDictionary["response"] as! [String: Any] // response is a dictionary that contains
                                                                                            // blog and posts
                      self.posts = responseDictionary["posts"] as! [[String: Any]] // posts is an array of dictionary that contains
                                                                                  // another array of dictionary such as photos
                      /* print(self.posts.count)  //printed 20 for posts count */
                     

                    // TODO: Reload the table view
                }
              }
              task.resume()
    }
   //MARK: -



}
