//
//  ListPDFViewController.swift
//  EstudoCriptografia
//
//  Created by Fabio Miciano on 24/07/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ListPDFViewController: UIViewController {
    
    var tableView: UITableView {
        return self.view as! UITableView
    }
    
    let fileManager = FileManagerActions()
    let coreData = CoreDataActions()
    var dataSource = [Pdf]()
    
    init() {
        super.init(nibName: "ListView", bundle: Bundle.main)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Registro a celula
        self.tableView.register(UINib(nibName: "PDFViewCell", bundle: nil), forCellReuseIdentifier: "pdfCell")
        if let documents = coreData.getData() {
            dataSource = documents
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    //PRAGMA MARK: -- ACTIONS --
    func showPDFAction(path: String) {
        let controller = ShowPDFViewController(with: path)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//PRAGMA MARK: -- TABLEVIEW DATASOURCE --
extension ListPDFViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let name = dataSource[indexPath.row].name
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pdfCell") else { return UITableViewCell() }
        cell.textLabel?.text = name
        
        return cell
    }
}

//PRAGMA MARK: -- TABLEVIEW DELEGATE --
extension ListPDFViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showPDFAction(path: dataSource[indexPath.row].path!)
    }
}
