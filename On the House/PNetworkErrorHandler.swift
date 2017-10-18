//
//  networkErrorHandler.swift
//  memHistoryRefined
//
//  Created by Santosh on 18/10/17.
//  Copyright © 2017 OTH. All rights reserved.
//

import Foundation

protocol PNetworkErrorHandler {
    func handleError(error: Int)
    var badURLstatusCode:Int { get }
}

extension PNetworkErrorHandler {
    var badURLstatusCode:Int { return 4 }
}
