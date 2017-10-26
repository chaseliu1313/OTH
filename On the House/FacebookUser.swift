//
//  FacebookUser.swift
//  On the House
//
//  Created by bradlbs on 2017/10/26.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit
import CoreData

class FacebookUser: NSManagedObject {
    class func findorcreatuser(matching user : String, in context : NSManagedObjectContext) throws -> FacebookUser{
        let request: NSFetchRequest<FacebookUser> = FacebookUser.fetchRequest()
        request.predicate = NSPredicate(format: "email = %@", user)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "User.findorcreatmonth -- database inconsistency!")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let newuser : FacebookUser = FacebookUser(context: context)
        newuser.email = user
        return newuser
    }
    
    class func checkuser(matching useremail : String, in context : NSManagedObjectContext) -> Bool{
        let request: NSFetchRequest<FacebookUser> = FacebookUser.fetchRequest()
        request.predicate = NSPredicate(format: "email = %@", useremail)
        do {
            let matches = try context.fetch(request)
            if matches.count == 1{
                return true
            }
            else{
                return false
            }
        } catch {
            return false
        }
    }
    
}
