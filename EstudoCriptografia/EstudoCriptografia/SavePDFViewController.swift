//
//  SavePDFViewController.swift
//  EstudoCriptografia
//
//  Created by Fabio Miciano on 20/07/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

class SavePDFViewController: UIViewController {
    
    let fileManager = FileManagerActions()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        //Load da view por XIB
        guard let view = Bundle.main.loadNibNamed("SaveView", owner: self, options: nil)?.last as? SaveView else { return }
        self.view = view
        
        //Faço a contagem de elemenots salvos
        guard let count = fileManager.countFiles(with: nil) else { return }
        //Pego o path do arquivo local
        guard let pathFile = Bundle.main.path(forResource: "teste", ofType: ".pdf") else { return }
        //Marco para retirar esse arquivo na listagem de backup do iCloud ou iTunes
        var resourceValues = URLResourceValues()
        resourceValues.isExcludedFromBackup = true
        //Gero a url do path do arquivo
        var urlFile = URL(fileURLWithPath: pathFile)
        do { try urlFile.setResourceValues(resourceValues) }
        catch { print("Erro ao retirar marcação de backup do iCloud ou iTunes") }
        
        do {
            //Gero um Data baseado no caminho do arquivo
            let fileData = try Data(contentsOf: urlFile)
            //Salvo o arquivo
            let _ = fileManager.saveFile(with: "teste\(count).pdf", file: fileData)
            
            view.result.text = "Arquivo salvo com sucesso"
            print("=== \(String(describing: fileManager.countFiles(with: nil)))")
        }
        catch {
            //Exibo o erro ao salvar o arquivo
            view.result.text = "Erro ao salvar o DataFile"
            print("Erro ao gerar o DataFile = \(error.localizedDescription)")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
