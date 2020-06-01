//
//  GMLRichTextBuilder.swift
//  MyDrawingBoard
//
//  Created by GML on 2020/5/30.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

/// 富文本构建器
public class GMLRichTextBuilder: NSObject {
    
    var defaultAttributes: GMLAttributesSet?
    private lazy var attributedStringStack = [NSMutableAttributedString]()
}

public extension GMLRichTextBuilder {
    /// 压入一个新的富文本
    func push(_ text: String, attributes: GMLAttributesSet? = nil) -> Self {
        attributedStringStack.append(NSMutableAttributedString(string: text, attributes: append(attributes)))
        return self
    }
    /// 弹出最后一个富文本
    func pop() -> NSMutableAttributedString? {
        return attributedStringStack.popLast()
    }
    func last() -> NSMutableAttributedString? {
        return attributedStringStack.last
    }
}

public extension GMLRichTextBuilder {
    /// 对当前富文本追加新的富文本
    func append(_ text: String?, attributes: GMLAttributesSet? = nil) -> Self {
        guard let string = text else {
            return self
        }
        currentAttributedString().append(.init(string: string, attributes: append(attributes)))
        return self
    }
    /// 对当前富文本添加属性
    func add(attributes: GMLAttributesSet) -> Self {
        return add(attributes: attributes, range: NSRange(location: 0, length: currentAttributedString().length))
    }
    /// 对当前富文本
    func add(attributes: GMLAttributesSet, range: NSRange) -> Self {
        currentAttributedString().addAttributes(attributes, range: range)
        return self
    }
    
    func appendSpace(_ count: UInt, attributes: GMLAttributesSet? = nil) -> Self {
        
    }
}

//MARK:-
public extension GMLRichTextBuilder {
    
    func attributes(range: NSRange) -> GMLAttributesSet {
        
    }
}

extension GMLRichTextBuilder {
    func currentAttributedString() -> NSMutableAttributedString {
        if attributedStringStack.count == 0 {
            attributedStringStack.append(NSMutableAttributedString())
        }
        return attributedStringStack.last!
    }
}

private extension GMLRichTextBuilder {
    func append(_ attributes: GMLAttributesSet?) -> GMLAttributesSet? {
        if let a = attributes, let defaultA = defaultAttributes {
            return defaultA.ml_splice(dict: a)
        }
        return attributes != nil ? attributes : defaultAttributes
    }
}
