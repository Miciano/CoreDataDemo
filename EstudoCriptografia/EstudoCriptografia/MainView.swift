//
//  MainView.swift
//  EstudoCriptografia
//
//  Created by Fabio Miciano on 24/07/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

class MainView: UIView, Dismissable {
    
    //Implementação do enum usado no protocolo Dismissable
    public enum Action {
        case save
        case list
    }
    
    //Variavel usada no protocolo
    var dismissAction: (MainView.Action, UIView)-> Void = {_ in}
    
    //PRAGMA MARK: -- ACTIONS --
    @IBAction func saveAction(_ sender: UIButton) {
        callDismiss(.save)
    }
    
    @IBAction func listAction(_ sender: UIButton) {
        callDismiss(.list)
    }
}
