//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios7245 on 25/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var repository: ContatoRepository
    
    @IBOutlet var nomeTextField: UITextField!
    
    @IBOutlet var telefoneTextField: UITextField!
    
    @IBOutlet var enderecoTextField: UITextField!
    
    @IBOutlet var siteTextField: UITextField!
    
    @IBOutlet var salvarButton: UIBarButtonItem!
    
    @IBOutlet var titleLabel: UILabel!
    
    private var contato: ContatoObjC?
    
    required init?(coder aDecoder:NSCoder) {
        repository = ContatoRepository.sharedInstance()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func salvaAction() {
        
        if !(nomeTextField.text?.isEmpty)! {
            if let nome = nomeTextField.text {
                titleLabel.text = "Contato \(nome)"
            }
            
            pegaDados()
            guard let contato = contato else { return }
            repository.salva(contato: contato)
            
        } else {
            titleLabel.text = "Contato"
        }
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    func pegaDados() {
        
        contato = ContatoObjC(name: nomeTextField.text!)
        guard let contato = contato else { return }
        contato.endereco = enderecoTextField.text
        contato.telefone = telefoneTextField.text
        contato.site = siteTextField.text
        
        
    }
    
    
}

