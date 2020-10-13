//
//  MJExample.swift
//  MJRefreshDemo
//
//  Created by fcn on 2020/10/13.
//

import Foundation

class MJExample: NSObject {
    var header: String?
    var title: String?
    var item: [MJExample]?
    var vcClass: AnyClass?

    
    init(_ t_title: String?, _ t_vcClass: AnyClass?) {
        super.init()
        title = t_title
        vcClass = t_vcClass
    }
}
