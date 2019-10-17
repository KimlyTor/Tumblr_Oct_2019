//
//  PhotosViewController.swift
//  Tumblr_Oct_2019
//
//  Created by KimlyT. on 10/17/19.
//  Copyright © 2019 KimlyT. All rights reserved.
//

import AlamofireImage
import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    
     @IBOutlet weak var tableView: UITableView! // tableView outlet

     var posts: [[String: Any]] = []

     override func viewDidLoad() {
           super.viewDidLoad()
           
           retrievePosts()
           tableView.delegate = self
           tableView.dataSource = self
           
         

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
                       self.tableView.reloadData()  // last step : update table view for new data 
                   }
               }
               task.resume()
       }

    
    //MARK: - Implementation of the table view methods -- set number of rows for the table view and to return the cell for each row
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count  // number of rows depends on how many post from the api
                            // if posts contains nil then can be in trouble but posts alr initialized to an empty array
     }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         //let cell = UITableViewCell()
         //cell.textLabel?.text = "This is row\(indexPath.row)"
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row] // pull out a single post from posts array
        if let photos = post["photos"] as? [[String: Any]]{
            // photos is NOT nil, we can use it!
            let photo = photos[0] // get the first photo in the photos array
            let originalSize = photo["original_size"] as! [String: Any] // get the original size dictionary
            let urlString = originalSize["url"] as! String // get the url string from the original size dictionary
            let url = URL(string: urlString) // creat a URL using the urlString
            
            cell.photoImageView.af_setImage(withURL: url!)
        }

        
        return cell
     }

}
