//
//  FavoritesViewController.swift
//  RandomEats
//
//  Created by Axel Guzman on 4/25/16.
//  Copyright © 2016 RandomEats. All rights reserved.
//

import UIKit


class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let arrayKey = "arrayKey"
    var arrayObjects : [Favorites] = []
    
    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        var arrayData = defaults.dataForKey(arrayKey)!
        var arrayUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(arrayData) as! [Favorites]
        arrayObjects = arrayUnarchived
        
        self.tableView.reloadData()
        
        for items in arrayUnarchived {
            print(items.name)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return arrayObjects.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Randm", forIndexPath: indexPath) as! RandomCell
        
        let choice = arrayObjects[indexPath.row]
        
        cell.name.text = choice.name
        cell.address.text = choice.address
        cell.imageUrl.setImageWithURL(choice.resturantImage)
        cell.rating.text = choice.rating
        cell.ratingImage.setImageWithURL(choice.ratingImage)
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
