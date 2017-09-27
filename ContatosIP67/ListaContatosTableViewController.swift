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
    
    static let reuseIdentifier = "ContatoCustomCell"
    
    // MARK: - Initializer
    
    required init?(coder aDecoder:NSCoder) {
        repository = ContatoRepository.sharedInstance()
        super.init(coder: aDecoder)
        //        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - View related
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: "ContatoTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "ContatoCustomCell")
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(exibeAcoes(gesture:)))
        
        tableView.addGestureRecognizer(gesture)
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
    
    //    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    //        return repository.sectionNames()
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.rowsForSection(section)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = getCell() as! ContatoTableViewCell
        
        return cell.bounds.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = getCell() as! ContatoTableViewCell
        
        if let contato = repository.contatoForIndexPath(indexPath) {
            
            cell.titleLabel.text = contato.nome
            cell.customImageView?.contentMode = .scaleAspectFill
            cell.customImageView?.image = contato.image
            
            cell.customImageView?.layer.borderWidth = 1
            cell.customImageView?.layer.borderColor = UIColor.red.cgColor
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: { 
                cell.customImageView?.layer.cornerRadius = (cell.customImageView?.bounds.height)! / 2
            })
        
            
            cell.customImageView?.clipsToBounds = true
            
            
//            cell.textLabel?.text = contato.nome
//            cell.detailTextLabel?.text = contato.telefone
//            cell.imageView?.contentMode = .scaleAspectFill
//            cell.imageView?.image = contato.image
//            
//            cell.imageView?.layer.borderWidth = 1
//            cell.imageView?.layer.borderColor = UIColor.red.cgColor
//
//            cell.imageView?.layer.cornerRadius = 7
//            
//            cell.imageView?.clipsToBounds = true

        }
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
        if let contato = repository.contatoForIndexPath(indexPath) {
            
            exibeForm(contato)
        }
        
    }
    
    // MARK: - Functions
    
    func getCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListaContatosTableViewController.reuseIdentifier) else { return ContatoTableViewCell(style: .default, reuseIdentifier: ListaContatosTableViewController.reuseIdentifier) }
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
    
    
    // MARK: - Gestures
    func exibeAcoes(gesture: UIGestureRecognizer) {
        print("\(gesture.state.rawValue)")
        if gesture.state == .began {
            let ponto = gesture.location(in: tableView)
            if let index = tableView.indexPathForRow(at: ponto) {
                if let contato = repository.contatoForIndexPath(index) {
                    print(contato)
                    print("Long press")
                    let gerenciadorAcao = GerenciadorAcao(do: contato)
                    gerenciadorAcao.exibeAcoes(em: self)
                }
            }
        }
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
