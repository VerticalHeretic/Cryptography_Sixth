//
//  File.swift
//  
//
//  Created by Łukasz Stachnik on 06/05/2021.
//

import Vapor
import Foundation

struct BlockchainController : RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let blockchainRoutes = routes.grouped("api")
        blockchainRoutes.get("mine", use: mineHandler)
        blockchainRoutes.post("transactions", "new" ,use: newTransactionHandler)
        blockchainRoutes.get("chain", use: getChainHandler)
    }
    
    // MARK: Handlers
    
    func mineHandler(_ req: Request) -> Block {
        let lastBlock = Blockchain.shared.lastBlock()
        let lastProof = lastBlock.proof
        let previousHash = lastBlock.hash()
        return Blockchain.shared.newBlock(proof: lastProof, previousHash: previousHash)
    }
    
    func newTransactionHandler(_ req: Request) throws -> Int {
        let transaction = try req.content.decode(Transaction.self)
        return Blockchain.shared.newTransaction(sender: transaction.sender, recipient: transaction.recipient, amount: transaction.amount)
    }
    
    func getChainHandler(_ req: Request) -> [Block] {
        return Blockchain.shared.chain
    }

    
}
