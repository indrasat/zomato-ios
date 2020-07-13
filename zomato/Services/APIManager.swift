//
//  APIManager.swift
//  zomato
//
//  Created by Indra on 13/07/20.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseAPI {
    
    var baseURL : String { get }
    func fetchCategories(completion: @escaping (Category) -> Void)
}

class APIManager: BaseAPI{
    static let shared = APIManager()
    var baseURL = "https://developers.zomato.com/api/v2.1"
    let headers: HTTPHeaders = [
           "user-key": "<your-api-key>",
           "Accept": "application/json"
       ]

    func fetchCategories(completion: @escaping (Category) -> Void){
        AF.request(baseURL+"/categories", headers: headers)
            .validate().responseJSON { (response) in
            do{
                let category = try JSONDecoder().decode(Category.self, from: response.data!)
                completion(category)
            }catch let error {
               debugPrint(error)
            }
        }
    }
    
    func searchRestaurantByCategory(categoryId: Int, completion: @escaping ([Restaurants]) -> Void){
        AF.request(baseURL+"/search?category=\(categoryId)", headers: headers)
            .validate().responseJSON { (response) in
            let result = try! JSONDecoder().decode(RestaurantResult.self, from: response.data!) as! RestaurantResult
                completion(result.restaurants)
        }
    }
}
