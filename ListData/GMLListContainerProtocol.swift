//
//  GMLListContainerProtocol.swift
//  MyDrawingBoard
//
//  Created by apple on 2020/6/3.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation
/**
 * 平面数据协议
 * 就是二维数据结构，包含组/列
 */
public protocol GMLFlatDataProtocol: NSObjectProtocol {
    associatedtype GMLFlatData
    func add(list: [GMLFlatData])
    func add(list: [GMLFlatData], section: Int)
    func remove(list: [GMLFlatData]) -> [GMLFlatData]?
    func insert(list: [GMLFlatData], row: Int, section: Int)
    
    func object(at index: Int) -> GMLFlatData?
    func object(at index: IndexPath) -> GMLFlatData?
    func contains(at obj: GMLFlatData) -> Bool
}

extension GMLFlatDataProtocol {
    func add(list: [GMLFlatData]) {
        add(list: list, section: 0)
    }
    
    func object(at index: Int) -> GMLFlatData? {
        return object(at: IndexPath(item: index, section: 0))
    }
}
