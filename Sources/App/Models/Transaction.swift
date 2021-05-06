//
//  Transaction.swift
//  
//
//  Created by Łukasz Stachnik on 06/05/2021.
//

import Foundation


struct Transaction : Codable {
    
    let sender : String
    let recipient: String
    let amount : Int
    
}
