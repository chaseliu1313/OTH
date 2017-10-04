//
//  RatingDetailViewController.swift
//  On the House
//
//  Created by Chase on 3/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class RatingDetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var Offerdescription: UITextView!
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var rating: UIImageView!
    @IBOutlet weak var comments: UITextView!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var rate1: UIButton!
    @IBOutlet weak var rate2: UIButton!
    @IBOutlet weak var rate3: UIButton!
    @IBOutlet weak var rate4: UIButton!
    @IBOutlet weak var rate5: UIButton!
    @IBOutlet weak var yourRating: UILabel!
    
    @IBOutlet weak var sumitButton: UIButton!
    
    
    let url = ""
    
    var command = "api/v1/event/"
    var parameter = ["event_id": "", "member_id": "", "rating": "", "comments": ""]
    let command2 = "api/v1/event/rate"
    
    
    
    var event_id = ""
    
    var Userrating = ""
    
    var type = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.Offerdescription.backgroundColor = UIColor.clear
        self.comments.backgroundColor = UIColor.clear
        self.hide()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadInfomation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func slider(_ sender: UISlider) {
        
        sender.value = roundf(sender.value)
        self.Userrating = String(roundf(sender.value))
        
    }
    
    func loadInfomation(){
        
        let command = self.command + event_id
        ConnectionHelper.getJSON(command: command) { (success, json) in
         
            if success {
                
                let offer = json["event"].dictionaryObject!
                
                let o: Offer = Offer.init(data: offer)
                o.insert()
                let url = o.image_url
                
                print(url)
                
                
                ConnectionHelper.getImage(imageURL: url, completion: { (success, img) in
                    
                    
                    if success {
                    
                    
                    self.offerImage.image = img
                        
                    }
                    
                    else{
                    print("download failed")
                    }
                    
                    
                    
                })
                
                self.Offerdescription.text = o.description
                let rating = String(o.rating)
                
                self.rating.image = UIImage(named: rating)
                
                self.name.text = o.name
                
            }
            
            else {
            
            
            }
            
            
        }
    
    
    
    
    }
    
    func hide(){
    
        
        self.rate1.isHidden = self.type
        self.rate2.isHidden = self.type
        self.rate3.isHidden = self.type
        self.rate4.isHidden = self.type
        self.rate5.isHidden = self.type
        self.slider.isHidden = self.type
        self.comments.isHidden = self.type
        self.commentsLabel.isHidden = self.type
        self.sumitButton.isHidden = self.type
        self.yourRating.isHidden = self.type
    
    }
  

    @IBAction func submit(_ sender: Any) {
        
        guard let member_id = UserDefaults.standard.string(forKey: "member_id")
            
            else {
        
        return
        
        }
        self.parameter.updateValue(event_id, forKey: "event_id")
        self.parameter.updateValue(member_id, forKey: "member_id")
        self.parameter.updateValue(Userrating, forKey: "rating")
        self.parameter.updateValue(comments.text, forKey: "comments")
        
        ConnectionHelper.postJSON(command: command2, parameter: parameter) { (success, json) in
            
            if success {
            
            self.notifyUser(["Thank you for your rating!"])
            }
            
            else {
            let error = json["error"]["messages"].arrayObject as! [String]
            self.notifyUser(error)
            }
        }
        
    }

    @IBAction func `return`(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func notifyUser( _ message: [String] ) -> Void
    {
        
        var meg = ""
        
        for error in message {
            
            meg.append("\n \(error)")
            
        }
        
        
        let alert = UIAlertController(title: "ON THE HOUSE", message: meg, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }
}
