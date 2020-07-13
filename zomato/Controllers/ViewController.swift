//
//  ViewController.swift
//  zomato
//
//  Created by Indra on 13/07/20.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var categories = [CategoryElement]()
    private var selectedCategoryId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        fetchCategories()
        
    }
    
    private func fetchCategories(){
        APIManager.shared.fetchCategories { (category) in
            self.categories = category.categories
            self.tableView.reloadData()
        }
    }
    
    private func goToRestaurant(categoryId: Int){
        //Perform as Modal
        selectedCategoryId = categoryId
        performSegue(withIdentifier: "showDetail", sender: nil)
        
//        let viewController = storyboard?.instantiateViewController(identifier: "RestaurantViewController") as! RestaurantViewController
//        viewController.categoryId = categoryId
//        self.present(viewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let viewController = storyboard?.instantiateViewController(identifier: "RestaurantViewController") as! RestaurantViewController
        
        let viewController = segue.destination as! RestaurantViewController
        viewController.categoryId = categories[selectedCategoryId!].categories?.id
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].categories?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToRestaurant(categoryId: categories[indexPath.row].categories!.id)
        
    }
    
    
}



