//
//  File.swift
//  
//
//  Created by Łukasz Stachnik on 06/05/2021.
//

import Foundation


class Blockchain {
    
    private var currentTransactions: [Transaction] = []
    
    var chain : [Block] = []
    
    static let shared = Blockchain()
    
    init() {
        newBlock(proof: 100, previousHash: "1".data(using: .utf8))
    }
    
    /**
     Create a new Block in the Blockchain
     - Parameter proof : The proof given by the Proof of Work algorithm
     - Parameter previousHash : Hash of previous Block
     - Returns : New Block
     */
    func newBlock(proof: Int, previousHash: Data? = nil) -> Block {
        let prevHash : Data
        
        if let previousHash = previousHash {
            prevHash = previousHash
        } else {
            prevHash = lastBlock().hash()
        }
        
        let block = Block(index: chain.count + 1, timestamp: Date().timeIntervalSince1970, transaction: currentTransactions, proof: proof, previousHash: prevHash)
        
        currentTransactions = []
        
        chain.append(block)
        
        return block
    }
    
    /**
     Creates a new transaction to go into the next mined Block
     - Parameter sender: Address of the Sender
     - Parameter recipient : Address of the Recipient
     - Parameter amount : Amount for the transaction
     - Returns:The index of the Block that will hold this transaction
     */
    func newTransaction(sender : String, recipient: String, amount : Int) -> Int {
        self.currentTransactions.append(Transaction(sender: sender, recipient: recipient, amount: amount))
        return lastBlock().index + 1
    }
    
    func lastBlock() -> Block {
        guard let last = chain.last else {
            fatalError("The chain should have at least one block as a genesis.")
        }
        return last
    }
    
    
    /** Simple Proof of Work Algorithm: Find a number p' such that hash(pp') contains leading 4 zeroes, where p is the previous p' , p is the previous proof, and p' is the new proof
     */
    class func proofOfWork(lastProof: Int) -> Int {
        var proof: Int = 0
        while !validProof(lastProof: lastProof, proof: proof) {
            proof += 1
        }
        return proof
    }
    
    /**Validates the Proof: Does hash(last_proof, proof) contain 4 leading zeroes?
     */
    class func validProof(lastProof: Int, proof: Int) -> Bool {
        guard let guess = String("\(lastProof)\(proof)").data(using: .utf8) else {
            fatalError()
        }
        let guess_hash = guess.sha256().hexDigest()
        return guess_hash.prefix(4) == "0000"
    }
}
