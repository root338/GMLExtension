//
//  GMLAttributesKeyDefines.swift
//  MyDrawingBoard
//
//  Created by GML on 2020/5/30.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

#if os(iOS)
public typealias GMLFont = UIFont
public typealias GMLColor = UIColor
#elseif os(OSX)
public typealias GMLFont = NSFont
public typealias GMLColor = NSColor
#endif

typealias GMLAttributesSetFunc = (GMLAttributesKey, Any?) -> Void
typealias GMLAttributesGetFunc = () -> GMLAttributesSet
typealias GMLAttributesIdentifierFunc = () -> String?
typealias GMLAttributesContainer = (set: GMLAttributesSetFunc, get: GMLAttributesGetFunc, key: GMLAttributesIdentifierFunc)

//let GMLAttributesKeyPop: GMLAttributesKey = GMLAttributesKey(rawValue: "GMLAttributesKeyPop")

