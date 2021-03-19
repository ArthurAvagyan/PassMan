//
//  UsersCoreDataManager.swift
//  PassMan
//
//  Created by Arthur Avagyan on 17.03.21.
//

import CoreData
import Foundation

class UsersCoreDataManager {
	
}

// MARK: - Create
extension UsersCoreDataManager {
	
	func add(model: UserModel) {
		let managedContext = CoreDataManager.shared.getManagedContext()
		
		let newUser = UserCoreModel(context: managedContext)
		newUser.initialize(from: model)
		CoreDataManager.shared.saveChanges(in: managedContext)
	}
}

// MARK: - Retrieve
extension UsersCoreDataManager {
	
	func getAllPasswords() -> [PasswordCoreModel]? {
		let managedContext = CoreDataManager.shared.getManagedContext()
		
		let fetchRequest = PasswordCoreModel.fetchRequest() as NSFetchRequest<PasswordCoreModel>
		
		do {
			return try managedContext.fetch(fetchRequest)
		} catch {
			print("Failed to fetch data")
			return nil
		}
	}
}

extension UsersCoreDataManager {
	
	func userExists(by email: String) -> Bool {
		let managedContext = CoreDataManager.shared.getManagedContext()
		
		let fetchRequest = UserCoreModel.fetchRequest() as NSFetchRequest<UserCoreModel>
		fetchRequest.fetchLimit = 1
		fetchRequest.predicate = NSPredicate(format: "email == %@", email as NSString)
		fetchRequest.includesSubentities = false
		
		var count = 0
		do {
			count = try managedContext.count(for: fetchRequest)
		} catch {
			print("Failed to fetch data")
		}
		
		return count == 1
	}
	
	func user(by email: String) -> UserCoreModel? {
		let managedContext = CoreDataManager.shared.getManagedContext()
		
		let fetchRequest = UserCoreModel.fetchRequest() as NSFetchRequest<UserCoreModel>
		fetchRequest.fetchLimit = 1
		fetchRequest.predicate = NSPredicate(format: "email == %@", email as NSString)
		
		do {
			return try managedContext.fetch(fetchRequest).first
		} catch {
			print("Failed to fetch data")
			return nil
		}
	}
}
