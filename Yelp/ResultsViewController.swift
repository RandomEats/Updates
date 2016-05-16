//
//  ResultsViewController.swift
//  RandomEats
//
//  Created by Maliha Fairooz on 4/25/16.
//  Copyright © 2016 RandomEats. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ResultsViewController: UIViewController , CLLocationManagerDelegate{
    
    var category: String = ""
    var resturant: Business!
    let defaults = NSUserDefaults.standardUserDefaults()

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var foodMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding location manager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.distanceFilter = 300
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        // Do any additional setup after loading the view.
        Business.searchWithTerm(category, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            var randomIndex: Int?
            randomIndex = random() % businesses.count
            print(businesses[randomIndex!].name)
            self.resturant = businesses[randomIndex!]
            
            
            //load ui views
            self.imageView.setImageWithURL(self.resturant.imageURL!)
            self.ratingImage.setImageWithURL(self.resturant.ratingImageURL!)
            self.addressLabel.text = self.resturant.address!
            self.nameLabel.text = self.resturant.name
            let s:String = String(format:"%.1f", self.resturant.rating!.doubleValue)
            self.ratingLabel.text = s
            
           
        })
        
        
    }
    
    //Asking for permission
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func addToFavorite(sender: AnyObject) {
        let arrayKey = "arrayKey"
        
        let s:String = String(format:"%.1f", self.resturant.rating!.doubleValue)
        
        var arrayOfObjects = [Favorites]()
        
        var item = Favorites(name: resturant.name!, address: resturant.address!, resturantImage: resturant.imageURL!, rating: s, ratingImage: resturant.ratingImageURL!)
        
        arrayOfObjects.append(item)
        
        print("here we go")
        var arrayData = NSKeyedArchiver.archivedDataWithRootObject(arrayOfObjects)
        print("here we go")
        defaults.setObject(arrayData, forKey: arrayKey)
        print("go away")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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