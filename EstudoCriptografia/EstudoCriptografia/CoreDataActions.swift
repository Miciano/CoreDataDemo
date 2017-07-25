//
//  CoreDataActions.swift
//  EstudoCriptografia
//
//  Created by Fabio Miciano on 25/07/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class CoreDataActions {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func savePath(path: String, name:String) {
        let pdf = Pdf(context: appDelegate.persistentContainer.viewContext)
        pdf.path = path
        pdf.name = name
        appDelegate.saveContext()
    }
    
    func getData()-> [Pdf]?{
        do{
            guard let pdfs = try appDelegate.persistentContainer.viewContext.fetch(Pdf.fetchRequest()) as? [Pdf] else { return nil }
            return pdfs
        }
        catch {
            print("XX - Erro ao listar os pds \(error.localizedDescription)")
            return nil
        }
    }
}
