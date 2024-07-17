//
//  CoreData.swift
//  Core Data
//
//  Created by R95 on 24/06/24.
//

import UIKit
import CoreData

struct Details {
    var id: Int
    var name: String
}

var array = [Details]()

class CoreDataManager {
    var context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
    
    func addData(id: Int, name: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Data", in: context!)
        let newData = NSManagedObject(entity: entity!, insertInto: context)
        print("Add data Save")
        newData.setValue(id, forKey: "id")
        newData.setValue(name, forKey: "name")
        
        saveData()
    }
    
    private func saveData() {
        do {
            try context?.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fechData() {
        do {
//            try array = getData()
            saveData()
        }
        catch {
            NSLog("Error \(error.localizedDescription)")
        }
    }
    
    func getData() -> Details {
        do {
            if let result = try context?.fetch(fetchData) as? [NSManagedObject] {
                for data in result {
                    let id = data.value(forKey: "id") as? Int ?? 0
                    let name = data.value(forKey: "name") as? String ?? ""
                    let details = Details(id: id, name: name)
                    array.append(details)
                    print("Get Data save")
                    return details
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return Details(id: 0000, name: "nil")
    }
    
    func updateData(id: Int, newName: String) {
        fetchData.predicate = NSPredicate(format: "id = %d", id)
        do {
            if let result = try context?.fetch(fetchData) as? [NSManagedObject], let objectToUpdate = result.first {
                objectToUpdate.setValue(newName, forKey: "name")
                saveData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(id: Int) {
        fetchData.predicate = NSPredicate(format: "id = %d", id)
        
        do {
            if let result = try context?.fetch(fetchData) as? [NSManagedObject], let objectToDelete = result.first {
                context?.delete(objectToDelete)
                saveData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
