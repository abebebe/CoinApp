//
//  ViewController.swift
//  CoinApp
//
//  Created by 阿部拓磨 on 2020/09/13.
//  Copyright © 2020 abetkma.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,CoinManegerDelegate {
    
    
    func didUpdatePrice(price: String, virtualCurrency : String) {
        
        DispatchQueue.main.async {
            self.coinLabel.text = price
            self.virtualCurrencyLabel.text = virtualCurrency
            
        
        }
    }
    
    func didFailWithError(error: Error) {
        print("error")
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
//    構造体CoinManagerにアクセス
    var coinManager = CoinManager()
    
//    ピッカービューのセルの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
//        構造体の中のcurrencyArrayのカウント分
        return coinManager.virtualCurrencyArray.count
        
    }
    
//    セルに表示するラベル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return coinManager.virtualCurrencyArray[row]
        
    }
    
//    選択されたピッカーの値を取得（何をユーザーが選んでいるのか分かるところ）
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
//        取得の確認
        print(row,coinManager.virtualCurrencyArray[row])
        
//        入れて
        let selectedCurrency = coinManager.virtualCurrencyArray[row]
        
//        コインマネージャーに送る
        coinManager.getCoinPrice(for: selectedCurrency)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.delegate = self
        currencyLabel.text = "円"
        
    }
    
    @IBOutlet var coinLabel: UILabel!
    
    @IBOutlet var currencyLabel: UILabel!
    
    @IBOutlet var virtualCurrencyLabel: UILabel!
    
    @IBOutlet var currencyPicker: UIPickerView!
    


}

