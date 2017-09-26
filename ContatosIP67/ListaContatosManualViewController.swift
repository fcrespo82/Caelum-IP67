//
//  ListaContatosManualViewController.swift
//  ContatosIP67
//
//  Created by ios7245 on 26/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import UIKit

class ListaContatosManualViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var textoTextField: UITextField!
    @IBOutlet weak var tabelaTableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    
    var items: [String]?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.items = [String]()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tabelaTableView.delegate = self
        self.tabelaTableView.dataSource = self
        self.editButton.setTitle("Edit", for: .normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func adicionarAction(_ sender: AnyObject) {
        guard let texto = textoTextField.text else { return }
        self.items?.append(texto)
        textoTextField.text = ""
        self.tabelaTableView.reloadData()
    }
    
    @IBAction func editAction(_ sender: AnyObject) {
        self.tabelaTableView.setEditing(true, animated: true)
        
        self.editButton.setTitle("Done", for: .normal)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = self.items {
            return items.count
        }
        return 0
    }
    
    func getCell() -> UITableViewCell {
        guard let cell = self.tabelaTableView.dequeueReusableCell(withIdentifier: "celula") else {
            return UITableViewCell(style: .default, reuseIdentifier: "celula")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = getCell()
        
        cell.textLabel?.text = items?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            items?.remove(at: indexPath.row)
            self.tabelaTableView.deleteRows(at: [indexPath], with: .fade)
            self.tabelaTableView.setEditing(false, animated: true)
            self.editButton.setTitle("Edit", for: .normal)
        }
    }
}
