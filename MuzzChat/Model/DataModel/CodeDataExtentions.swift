//  CodeDataExtentions.swift
//  MuzzChat
//  Created by Анастасия Набатова on 17/4/24.

import Foundation
import CoreData

extension NSManagedObject {
    static func entityDescription(in context: NSManagedObjectContext) -> NSEntityDescription? {
        NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: context)
    }
}
