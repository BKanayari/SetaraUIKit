//
//  CoreDataManager.swift
//  Setara
//
//  Created by Irvan P. Saragi on 04/04/24.
//

import CoreData

struct CoreDataManager {
  static let shared  = CoreDataManager()
  
  let persistantContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "DataModel")
    container.loadPersistentStores { storeDescription, error in
      if let error = error{
        fatalError("Error cuy \(error)")
      }
    }
    return container
  }()
  
  func addItem(itemName : String, itemPrice: Double, quantity: Int, tax: Int, fee : Int, discount: Int)-> Item?{
    let contex = persistantContainer.viewContext
    let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: contex) as! Item
    item.nameItem = itemName
    item.priceItem = itemPrice
    item.quantitty = Int32(quantity)
    item.tax = Int32(tax)
    item.fee = Int32(fee)
    item.discount = Int32(discount)
    
    do {
      try contex.save()
      return item
    } catch let crateError{
      print("Error Bos \(crateError)")
    }
    return nil
  }
  
  func fetchItem()-> [Item]?{
    let contex = persistantContainer.viewContext
    let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
    
    
    do {
      let item = try contex.fetch(fetchRequest)
      return item
    } catch let crateError{
      print("Error Bos \(crateError)")
    }
    return []
  }
  
//  @discardableResult
  func createParticipant(name : String)-> Participants?{
    let contex = persistantContainer.viewContext
    let participant = NSEntityDescription.insertNewObject(forEntityName: "Participants", into: contex) as! Participants
    
    participant.name = name
    
    do {
      try contex.save()
      return participant
    } catch let crateError{
      print("Error Bos \(crateError)")
    }
    return nil
  }
  
  func fetchParticipants()-> [Participants]?{
    let contex = persistantContainer.viewContext
    let fetchRequest = NSFetchRequest<Participants>(entityName: "Participants")
    
    
    do {
      let participant = try contex.fetch(fetchRequest)
      return participant
    } catch let crateError{
      print("Error Bos \(crateError)")
    }
    return nil
  }
  
  func fetchParticipant(withName name : String)-> Participants?{
    let contex = persistantContainer.viewContext
    let fetchRequest = NSFetchRequest<Participants>(entityName: "Participants")
    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "name == %@", name)
    
    do {
      let participant = try contex.fetch(fetchRequest)
      return participant.first
    } catch let crateError{
      print("Error Bos \(crateError)")
    }
    return nil
  }
  
  func updateParticipant(participant: Participants){
    
    let contex = persistantContainer.viewContext
    
    do {
      try contex.save()
    } catch let crateError{
      print("Error Bos \(crateError)")
    }
  }
  
  func deleteParticipant(participant: Participants){
      let context = persistantContainer.viewContext
      // Ensure that the participant belongs to the view context
      if let existingParticipant = context.object(with: participant.objectID) as? Participants {
          context.delete(existingParticipant)
          do {
              try context.save()
          } catch let error {
              print("Error Bos: \(error)")
          }
      } else {
          print("Participant does not belong to the current context.")
      }
  }
}
