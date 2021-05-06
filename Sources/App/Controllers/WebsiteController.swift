//
//  File.swift
//  
//
//  Created by Łukasz Stachnik on 06/05/2021.
//

import Foundation
import Vapor
import Leaf

struct WebsiteController : RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: indexHandler)
        routes.get("mine", use: mineHandler)
        routes.post("transactions", "new" ,use: newTransactionHandler)
        routes.get("chain", use: getChainHandler)
    }
    
    
    // MARK: Handlers
    
    func indexHandler(_ req: Request) -> EventLoopFuture<View> {
        let context = IndexContext(title: "Home page", description: "You are about to get into some caffeine infused cryptocurrency")
        return req.view.render("index", context)
    }
    
    func mineHandler(_ req: Request) -> EventLoopFuture<View> {
        let lastBlock = Blockchain.shared.lastBlock()
        let lastProof = lastBlock.proof
        let previousHash = lastBlock.hash()
        Blockchain.shared.newBlock(proof: lastProof, previousHash: previousHash)
        return req.view.render("mine")
    }
    
    func newTransactionHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let transaction = try req.content.decode(Transaction.self)
        Blockchain.shared.newTransaction(sender: transaction.sender, recipient: transaction.recipient, amount: transaction.amount)
        return req.view.render("transaction")
    }
    
    func getChainHandler(_ req: Request) -> EventLoopFuture<View> {
        let context = ChainContext(title: "Chain page", chain: Blockchain.shared.chain )
        return req.view.render("chain" ,context)
        
    }
    
}

struct IndexContext : Encodable {
    let title : String
    let description : String
}

struct ChainContext : Encodable {
    let title: String
    let chain : [Block]
}
