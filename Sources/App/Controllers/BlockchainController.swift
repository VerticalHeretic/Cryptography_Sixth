//
//  File.swift
//  
//
//  Created by Łukasz Stachnik on 06/05/2021.
//

import Vapor
import Foundation

struct BlockchainController : RouteCollection {
    
    let blockchain = Blockchain()
    
    func boot(routes: RoutesBuilder) throws {
        let blockchainRoutes = routes.grouped("api")
        blockchainRoutes.get("mine", use: mineHandler)
        blockchainRoutes.post("transactions", "new" ,use: newTransactionHandler)
        blockchainRoutes.get("chain", use: getChainHandler)
    }
    
    // MARK: Handlers
    
    func mineHandler(_ req: Request) -> String {
        return "We'll mine a new Block"
    }
    
    func newTransactionHandler(_ req: Request) throws -> Int {
        let transaction = try req.content.decode(Transaction.self)
        return blockchain.newTransaction(sender: transaction.sender, recipient: transaction.recipient, amount: transaction.amount)
    }
    
    func getChainHandler(_ req: Request) -> [Block] {
        return blockchain.chain
    }

    
}
