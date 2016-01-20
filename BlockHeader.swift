//
//  BlockHeader.swift
//  CoreBitcoin
//
//  Created by Robert S Mozayeni on 1/19/16.
//  Copyright © 2016 Oleg Andreev. All rights reserved.
//

import Foundation

@objc
class BlockHeader: NSObject, NSCopying {
    
    static let BlockCurrentVersion: Int32 = 2
    static let headerLength: UInt = 4 + 32 + 32 + 4 + 4 + 4
    
    var version: Int32 = 0
    var previousBlockHash: NSData
    
    var previousBlockID: String {
        get { return BTCIDFromHash(self.previousBlockHash) }
        set { self.previousBlockHash = BTCHashFromID(newValue) ?? BTCZero256() }
    }
    
    var merkleRootHash: NSData
    var time: UInt32
    var difficultyTarget: UInt32
    var nonce: UInt32
    
    var blockHash: NSData {
        get { return BTCHash256(self.data) }
    }
    
    var blockID: String {
        get { return BTCIDFromHash(self.blockHash) }
    }
    
    var data: NSData {
        let data = NSMutableData()
        
        var version = self.version.littleEndian
        data.appendBytes(&version, length: sizeofValue(version))
        
        data.appendData(self.previousBlockHash ?? BTCZero256())
        data.appendData(self.merkleRootHash ?? BTCZero256())
        
        var time = self.time.littleEndian
        data.appendBytes(&time, length: sizeofValue(time))
        
        var target = self.difficultyTarget.littleEndian
        data.appendBytes(&target, length: sizeofValue(target))
        
        var nonce = self.nonce.littleEndian
        data.appendBytes(&nonce, length: sizeofValue(nonce))
        
        return data
    }
    
    var date: NSDate {
        get { return NSDate(timeIntervalSince1970: NSTimeInterval(self.time)) }
        set { time = UInt32(round(newValue.timeIntervalSince1970)) }
    }
    
    var height: Int?
    var confirmations: UInt?
    var userInfo: [NSObject:AnyObject]?
    
    
    override init() {
        version = BlockHeader.BlockCurrentVersion
        previousBlockHash = BTCZero256()
        merkleRootHash = BTCZero256()
        time = 0
        difficultyTarget = 0
        nonce = 0
        confirmations = nil
        
        super.init()
    }
    
    /*
    init?(data: NSData?) {
    //TODO:
    }
    
    init?(stream: NSStream) {
    //TODO:
    }
    */
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let bh = BlockHeader()
        bh.version = self.version
        bh.previousBlockHash = self.previousBlockHash.copy() as! NSData
        bh.merkleRootHash = self.merkleRootHash.copy() as! NSData
        bh.time = self.time
        bh.difficultyTarget = self.difficultyTarget
        bh.nonce = self.nonce
        
        bh.height = self.height
        bh.confirmations = self.confirmations
        bh.userInfo = self.userInfo
        
        return bh
    }
    
}

