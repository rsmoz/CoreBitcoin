//
//  Block.swift
//  CoreBitcoin
//
//  Created by Robert S Mozayeni on 1/19/16.
//  Copyright © 2016 Oleg Andreev. All rights reserved.
//

import Foundation

@objc
class Block: NSObject, NSCopying {
    
    
    let header: BTCBlockHeader
    var transactions: [BTCTransaction]? //Not sure when this is used/set
    
    var blockHash: NSData { return header.blockHash }
    
    var blockID: String { return header.blockID }
    
    var data: NSData { return computePayload() } // serialized form of the block
    
    // Height of the block. Default is 0. (Should it be nil, like with confirmations?)
    var height: Int {
        get { return self.header.height }
        set { self.header.height = newValue }
    }

    var userInfo: [NSObject:AnyObject] {
        get { return self.header.userInfo }
        set { self.header.userInfo = newValue }
    }
    
    var confirmations: UInt? { //Representing NSNotFound as nil
        get { return (self.header.confirmations == UInt(NSNotFound)) ? nil : self.header.confirmations }
        set { self.header.confirmations = newValue ?? UInt(NSNotFound) }
    }
    
    var computeMerkleRootHash: NSData? {
        
        //TODO
        return nil
    }
    
    init(header: BTCBlockHeader = BTCBlockHeader()) {
        self.header = header
    }
    
    /*
    init?(data: NSData?) {
        //TODO:
    }
    
    init?(stream: NSStream) {
        //TODO:
    }
    */
    
    func updateMerkleTree() { //Not sure how you'd want the Swifty version of this to look
        self.header.merkleRootHash = self.computeMerkleRootHash
    }
    
    func computePayload() -> NSData {
        let data = NSMutableData()
        
        data.appendData(self.header.data)
        
        //TODO: add transactions
        
        return data
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let b = Block(header: self.header.copy() as! BTCBlockHeader)
        b.transactions = NSArray(array: self.transactions ?? [], copyItems: true).map { $0 as! BTCTransaction } // so each element is copied individually
        return b
    }
    
}

