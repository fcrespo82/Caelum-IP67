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
    
    var contato: ContatoObjC?
    
    var delegate: FormularioDelegate?
    
    required init?(coder aDecoder:NSCoder) {
        repository = ContatoRepository.sharedInstance()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let contato = contato {
            self.nomeTextField.text = contato.nome
            self.telefoneTextField.text = contato.telefone
            self.enderecoTextField.text = contato.endereco
            self.siteTextField.text = contato.site
            
            let editButton = UIBarButtonItem(title: "Confirmar", style: .done, target: self, action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = editButton
        }
        
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func salvaAction() {
        pegaDados()
        
        updateUI()
        
        repository.salva(contato!)
        
        delegate?.criado(contato!)
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func atualizaContato() {
        pegaDados()
        
        updateUI()
        
        delegate?.atualizado(contato!)
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func updateUI() {
        
        if !(nomeTextField.text?.isEmpty)! {
            if let nome = nomeTextField.text {
                titleLabel.text = "Contato \(nome)"
            }
        } else {
            titleLabel.text = "Contato"
        }
    }
    
    func pegaDados() {
        
        if contato == nil {
            contato = ContatoObjC(name: nomeTextField.text!)
        }
        contato!.nome = nomeTextField.text
        contato!.endereco = enderecoTextField.text
        contato!.telefone = telefoneTextField.text
        contato!.site = siteTextField.text
        
    }
    
    
}

