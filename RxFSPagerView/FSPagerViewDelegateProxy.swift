//
//  FSPagerViewDelegateProxy.swift
//  FSPagerViewExample
//
//  Created by Chanchana Koedtho on 18/5/2564 BE.
//  Copyright © 2564 BE Wenchao Ding. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension FSPagerView: HasDelegate {
    public typealias Delegate = FSPagerViewDelegate
}

class FSPagerViewDelegateProxy: DelegateProxy<FSPagerView, FSPagerViewDelegate>,
                                  DelegateProxyType,
                                  FSPagerViewDelegate{
    
    
    /// Typed parent object.
    public weak private(set) var fsPagerView: FSPagerView?
    
    
    required init(fsPagerView:ParentObject) {
        self.fsPagerView = fsPagerView
        self.fsPagerView?.delegate = nil
        super.init(parentObject: fsPagerView, delegateProxy: FSPagerViewDelegateProxy.self)
    }
    
    
    static func registerKnownImplementations() {
        self.register{FSPagerViewDelegateProxy(fsPagerView: $0)}
    }
    
    
    static func currentDelegate(for object: FSPagerView) -> FSPagerViewDelegate? {
        object.delegate
    }
    
    
    static func setCurrentDelegate(_ delegate: FSPagerViewDelegate?, to object: FSPagerView) {
        object.delegate = delegate
    }
    
   
}

