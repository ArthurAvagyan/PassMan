//
//  Observable.swift
//  aaber
//
//  Created by Arthur Avagyan on 11/6/20.
//  Copyright © 2020 Digitec. All rights reserved.
//

import Foundation

final class Observable<T> {

	typealias Listener = (T) -> Void
	var listener: Listener?
	
	var value: T {
		didSet {
			listener?(value)
		}
	}
	
	init(_ value: T) {
		self.value = value
	}
	
	func bindAndNotify(listener: Listener?) {
		self.listener = listener
		listener?(value)
	}
	
	func bind(listener: Listener?) {
		self.listener = listener
	}
}

// multiple listner version (review before using)

//final class Observable<T> {
//
//	typealias Handler = (T) -> Void
//	private var observers: [String: Handler] = [:]
//
//	var value: T {
//		didSet {
//			notify()
//		}
//	}
//
//	init(_ value: T) {
//		self.value = value
//	}
//
//	public func addObserver(_ observer: NSObject, _ completionHandler: @escaping Handler) {
//        observers[observer.description] = completionHandler
//    }
//
//    public func addAndNotify(_ observer: NSObject, _ completionHandler: @escaping Handler) {
//        self.addObserver(observer, completionHandler)
//        self.notify()
//    }
//
//	public func removeAll() {
//		observers.removeAll()
//	}
//
//	private func notify() {
//		observers.forEach({ $0.value(value) })
//    }
//
//    deinit {
//        observers.removeAll()
//    }
//}
