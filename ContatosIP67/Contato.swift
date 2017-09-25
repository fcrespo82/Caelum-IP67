//
//  Contato.swift
//  ContatosIP67
//
//  Created by ios7245 on 25/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import Foundation


class Contato: CustomDebugStringConvertible {

    var nome: String
    var telefone: String?
    var endereco: String?
    var site: String?
    
    init(nome: String) {
        self.nome = nome
    }
    
    var debugDescription: String {
        return "Contato(nome:\(nome))"
    }
    
}
