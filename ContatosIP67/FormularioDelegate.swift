//
//  FormularioDelegate.swift
//  ContatosIP67
//
//  Created by ios7245 on 26/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import Foundation


protocol FormularioDelegate {
    
    func atualizado(_ contato: ContatoObjC)
    
    func criado(_ contato: ContatoObjC)
    
}
