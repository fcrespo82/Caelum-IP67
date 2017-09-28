//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios7245 on 25/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private var repository: ContatoRepository
    
    @IBOutlet var nomeTextField: UITextField!
    
    @IBOutlet var telefoneTextField: UITextField!
    
    @IBOutlet var enderecoTextField: UITextField!
    
    @IBOutlet var siteTextField: UITextField!
    
    @IBOutlet var salvarButton: UIBarButtonItem!
    
    @IBOutlet weak var fotoImageView: UIImageView!
    
    @IBOutlet weak var latitudeTextField: UITextField!
    
    @IBOutlet weak var logitudeTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var getLocationButton: UIButton!
    var contato: ContatoObjC?
    
    var delegate: FormularioDelegate?
    
    required init?(coder aDecoder:NSCoder) {
        repository = ContatoRepository.sharedInstance()
        
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.fotoImageView.layer.borderWidth = 2
        self.fotoImageView.layer.borderColor = UIColor.red.cgColor
        self.fotoImageView.layer.cornerRadius = 25.0
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1), execute: {
            self.fotoImageView.layer.cornerRadius = self.fotoImageView.bounds.height / 2
        })
        self.fotoImageView.clipsToBounds = true
        
        if let contato = contato {
            self.nomeTextField.text = contato.nome
            self.telefoneTextField.text = contato.telefone
            self.enderecoTextField.text = contato.endereco
            self.siteTextField.text = contato.site
            self.fotoImageView.image = contato.image
            self.latitudeTextField.text = contato.latitude.description
            self.logitudeTextField.text = contato.longitude.description
            
            let editButton = UIBarButtonItem(title: "Confirmar", style: .done, target: self, action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = editButton
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func salvaAction() {
        pegaDados()
        
        repository.salva(contato!)
        
        delegate?.criado(contato!)
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func atualizaContato() {
        pegaDados()
        
        delegate?.atualizado(contato!)
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func pegaDados() {
        
        if contato == nil {
            contato = repository.novoContato() // ContatoObjC(name: nomeTextField.text!)
        }
        contato!.nome = nomeTextField.text
        contato!.endereco = enderecoTextField.text
        contato!.telefone = telefoneTextField.text
        contato!.site = siteTextField.text
        contato!.image = fotoImageView.image
        if let latitude = Double(latitudeTextField.text!) {
            contato!.latitude = latitude as NSNumber
        }
        if let longitude = Double(logitudeTextField.text!) {
            contato!.longitude = longitude as NSNumber
        }
    }
    
    @IBAction func selecionaFoto(_ sender: AnyObject) {
        
        let alert = UIAlertController(title: "De onde você deseja obter a foto?", message: nil, preferredStyle: .actionSheet)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(cancelar)
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let library = UIAlertAction(title: "Biblioteca", style: .default, handler: { (alertAction) in
                self.pegaFoto(de: .photoLibrary)
            })
            alert.addAction(library)
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let camera = UIAlertAction(title: "Camera", style: .default, handler: { (alertAction) in
                self.pegaFoto(de: .camera)
            })
            alert.addAction(camera)
        }
        
        self.present(alert, animated: true, completion: nil)
        
        print("Selecione sua foto")
    }
    
    @IBAction func buscaGeoLocation(_ sender: UIButton) {
        let geo = CLGeocoder()
        
        activityIndicator.startAnimating()
        sender.isEnabled = false
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = self.enderecoTextField.text
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            
            for item in (response?.mapItems)! {
                print(item.name)
            }
            
        }
        
        geo.geocodeAddressString(enderecoTextField.text!) { (placemarks, error) in
            if (error != nil) {
                return
            }
            
            
            if (placemarks?.count)! > 0 {
                let placemark = placemarks![0]
                
                self.latitudeTextField.text = placemark.location!.coordinate.latitude.description
                self.logitudeTextField.text = placemark.location!.coordinate.longitude.description
                
                print("latitude=\(placemark.location!.coordinate.latitude) longitude=\(placemark.location!.coordinate.longitude)")
                
                geo.reverseGeocodeLocation(placemark.location!, completionHandler: { (placemarks, erro) in
                    
                    for place in placemarks! {
                        print(place.name)
                    }
                    
                })
            }
            self.activityIndicator.stopAnimating()
            sender.isEnabled = true
        }
    }
    
    func pegaFoto(de sourceType:UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = sourceType
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        fotoImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}

