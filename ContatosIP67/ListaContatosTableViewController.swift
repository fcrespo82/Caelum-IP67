//
//  ListaContatosViewController.swift
//  ContatosIP67
//
//  Created by ios7245 on 25/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import Foundation
import UIKit

class ListaContatosTableViewController: UITableViewController {
    
    private var repository: ContatoRepository
    
    static let reuseIdentifier = "ContatoCell"
    
    required init?(coder aDecoder:NSCoder) {
        repository = ContatoRepository.sharedInstance()
        super.init(coder: aDecoder)
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return repository.sections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.rowsForSection(section)
    }
    
    func getCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListaContatosTableViewController.reuseIdentifier) else { return UITableViewCell(style: .default, reuseIdentifier: ListaContatosTableViewController.reuseIdentifier) }
        return cell
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
    }
}
