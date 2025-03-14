//
//  ViewController.swift
//  CryptoLab
//
//  Created by Denis on 12.03.2025.
//

import UIKit

class ViewController: UIViewController {
    private let service = NetworkingService.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        Task {
            do {
                let a = try await service.getTokens(tokenNames: ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"])
                print(a)
            } catch  {
                print(error)
            }
            
        }
        
        // Do any additional setup after loading the view.
    }


}

