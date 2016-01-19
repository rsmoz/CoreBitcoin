//
//  BTCError.swift
//  CoreBitcoin
//
//  Created by Robert S Mozayeni on 1/19/16.
//  Copyright © 2016 Oleg Andreev. All rights reserved.
//

import Foundation

enum BTCError: UInt, ErrorType {
    // Canonical pubkey/signature check errors
    case NonCanonicalPublicKey            = 4001
    case NonCanonicalScriptSignature      = 4002
    
    // Script verification errors
    case ScriptError                      = 5001
    
    // BTCPriceSource errors
    case UnsupportedCurrencyCode          = 6001
    
    // BIP70 Payment Protocol errors
    case PaymentRequestInvalidResponse    = 7001
    case PaymentRequestTooBig             = 7002
    
    // Secret Sharing errors
    case IncompatibleSecret               = 10001
    case InsufficientShares               = 10002
    case MalformedShare                   = 10003
}

