//
//  Survey.swift
//  On the House
//
//  Created by Geng Xu on 2017/9/26.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

let surveyNotificationKey = "key.survey"

class Survey: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var pickView: UIPickerView!
    
    @IBOutlet weak var surveryAnswerLab: UILabel!
    
    @IBOutlet weak var surveyAnswertextfield: UITextField!
    
    
    var qty = ""
    var member_id = ""
    var show_id = ""
    var data: [String: String] = [:]
    let key = Notification.Name(rawValue: competitionNotificationKey)
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    var Array = ["If google search, what did you search for?","Friend","If newsettle, please type the name of it below:","Twitter","Facebook","LinkedIn","Forum","If Blog, what blog was it?","Footy Funatics","Toorak Times","Only Melbourne Website","Yelp","Good Weekend website"]
    var questionid = String()
    var placementAnswer = 0
    var answer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterView.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        pickView.delegate = self
        pickView.dataSource = self
        surveryAnswerLab.isHidden = true
        surveyAnswertextfield.isHidden = false
        
        if(surveyAnswertextfield.text != "")
        {
            answer = surveyAnswertextfield.text!
        }
        else
        {
            
            answer = "null"
            
        }


        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return Array.count
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return Array[row]
    }
    
    
    @IBAction func submit(_ sender: Any) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placementAnswer = row
        questionid = System.getQuestion(question: Array[placementAnswer])
         if pickView==pickerView{
        if(placementAnswer == 0)
        {
            surveryAnswerLab.isHidden = false
            surveyAnswertextfield.isHidden = false
        }
        else if(placementAnswer == 2)
        {
           surveryAnswerLab.isHidden = false
            surveyAnswertextfield.isHidden = false
        }
        else if(placementAnswer == 7)
        {
            surveryAnswerLab.isHidden = false
            surveyAnswertextfield.isHidden = false
        }
        else
        {
            surveryAnswerLab.isHidden = true
            surveyAnswertextfield.isHidden = true
        }
        }
    }

    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func updateValue(notification: NSNotification) {
        
        guard let memberID = notification.userInfo?["member_id"] as? String
            , let eventID = notification.userInfo?["event_id"] as? String
            , let qty = notification.userInfo?["qty"] as? String
            , let showID = notification.userInfo?["show_id"] as? String
            else
        {
            return
        }
        
//        self.member_id = memberID
//        self.event_id = eventID
//        print(self.member_id)
//        print(self.event_id)
        print(qty)
        print(showID)
    }
    
    func createObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateValue(notification:)), name: key, object: nil)
        
    }

}
