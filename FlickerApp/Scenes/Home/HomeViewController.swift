
//
//  HomeViewController.swift
//  FlickerApp
//
//  Created by Ömer Şahin on 12.06.2019.
//  Copyright © 2019 Ömer Şahin. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


class HomeViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
    var myData: MasterResponse?
    var exploreItems:[ExploreItem] = []
    
    
    @IBOutlet weak var exploreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getJsonData()
        exploreTableView.register(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularTableViewCell")
        
        
        
    }
    func getJsonData() {
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=6eda6192cef025fa4b3b49b37a0cee13&extras=description,license,date_upload,date_taken,owner_name,icon_server,url_m&sort=views,comments,defaults&format=json&nojsoncallback=?")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                if data != nil {
                    
                    do {
                        
                        let jSONResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,AnyObject>
                        
                        DispatchQueue.main.async {
                            //print(jSONResult)
                            
                            let photos = jSONResult["photos"] as! [String:AnyObject]
                            
                            //print(photos)
                            let photo = photos["photo"] as! NSArray
                            var i = 0
                            while i < photo.count - 1 {
                                
                                
                                let oo = photo[i] as! NSDictionary
                                if oo["url_m"] == nil {
                                    break
                                } else {
                                    let urlm = oo["url_m"] as! String
                                    let height = Int(oo["height_m"] as! String) ?? 0
                                    let width = Int(oo["width_m"] as! String) ?? 0
                                    
                                    let owner = oo["ownername"] as! String
                                    let title = oo["title"] as! String
                                    let id = oo["owner"] as! String
                                    var farm = oo["farm"] as! Int
                                    var icon_server = Int(oo["iconserver"] as! String) ?? 0
                                    var url = "http://farm"
                                    url.append(String(farm))
                                    url.append(".staticflickr.com/")
                                    url.append(String(icon_server))
                                    url.append("/buddyicons/")
                                    url.append(id)
                                    url.append(".jpg")
                                    let exploreItem = ExploreItem(name:title , image: urlm , icon: url, ownerName:owner, ratio: Float(height)/Float(width))
                                    self.exploreItems.append(exploreItem)
                                }
                                i = i + 1
                                self.exploreTableView.reloadData()
                                
                                
                            }
                            
                            self.exploreTableView.reloadData()
                            
                        }
                    } catch {
                        
                    }
                    
                }
                
                
            }
            
            
        }
        
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return exploreItems.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.layer.frame.width * CGFloat(exploreItems[indexPath.row].ratio))
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PopularTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
        cell.configure(exploreItems[indexPath.row])
        
        
        
        
        
        return cell
        
    }
    
    
    
    
    
}










