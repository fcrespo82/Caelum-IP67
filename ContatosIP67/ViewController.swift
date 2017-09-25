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
    
    @IBOutlet var salvarButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    
    
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
        
        var contato: ContatoObjC?
        
        
        if !(nomeTextField.text?.isEmpty)! {
            if let nome = nomeTextField.text {
                titleLabel.text = "Salvo o contato, \(nome)"
            }
            
            contato = ContatoObjC(name: nomeTextField.text!)
            if let contato = contato {
                contato.endereco = enderecoTextField.text
                contato.telefone = telefoneTextField.text
                contato.site = siteTextField.text
                repository.salva(contato: contato)
                print(repository.lista())
            }
        } else {
            titleLabel.text = "Olá"
        }
    }
    
}

