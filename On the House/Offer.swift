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
    var showandvenue : [ShowAndVenue]?
    
    
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
        
        
        if let showandvenue = data["show_data"] as? [[String : AnyObject]] {
            self.showandvenue = []
            for showdata in showandvenue {
                self.showandvenue?.append(ShowAndVenue(data: showdata))
            }
        }
        else{
            self.showandvenue = nil
        }
        
        
        
        
    }
    
    
    func getMembershipLevel() -> Int {
        
        var level = 0
        
        if self.membership_levels == "Gold & Bronze Member Event" {
            
            level = 3
        }
        else if self.membership_levels == "Gold Member Event" {
            
            level = 9
        }
        
        return level
        
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

class Venue {
    let id: String?
    let supplier_id: String?
    let name : String?
    let address1 : String?
    let address2 : String?
    let city : String?
    let zone_id : String?
    let zip : String?
    let country_id : String?
    let zone_name : String?
    let country_name : String?
    
    init(data : [String : Any]) {
        if let id = data["id"] as? String {
            self.id = id
        }
        else{
            self.id = ""
        }
        
        if let supplier_id = data["supplier_id"] as? String {
            self.supplier_id = supplier_id
        }
        else{
            self.supplier_id = ""
        }
        
        if let name = data["name"] as? String{
            self.name = name
        }
        else{
            self.name = ""
        }
        
        if let address1 = data["address1"] as? String{
            self.address1 = address1
        }
        else{
            self.address1 = ""
        }
        
        if let address2 = data["address2"] as? String{
            self.address2 = address2
        }
        else{
            self.address2 = ""
        }
        
        if let city = data["city"] as? String{
            self.city = city
        }
        else{
            self.city = ""
        }
        
        if let zone_id = data["zone_id"] as? String{
            self.zone_id = zone_id
        }
        else{
            self.zone_id = ""
        }
        
        if let zip = data["zip"] as? String{
            self.zip = zip
        }
        else{
            self.zip = ""
        }
        
        if let country_id = data["country_id"] as? String{
            self.country_id = country_id
        }
        else{
            self.country_id = ""
        }
        
        if let zone_name = data["zone_name"] as? String{
            self.zone_name = zone_name
        }
        else{
            self.zone_name = ""
        }
        
        if let country_name = data["country_name"] as? String{
            self.country_name = country_name
        }
        else{
            self.country_name = ""
        }
    }
}

class Show {
    let id : String?
    let event_id : String?
    let show_date : String?
    let show_date2 : String?
    let total_tickets : String?
    let venue_id : String?
    let pickup_venue_id : String?
    let tickets_reserved : String?
    let cutoff_date : String?
    let timezone_id : String?
    let price : String?
    let max_tickets_per_member : String?
    let is_admin_fee : Bool?
    let membership_level_id : String?
    let member_can_choose : Bool?
    let date_hide : Bool?
    let time_hide : Bool?
    let shipping : Bool?
    let shipping_price : String?
    let button_text : String?
    let sold_out : Bool?
    let date_formatted : String?
    let quantities : [Int]?
    
    init(data: [String : Any]) {
        if let id = data["id"] as? String{
            self.id = id
        }
        else{
            self.id = ""
        }
        
        if let event_id = data["event_id"] as? String{
            self.event_id = event_id
        }
        else{
            self.event_id = ""
        }
        
        if let show_date = data["show_date"] as? String{
            self.show_date = show_date
        }
        else{
            self.show_date = ""
        }
        
        if let show_date2 = data["show_date2"] as? String{
            self.show_date2 = show_date2
        }
        else{
            self.show_date2 = ""
        }
        
        if let total_tickets = data["total_tickets"] as? String{
            self.total_tickets = total_tickets
        }
        else{
            self.total_tickets = ""
        }
        
        if let venue_id = data["venue_id"] as? String{
            self.venue_id = venue_id
        }
        else{
            self.venue_id = ""
        }
        
        if let pickup_venue_id = data["pickup_venue_id"] as? String{
            self.pickup_venue_id = pickup_venue_id
        }
        else{
            self.pickup_venue_id = ""
        }
        
        if let tickets_reserved = data["tickets_reserved"] as? String{
            self.tickets_reserved = tickets_reserved
        }
        else{
            self.tickets_reserved = ""
        }
        
        if let cutoff_date = data["cutoff_date"] as? String{
            self.cutoff_date = cutoff_date
        }
        else{
            self.cutoff_date = ""
        }
        
        if let timezone_id = data["timezone_id"] as? String{
            self.timezone_id = timezone_id
        }
        else{
            self.timezone_id = ""
        }
        
        if let price = data["price"] as? String{
            self.price = price
        }
        else{
            self.price = ""
        }
        
        if let max_tickets_per_member = data["max_tickets_per_member"] as? String{
            self.max_tickets_per_member = max_tickets_per_member
        }
        else{
            self.max_tickets_per_member = ""
        }
        
        if let is_admin_fee = data["is_admin_fee"] as? String{
            self.is_admin_fee = String(is_admin_fee) == "1" ? true : false
        }
        else{
            self.is_admin_fee = false
        }
        
        if let membership_level_id = data["membership_level_id"] as? String{
            self.membership_level_id = membership_level_id
        }
        else{
            self.membership_level_id = ""
        }
        
        if let member_can_choose = data["member_can_choose"] as? String{
            self.member_can_choose = String(member_can_choose) == "1" ? true : false
        }
        else{
            self.member_can_choose = false
        }
        
        if let date_hide = data["date_hide"] as? String{
            self.date_hide = String(date_hide) == "1" ? true : false
        }
        else{
            self.date_hide = false
        }
        
        if let time_hide = data["time_hide"] as? String{
            self.time_hide = String(time_hide) == "1" ? true : false
        }
        else{
            self.time_hide = false
        }
        
        if let shipping = data["shipping"] as? String{
            self.shipping = String(shipping) == "1" ? true : false
        }
        else{
            self.shipping = false
        }
        
        if let shipping_price = data["shipping_price"] as? String{
            self.shipping_price = shipping_price
        }
        else{
            self.shipping_price = ""
        }
        
        if let button_text = data["button_text"] as? String{
            self.button_text = button_text
        }
        else{
            self.button_text = ""
        }
        
        if let date_formatted = data["date_formatted"] as? String{
            self.date_formatted = date_formatted
        }
        else{
            self.date_formatted = ""
        }
        
        if let sold_out = data["sold_out"] as? String{
            self.sold_out = String(sold_out) == "1" ? true : false
        }
        else{
            self.sold_out = false
        }
        
        if let quantities = data["quantities"] as? [Int] {
            self.quantities = quantities
        }
        else{
            self.quantities = []
        }
    }
}

class ShowAndVenue {
    var venue : Venue?
    var shows : [Show] = []
    
    init(data: [String : Any]) {
        self.venue = Venue(data: (data["venue"] as? [String : Any])!)
        let shows = data["shows"] as? [[String : Any]]
        for show in shows! {
            let currentshow = Show(data : show)
            self.shows.append(currentshow)
        }
    }
    
    init(){
    }
}

struct Offers {
    
    
    
    static var offerload : [Offer] = []
    
    static let initializer = ["venue" : "empty", "shows": []] as [String : Any]
    
    static var showandvenue = ShowAndVenue()
    
    
    static func getOffer(offerID : String) -> Offer{
        
        var currentOffer: Offer?
        
        for o in offerload {
            
            
            if o.id == offerID {
                
                currentOffer = o
                break
                
            }
            
            
        }
        return currentOffer!
    }
    
    
}

























