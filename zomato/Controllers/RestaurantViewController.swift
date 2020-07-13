//
//  RestaurantViewController.swift
//  zomato
//
//  Created by Indra on 13/07/20.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var restaurants = [Restaurants]()
    var categoryId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        if let categoryId = categoryId {
            searchRestaurantByID(categoryId: categoryId)
        }
    }
    
    private func searchRestaurantByID(categoryId: Int){
        APIManager.shared.searchRestaurantByCategory(categoryId: categoryId) { (restaurants) in
            self.restaurants = restaurants
            self.tableView.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RestaurantViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        let restaurant = restaurants[indexPath.row]
        cell.textLabel?.text = restaurant.restaurant.name
        return cell
    }
    
    
}
