//
//  ViewController.swift
//  BitcointoCurrency
//
//  Created by Admin on 09/09/2018.
//  Copyright © 2018 abdulahad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var finalURL = ""
    let currencySymbolArray=["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var currentSymbol=""
    //no of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        getData(url: finalURL)
        currentSymbol=currencySymbolArray[row]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate=self
        currencyPicker.dataSource=self
        
    }
    //making network request
    func getData(url:String){
        Alamofire.request(url, method:.get).responseJSON{
            response in
            if response.result.isSuccess {
                let jsonresponse:JSON=JSON(response.result.value)
                self.parsejson(json: jsonresponse)
                
            }
            else{
                print("ERROR = \(response.result.error)")
                self.currencyLabel.text="connectivity issues"
            }
        }
        
        
        
    }
    
    func parsejson(json:JSON){
        if let bitValue = json["ask"].double{
        currencyLabel.text=currentSymbol + String(bitValue)
            
        }
        else{
            currencyLabel.text="price unavailable"
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

