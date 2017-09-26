//
//  ListaContatosViewController.swift
//  ContatosIP67
//
//  Created by ios7245 on 25/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import Foundation
import UIKit

class ListaContatosTableViewController: UITableViewController, FormularioDelegate {
    
    private var repository: ContatoRepository
    
    private var indexPath: IndexPath?
    
    static let reuseIdentifier = "ContatoCell"
    
    // MARK: - Initializer
    
    required init?(coder aDecoder:NSCoder) {
        repository = ContatoRepository.sharedInstance()
        super.init(coder: aDecoder)
        //        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - View related
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
        self.tableView.selectRow(at: self.indexPath, animated: true, scrollPosition: .top)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            if let indexPath = self.indexPath {
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
            self.indexPath = nil
        }
        
    }
    
    // MARK: - Table View Delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return repository.sections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.rowsForSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = getCell()
        
        let contato = repository.contatoForIndexPath(indexPath)
        
        cell.textLabel?.text = contato.nome
        cell.detailTextLabel?.text = contato.telefone
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            repository.deleteFromIndexPath(indexPath)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.setEditing(false, animated: true)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contato = repository.contatoForIndexPath(indexPath)
        
        exibeForm(contato)
        
    }
    
    // MARK: - Functions
    
    func getCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListaContatosTableViewController.reuseIdentifier) else { return UITableViewCell(style: .default, reuseIdentifier: ListaContatosTableViewController.reuseIdentifier) }
        return cell
    }
    
    func exibeForm(_ contato: ContatoObjC) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let formulario: ViewController = storyboard.instantiateViewController(withIdentifier: "formularioContato") as! ViewController
        
        formulario.contato = contato
        formulario.delegate = self
        indexPath = repository.indexPathForContato(contato)
        
        navigationController?.pushViewController(formulario, animated: true)
    }
    
    // MARK: - Formulario Delegate
    
    func atualizado(_ contato: ContatoObjC) {
        indexPath = repository.indexPathForContato(contato)
    }
    
    func criado(_ contato: ContatoObjC) {
        indexPath = repository.indexPathForContato(contato)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "NovoContato" {
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            }
        }
        
    }
}
