//
//  Array+Only.swift
//  Memorize
//
//  Created by Jerry Lin on 29/5/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        return count == 1 ? first:nil;
    }
}
