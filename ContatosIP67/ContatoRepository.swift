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
        
        guard let sharedRepository = sharedRepository else { return ContatoRepository() }
    
        return sharedRepository
        
    }
    
    func salva(contato: ContatoObjC) {
        contatos.append(contato)
    }
    
    func lista()-> [ContatoObjC] {
        return contatos
    }
    
}
