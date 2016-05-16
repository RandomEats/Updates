//
//  HomeViewController.swift
//  RandomEats
//
//  Created by Jaber Janati on 4/25/16.
//  Copyright © 2016 RandomEats. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let categories = ["Asian", "Fast Food", "Lunch", "Mexican", "Breakfast", "Mediterranean", "Japanese", "Random", "Deserts"]
    let icons = ["Noodles-50.png", "Hamburger-50.png", "Restaurant-50.png", "Taco-50.png", "Coffee to Go-50.png", "Vegetarian Food-50.png", "Sushi-50.png", "Question-50.png", "Ice Cream Cone-50.png"]
    var choice: Business?
    var categoryName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        //self.collectionView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categories.count != 0 {
            return categories.count
        }
        else {
            return 0
        }
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MenuCollection", forIndexPath: indexPath) as! ResultsCollectionViewCell
        
        let category = categories[indexPath.row]
        cell.title.text = category
        
        let imageIcon = UIImage(named: icons[indexPath.row])! as UIImage
        cell.tile.setImage(imageIcon, forState: .Normal)
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.orangeColor().CGColor
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            
            self.categoryName = categories[indexPath.row]
            print("Cell was clicked")
           
         
                        
        }
        print("Cell was not clikced")
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
   
        

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
      
            if segue.identifier! == "resultSegue" {
            
            
                let cell = sender as! UICollectionViewCell
                let indexPath = self.collectionView.indexPathForCell(cell)
                let cusine = self.categories[indexPath!.row]
           
                print("IS it ready")
            
                let resultsViewController = segue.destinationViewController as! ResultsViewController
                resultsViewController.category = cusine
                resultsViewController.resturant = self.choice
                print(self.choice?.name)
            
            }
            
            else if segue.identifier == "swipeSettings" {
                print("Swipe left")
            }
            
            else if segue.identifier == "swipeFavorites" {
                print("Swipe right")
            }
        
            
            print("prepare for segue");
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
        
}
