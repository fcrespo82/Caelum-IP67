//
//  CondicaoViewController.swift
//  ContatosIP67
//
//  Created by ios7245 on 29/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import AlamofireImage

class CondicaoViewController: UIViewController {
    
    
    @IBOutlet weak var valorLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var valorMinimoLabel: UILabel!
    @IBOutlet weak var valorMaximoLabel: UILabel!
    
    var coordenadas: CLLocationCoordinate2D?
    
    private let chaveAPI = "c07c35f4b057db4813093c5820ba7cfa"
    private let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?units=metric&lang=pt"
    private let BASE_URL_IMAGE = "http://openweathermap.org/img/w/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIView.appearance().tintColor.cgColor
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1), execute: {
            self.imageView.layer.cornerRadius = self.imageView.bounds.height / 2
        })
        self.imageView.clipsToBounds = true
        
        guard let coordenadas = self.coordenadas else { return }
        
        let param: [String : Any] = [
            "lat": coordenadas.latitude,
            "lon": coordenadas.longitude,
            "appid": self.chaveAPI.description
        ]
        
        Alamofire.request(self.BASE_URL, parameters: param).responseObject { (response: DataResponse<Weather>) in
            if let weather = response.result.value {
                
                self.valorMinimoLabel.text = weather.temperaturaMinima?.description
                self.valorMaximoLabel.text = weather.temperaturaMaxima?.description
                self.valorLabel.text = weather.condicao
                
                let urlImage = URL(string: self.BASE_URL_IMAGE + weather.icone! + ".png")
                self.imageView.af_setImage(withURL: urlImage!)
                
            }
        }
    
        
        // Sem Alamofire
//        let session = URLSession(configuration: .default)
//        let dataTask = session.dataTask(with: url!) { (data, response, error) in
//            if error != nil {
//                return
//            }
//            if let httpResponse = response as? HTTPURLResponse {
//                if httpResponse.statusCode == 200 {
//                    do {
//                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] {
//                            let main = json["main"] as! [String: AnyObject]
//                            let tempMin = main["temp_min"] as! Double
//                            let tempMax = main["temp_max"] as! Double
//                            
//                            let weather = json["weather"] as! [AnyObject]
//                            let texto = weather[0]["main"] as! String
//                            let idImagem = weather[0]["icon"] as! String
//                            DispatchQueue.main.async {
//                                self.valorMinimoLabel.text = tempMin.description
//                                self.valorMaximoLabel.text = tempMax.description
//                                self.valorLabel.text = texto
//                            }
//                            
//                            let urlImagem = URL(string: "http://openweathermap.org/img/w/\(idImagem).png")
//                            
//                            let dataTaskImage = session.dataTask(with: urlImagem!) { (data, response, error) in
//                                if error != nil {
//                                    return
//                                }
//                                if let httpResponse = response as? HTTPURLResponse {
//                                    if httpResponse.statusCode == 200 {
//                                        let image = UIImage(data: data!)
//                                        DispatchQueue.main.async {
//                                            self.imageView.image = image
//                                        }
//                                    }
//                                }
//                            }
//                            dataTaskImage.resume()
//                            
//                        }
//                    } catch let error {
//                        print(error)
//                    }
//                }
//            }
//        }
//        
//        dataTask.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
