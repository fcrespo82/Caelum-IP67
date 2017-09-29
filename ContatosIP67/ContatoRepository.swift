//
//  ContatoRepository.swift
//  ContatosIP67
//
//  Created by ios7245 on 25/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import Foundation
import CoreData

class ContatoRepository: NSObject {
    
    private var contatos: [ContatoObjC]
    
    static private var sharedRepository: ContatoRepository?
    
    let coreDataUtil: CoreDataUtil
    
    private override init() {
        contatos = [ContatoObjC]()
        coreDataUtil = CoreDataUtil()
        super.init()
        self.populaBanco()
        self.carregaDados()
    }
    
    func novoContato() -> ContatoObjC {
        return NSEntityDescription.insertNewObject(forEntityName: "ContatoObjC", into: coreDataUtil.persistentContainer.viewContext) as! ContatoObjC
    }
    
    private func carregaDados() {
        
        let request = NSFetchRequest<ContatoObjC>(entityName: "ContatoObjC")
        
        let orderByName = NSSortDescriptor(key: "nome", ascending: true)
        
        request.sortDescriptors?.append(orderByName)
        
        do {
            self.contatos = try coreDataUtil.persistentContainer.viewContext.fetch(request)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func populaBanco() {
        let myDefaults = UserDefaults.standard
        
        if !myDefaults.bool(forKey: "onboardingFinished") {
            //            let contato = ContatoObjC(name: "Fernando")!
            //            contato.endereco = "03134001"
            //            contato.latitude = -23.5897197
            //            contato.longitude = -46.5826299
            //            contatos.append(contato)
            
            let contatoCD = self.novoContato()
            
            contatoCD.nome = "Fernando"
            contatoCD.endereco = "Rua Ibitirama"
            contatoCD.latitude = -23.5897197
            contatoCD.longitude = -46.5826299
            contatoCD.site = "fcrespo82.github.io"
            coreDataUtil.saveContext()
            
            myDefaults.set(true, forKey: "onboardingFinished")
            myDefaults.synchronize()
        }
        
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
        coreDataUtil.saveContext()
        contatos.append(contato)
    }
    
    func listaTodos()-> [ContatoObjC] {
        return contatos
    }
    
    func contatoForIndexPath(_ indexPath: IndexPath) -> ContatoObjC? {
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
        let contato = contatoForIndexPath(indexPath)!
        coreDataUtil.persistentContainer.viewContext.delete(contato)
        contatos.remove(at: indexPath.row)
    }
    
    func buscaPorLetraInicial(_ letra: String) {
        
        let request = NSFetchRequest<ContatoObjC>(entityName: "ContatoObjC")
        
        let predicate = NSPredicate(format: "nome BEGINSWITH[cd] %@", argumentArray: [letra])
        
        request.predicate = predicate
        
        do {
            let results = try coreDataUtil.persistentContainer.viewContext.fetch(request)
            for item in results {
                print(item)
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    
}
