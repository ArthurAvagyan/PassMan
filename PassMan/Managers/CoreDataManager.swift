//
//  CoreDataManager.swift
//  PassMan
//
//  Created by Arthur Avagyan on 05.03.21.
//

import CoreData
import Foundation
import UIKit.UIApplication

class CoreDataManager {
	
	static let shared = CoreDataManager()
	
	private init() {}
}

// MARK: - Base
extension CoreDataManager {
	
	func getManagedContext() -> NSManagedObjectContext {
		// swiftlint:disable:next force_cast
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		return appDelegate.persistentContainer.viewContext
	}
	
	func resetManagedContext() {
		getManagedContext().reset()
	}
	
	func saveChanges(in viewContext: NSManagedObjectContext) {
		do {
			try viewContext.save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
}
