//
//  FileManagerActions.swift
//  EstudoCriptografia
//
//  Created by Fabio Miciano on 21/07/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation

final class FileManagerActions {
    
    let fileManager: FileManager
    let coreData = CoreDataActions()
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    ///    Função usada para salvar arquivos via FileManager
    ///
    ///    - parameter name: Nome do arquivo, exemplo: "teste.pdf"
    ///
    ///    - parameter file: Arquivo que será salvo em formato Data
    ///
    ///    - returns: Retorna sucesso ou falha
    func saveFile(with name: String, file: Data) -> Bool {
        //Pego o diretorio de documentos padrao do device
        guard let generalPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return false }
        let path = generalPath.appending("/\(name)")
        if fileManager.createFile(atPath: path, contents: file, attributes: nil) {
            print("-- Arquivo salvo com sucesso --")
            if self.excludeBackUp(path: path) {
                coreData.savePath(path: path, name: name)
                print("-- Arquivo removido da listagem de backup com sucesso --")
                return true
            }
            return false
        }
        else {
            print("XX - Erro ao gravar o arquivo - XX")
            return false
        }
    }
    
    
    /// Faz a contagem de arquivos no diretorio passado ou no de documentos padrão
    ///
    /// - Parameter path: caminho da pasta, caso não envie nenhum irá buscar no diretorio de documentos padrão
    /// - Returns: Retorna o numero de arquivos encontrados na pasta
    func countFiles(with path: String?) -> Int? {
        
        var pathDirectory: String?
        
        if let path = path { pathDirectory = path }
        else { pathDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first }
        
        guard let directory = pathDirectory else { return nil }
        
        do {
            let directory = try fileManager.contentsOfDirectory(atPath: directory)
            return directory.count
        }
        catch {
            print("XX - Erro ao listar arquivos que estão no diretório = \(directory)")
            return nil
        }
    }
    
    
    /// Função faz a listagem de arquivos no diretorio passado ou no documento padrão
    ///
    /// - Parameter path: caminho da pasta, caso não envie nenhum, irá buscas no diretorio de documentos padrão
    /// - Returns: Retorna a lista de arquivos do diretorio
    func listFiles(with path: String?)-> [String]? {
        var pathDirectory: String?
        
        if let path = path { pathDirectory = path }
        else { pathDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first }
        
        guard let directory = pathDirectory else { return nil }
        
        do {
            let directory = try fileManager.contentsOfDirectory(atPath: directory)
            return directory
        }
        catch {
            print("XX - Erro ao listar arquivos que estão no diretório = \(directory)")
            return nil
        }
    }
    
    
    func excludeBackUp(path file: String)-> Bool {
        var resourceValues = URLResourceValues()
        resourceValues.isExcludedFromBackup = true
        var urlFile = URL(fileURLWithPath: file)
        do {
            try urlFile.setResourceValues(resourceValues)
            return true
        }
        catch {
            print("XX - Erro ao tentar tirar o arquivo da listagem de backups")
            return false
        }
    }
    
}
