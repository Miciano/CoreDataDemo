//
//  ShowPDFViewController.swift
//  EstudoCriptografia
//
//  Created by Fabio Miciano on 20/07/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

class ShowPDFViewController: UIViewController {
    
    let name: String
    let fileManager = FileManagerActions()
    
    init(with name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
        //Carregando a view
        guard let view = Bundle.main.loadNibNamed("ShowView", owner: self, options: nil)?.last as? UIWebView else { return }
        //Carregando o path do arquivo em formato URLRequest
        guard let pathDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
        let url = URL(fileURLWithPath: "\(pathDirectory)/\(name)")
        let request = URLRequest(url: url)
        //Fazendo load do PDF em uma webView
        view.loadRequest(request)
        self.view = view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
