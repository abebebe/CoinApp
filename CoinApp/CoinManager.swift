//
//  CoinManager.swift
//  CoinApp
//
//  Created by 阿部拓磨 on 2020/09/13.
//  Copyright © 2020 abetkma.com. All rights reserved.
//

import Foundation

protocol CoinManegerDelegate {
    func didUpdatePrice(price: String, virtualCurrency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "84A7CE93-A68B-4412-9E14-A9695F180594"
    
    let currencyArray = ["USD","CNY","EUR","JPY","HKD"]
    let virtualCurrencyArray = ["BTC","BCH","ETH","XRP","XEM"]
    
//    プロトコル にアクセスするため
    var delegate:CoinManegerDelegate?
    
    func getCoinPrice(for currency:String){
        print(currency,"これこれ")
        
        let urlString = "\(baseURL)/\(currency)/JPY?apikey=\(apiKey)"
        
        print(urlString)
        
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){ (data,responce,error)in
                
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let bitcoinPrice = self.parseJSON(safeData){
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        self.delegate?.didUpdatePrice(price: priceString, virtualCurrency: currency)
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        
//        JSONの解析用に定義
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode(CoinData.self, from: data)
            
            let lastPrice = decodeData.rate
            
            print(lastPrice)
            return lastPrice
            
        } catch {
            
            delegate?.didFailWithError(error: error)
            return nil
            
        }
    }
}
