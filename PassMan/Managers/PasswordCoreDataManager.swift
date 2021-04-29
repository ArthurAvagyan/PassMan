//
//  PasswordCoreDataManager.swift
//  PassMan
//
//  Created by Arthur Avagyan on 05.03.21.
//

import CoreData
import Foundation

class PasswordCoreDataManager { }

// MARK: - Create
extension PasswordCoreDataManager {
	
	func add(model: PasswordModel, email: String) {
		let managedContext = CoreDataManager.shared.getManagedContext()
		
		let newMessage = PasswordCoreModel(context: managedContext)
		newMessage.initialize(from: model, email: email)
		CoreDataManager.shared.saveChanges(in: managedContext)
	}
}

// MARK: - Delete
extension PasswordCoreDataManager {
	
	func delete(at index: Int, for user: UserModel) {
		let managedContext = CoreDataManager.shared.getManagedContext()
		
		let models = getAllPasswords(for: user)
		managedContext.delete(models![index])
		
		CoreDataManager.shared.saveChanges(in: managedContext)
	}
}

// MARK: - Retrieve
extension PasswordCoreDataManager {
	
	func getAllPasswords(for user: UserModel) -> [PasswordCoreModel]? {
		let managedContext = CoreDataManager.shared.getManagedContext()
		
		let fetchRequest = PasswordCoreModel.fetchRequest() as NSFetchRequest<PasswordCoreModel>
		fetchRequest.predicate = NSPredicate(format: "userEmail == %@", user.email as NSString)
		do {
			return try managedContext.fetch(fetchRequest)
		} catch {
			print("Failed to fetch data")
			return nil
		}
	}
}
