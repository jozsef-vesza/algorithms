//
//  Helpers.swift
//  SwiftInterviews
//
//  Created by József Vesza on 12/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

import Foundation

public class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

public enum ResultType<T> {
    case Success(Box<T>)
    case Error(String)
}

public enum TraverseType {
    case Preorder, Inorder, Postorder
}

public enum ReplaceStrategy {
    case LeftTree, RightTree
}

public enum ComparisonOrder {
    case Ascending, Equal, Descending
}

public enum NodeChildrenStatus {
    case NoChildren, OneChild, TwoChildren
}