//
//  Offer.swift
//  On the House
//
//  Created by bradlbs on 2017/9/7.
//  Copyright © 2017年 Geng Xu. All rights reserved.
// 9.11 change: add let competition, rating changed from String to Int by Chase

import Foundation

class Offer{
    var id : String = ""
    var type : String = ""
    var name : String = ""
    var page_title = ""
    var rating = 0
    var image_url = ""
    var description = ""
    var price_from : Double = 0.0
    var price_to : Double = 0.0
    var full_price_string : String = ""
    var our_price_string : String = ""
    var our_price_heading : String = ""
    var membership_levels : String = ""
    var coming_soon : Bool = false
    var is_product: Bool = false
    var can_reserve : Bool = false
    var has_reservation : Bool = false
    var is_competition : Bool = false
    var competition: [String: String] = [:]
    
    var image = UIImage()
    
    init() {
        
    }
    
    init(data: [String: Any]) {
        
        if let id = data["id"] as? String {
            self.id = id
        }
        else{
            self.id = ""
        }
        if let type = data["type"] as? String {
            self.type = type
        }
        else{
            self.type = ""
        }
        if let name = data["name"] as? String {
            self.name = name
        }
        else{
            self.name = ""
        }
        if let page_title = data["page_title"] as? String {
            self.page_title = page_title
        }
        else{
            self.page_title = ""
        }
        if let rating = data["rating"] as? Int {
            self.rating = rating
        }
        else{
            self.rating = 0
        }
        if let image_url = data["image_url"] as? String {
            self.image_url = image_url
        }
        else{
            self.image_url = ""
        }
        if let description = data["description"] as? String{
            self.description = description
        }
        else{
            self.description = ""
        }
        if let price_from = data["price_from"] as? Double{
            self.price_from = price_from
        }
        else{
            self.price_from = 0.0
        }
        if let price_to = data ["price_to"] as? Double{
            self.price_to = price_to
        }
        else{
            self.price_to = 0.0
        }
        if let full_price_string = data["full_price_string"] as? String{
            self.full_price_string = full_price_string
        }
        else{
            self.full_price_string = ""
        }
        if let our_price_string = data["our_price_string"] as? String{
            self.our_price_string = our_price_string
        }
        else{
            self.our_price_string = ""
        }
        if let our_price_heading = data["our_price_heading"] as? String{
            self.our_price_heading = our_price_heading
        }
        else{
            self.our_price_heading = ""
        }
        if let membership_levels = data["membership_levels"] as? String{
            self.membership_levels = membership_levels
        }
        else{
            self.membership_levels = ""
        }
        if let coming_soon = data["coming_soon"] as? Bool{
            self.coming_soon = coming_soon
        }
        else{
            self.coming_soon = false
        }
        if let is_product = data["is_product"] as? Bool{
            self.is_product = is_product
        }
        else{
            self.is_product = false
        }
        if let can_reserve = data["can_reserve"] as? Bool{
            self.can_reserve = can_reserve
        }
        else{
            self.can_reserve = false
        }
        if let has_reservation = data["has_reservation"] as? Bool{
            self.has_reservation = has_reservation
        }
        else{
            self.has_reservation = false
        }
        if let is_competition = data["is_competition"] as? Bool{
            self.is_competition = is_competition
        }
        else{
            self.is_competition = false
        }
        
        if let competition = data["competition"] as? [String : String]{
            
            self.competition = competition
            
        }
        else{
            self.competition = [:]
        }
        
        
        
    }
    
    func getImage() -> UIImage {
        
        
        
        if self.image_url != "" {
            
            ConnectionHelper.getImage(imageURL: "\(self.image_url)") { (success, img) in
                
                if success {
                    
                 
                   
                    self.image = img
                    
                }
                
                
                
            }}
        else{self.image = #imageLiteral(resourceName: "OTH-logo-lightbkgd-hires")}
        
    return self.image
    }
    
    func insert() {
        
        if self.image_url != ""{
    
        let range = self.image_url.range(of: "http")
            
        self.image_url.insert("s", at: range!.upperBound)
        }
    else {
    
      self.image = #imageLiteral(resourceName: "OTH-logo-lightbkgd-hires")
        }}
}


