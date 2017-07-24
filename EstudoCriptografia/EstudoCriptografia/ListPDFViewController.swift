//
//  ListPDFViewController.swift
//  EstudoCriptografia
//
//  Created by Fabio Miciano on 24/07/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

class ListPDFViewController: UIViewController {
    
    var tableView: UITableView?
    let fileManager = FileManagerActions()
    var dataSource = [String]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        //Load da UITableView por XIB
        guard let view = Bundle.main.loadNibNamed("ListView", owner: self, options: nil)?.last as? UITableView else { return }
        self.tableView = view
        self.view = view
        
        //Registro a celula
        self.tableView?.register(UINib(nibName: "PDFViewCell", bundle: nil), forCellReuseIdentifier: "pdfCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Caso eu consiga um listagem eu atribuo o delegate e o dataSource
        if let documents = fileManager.listFiles(with: nil) {
            dataSource = documents
            tableView?.dataSource = self
            tableView?.delegate = self
        }
    }
    
    //PRAGMA MARK: -- ACTIONS --
    func showPDFAction(name: String) {
        let controller = ShowPDFViewController(with: name)
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
        
        let name = dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pdfCell") else { return UITableViewCell() }
        cell.textLabel?.text = name
        
        return cell
    }
}

//PRAGMA MARK: -- TABLEVIEW DELEGATE --
extension ListPDFViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showPDFAction(name: dataSource[indexPath.row])
    }
}
