//
//  Dismissable.swift
//  EstudoCriptografia
//
//  Created by Fabio Miciano on 24/07/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

/*
 ====================================================================
    PROTOCOLO USADO PARA CONTROLE DE ACAO DE FILHOS PARA PAI
 ====================================================================
*/

protocol Dismissable {
    
    associatedtype DismissableAction
    associatedtype DismissableObject
    var dismissAction: ((DismissableAction, DismissableObject)->Void) { get set }
}

extension Dismissable where Self:UIView, DismissableObject == UIView {
    
    func callDismiss(_ action: DismissableAction) {
        self.dismissAction(action, self)
    }
}

