//
//  ViewController.swift
//  EstudoCriptografia
//
//  Created by Fabio Miciano on 19/07/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    var mainView: MainView {
        return self.view as! MainView
    }
    
    //Load da view
    override func loadView() {
        guard let view = Bundle.main.loadNibNamed("MainView", owner: self, options: nil)?.last as? MainView else { return }
       
        self.view = view
    }
    
    init() {
        super.init(nibName: "MainView", bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Implementação do protocolo descrito na view
        mainView.dismissAction = {(action, currentView) in
            switch action {
            case .save:
                self.savePDFAction()
            case .list:
                self.listPDFAction()
            }
        }
    }
    
    //PRAGMA MARK: -- ACTIONS --
    func savePDFAction() {
        let controller = SavePDFViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func listPDFAction() {
        let controller = ListPDFViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

