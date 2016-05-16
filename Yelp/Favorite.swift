//
//  Favorite.swift
//  Yelp
//
//  Created by The Boss on 5/15/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

class Favorites: NSObject, NSCoding{
    var name: String
    let address: String
    let resturantImage: NSURL
    let rating: String
    let ratingImage: NSURL
    
    init(name: String, address: String, resturantImage: NSURL, rating: String, ratingImage: NSURL) {
        self.name = name
        self.address = address
        self.resturantImage = resturantImage
        self.rating = rating
        self.ratingImage = ratingImage
    }
    
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObjectForKey("name") as! String
        self.address = decoder.decodeObjectForKey("address") as! String
        self.resturantImage = decoder.decodeObjectForKey("ratingImage") as! NSURL
        self.rating = decoder.decodeObjectForKey("rating") as! String
        self.ratingImage = decoder.decodeObjectForKey("ratingImage") as! NSURL
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.address, forKey: "address")
        aCoder.encodeObject(self.resturantImage, forKey: "resturantImage")
        aCoder.encodeObject(self.rating, forKey: "rating")
        aCoder.encodeObject(self.ratingImage, forKey: "ratingImage")
    }
}