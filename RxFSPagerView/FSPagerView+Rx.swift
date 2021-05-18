//
//  FSPagerView+Rx.swift
//  FSPagerViewExample
//
//  Created by Chanchana Koedtho on 18/5/2564 BE.
//  Copyright © 2564 BE Wenchao Ding. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


extension Reactive where Base:FSPagerView{
    fileprivate var delegate: FSPagerViewDelegateProxy{
        return FSPagerViewDelegateProxy.proxy(for: base)
    }
    
    
    var didSelectItemAt:ControlEvent<(FSPagerView,Int)>{
        let source = delegate
            .methodInvoked(#selector(FSPagerViewDelegate.pagerView(_:didSelectItemAt:)))
            .map { a  in
                return (try castOrThrow(FSPagerView.self, a[0]), try castOrThrow(Int.self, a[1]))
            }
        
        return ControlEvent(events: source)
        
    }
    
    var pagerViewWillEndDragging:ControlEvent<Int>{
        let source = delegate
            .methodInvoked(#selector(FSPagerViewDelegate.pagerViewWillEndDragging(_:targetIndex:)))
            .map { a  in
                return try castOrThrow(Int.self, a[1])
            }
        
        return ControlEvent(events: source)
    }
    
    
    var pagerViewDidEndScrollAnimation:ControlEvent<FSPagerView>{
        let source = delegate
            .methodInvoked(#selector(FSPagerViewDelegate.pagerViewDidEndScrollAnimation(_:)))
            .map { a  in
                return try castOrThrow(FSPagerView.self, a[0])
            }
        
        return ControlEvent(events: source)
    }
    
    var pagerViewDidScroll:ControlEvent<FSPagerView>{
        let source = delegate
            .methodInvoked(#selector(FSPagerViewDelegate.pagerViewDidScroll(_:)))
            .map { a  in
                return try castOrThrow(FSPagerView.self, a[0])
            }
        
        return ControlEvent(events: source)
    }
}


extension Reactive where Base:FSPagerView{
    public var itemSize:Binder<CGSize>{
        Binder(base){fsPagerView, itemSize in
            fsPagerView.itemSize = itemSize
        }
    }
}




func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}
