//
//  GerenciadorAcao.swift
//  ContatosIP67
//
//  Created by ios7245 on 27/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import UIKit

class GerenciadorAcao: NSObject {
    
    private let contato: ContatoObjC
    
    init(do contato: ContatoObjC) {
        self.contato = contato
    }
    
    func exibeAcoes(em controller: UIViewController) {
        
        let alertController = UIAlertController(title: contato.nome, message: "O que deseja fazer?", preferredStyle: .actionSheet)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelar)
        
        let ligar = UIAlertAction(title: "Ligar", style: .default) { (alertAction) in
            self.ligar(controller)
        }
        
        let verSite = UIAlertAction(title: "Visitar site", style: .default) { (alertAction) in
            self.verSite()
        }
        
        let verMapa = UIAlertAction(title: "Ver endereço", style: .default) { (alertAction) in
            self.verEndereco()
        }
        
        if !contato.endereco.isEmpty {
            alertController.addAction(verMapa)
        }
        if !contato.telefone.isEmpty {
            alertController.addAction(ligar)
        }
        if !contato.site.isEmpty {
            alertController.addAction(verSite)
        }
        
        controller.present(alertController, animated: true) {
            
        }
    }
    
    enum UIDeviceModel: String {
        case iPhone = "iPhone"
        
        static func ==(lhs: UIDeviceModel, rhs: String) -> Bool {
            return lhs.rawValue == rhs
        }
    }
    
    private func ligar(_ controller:UIViewController) {
        if UIDeviceModel.iPhone == UIDevice.current.model {
            print("Ligando")
            let url = URL(string: "tel:\(self.contato.telefone!)")
            navegar(para: url!)
        } else {
            let alert = UIAlertController(title: "Erro", message: "Seu dispositivo não pode ligar", preferredStyle: .alert)
            
            let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alert.addAction(cancelar)

            controller.present(alert, animated: true)

        }
    }
    
    private func verSite() {
        print("Navegando")
        var site = self.contato.site
        if !(site?.contains("http://"))! {
            site = "http://\(site!)"
        }
        let url = URL(string: site!)
        navegar(para: url!)
    }
    
    private func verEndereco() {
        print("Mapeando")
        _ = "http://maps.google.com.br/maps?q=\(self.contato.endereco!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var url = URLComponents(string: "http://maps.google.com.br/maps")
        url?.queryItems?.append(URLQueryItem(name: "q", value: self.contato.endereco!))
        navegar(para: (url?.url)!)
    }
    
    private func navegar(para url:URL) {
        UIApplication.shared.open(url)
    }
}
