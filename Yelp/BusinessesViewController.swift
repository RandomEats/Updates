//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var businesses: [Business]!
    var filteredData: [Business]!
    var data = [String]()
    
    var isMoreDataLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        searchBar.delegate = self
        

        
        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredData = businesses
            self.tableView.reloadData()
        
            for business in businesses {
                print(business.name!)
                print(business.address!)
                //adds the name of each resturant in string array
                self.data.append(business.name!)
            }
        
        })

/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if filteredData != nil {
                return filteredData!.count
            }
            else {
                return 0;
            }
        }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BuisnessCell", forIndexPath: indexPath) as! BuisnessCell
        
        cell.business = filteredData[indexPath.row]
        return cell
    }
    
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredData = searchText.isEmpty ? data: data.filter({(dataString: String) -> Bool in return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//        })
//    }
//    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            filteredData = businesses
        }
        else{
            //temp stores matched titles from data
            let temp = data.filter({(dataItem: String) -> Bool in
                if (dataItem.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil) {
                    return true
                }
                else {
                    return false
                }
            })
            filteredData.removeAll()
            //checks if title from temp is in one of the list
            for business in businesses{
                if temp.contains(business.name!) {
                    filteredData.append(business)
                }
            }
            
        }
        //reloads table once all matches are found
        tableView.reloadData()
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
