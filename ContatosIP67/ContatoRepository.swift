//
//  ContatoRepository.swift
//  ContatosIP67
//
//  Created by ios7245 on 25/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import Foundation


class ContatoRepository: NSObject {
    
    private var contatos: [ContatoObjC]
 
    static private var sharedRepository: ContatoRepository?
    
    private override init() {
        contatos = [ContatoObjC]()
        super.init()
    }
    
    static func sharedInstance() -> ContatoRepository {
        if let sharedRepository = self.sharedRepository {
            return sharedRepository
        } else {
            self.sharedRepository = ContatoRepository()
        }
        return self.sharedRepository!
    }
    
    func salva(_ contato: ContatoObjC) {
        contatos.append(contato)
    }
    
    func listaTodos()-> [ContatoObjC] {
        return contatos
    }
    
    func contatoForIndexPath(_ indexPath: IndexPath) -> ContatoObjC {
        return contatos[indexPath.row]
    }
    
    func indexPathForContato(_ contato: ContatoObjC) -> IndexPath {
        let index = contatos.index(of: contato)
        return IndexPath(row: index!, section: 0)
    }
    
    func sections() -> Int {
//        let map = contatos.map { (contato) -> String in
//            return contato.nome.substring(to: newIndex)
//        }
        
        return 1
    }
    
    func rowsForSection(_ section: Int) -> Int {
        return contatos.count
    }
    
    func deleteFromIndexPath(_ indexPath: IndexPath) {
        contatos.remove(at: indexPath.row)
    }
    
}
