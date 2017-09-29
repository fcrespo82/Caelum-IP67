//
//  Weather.swift
//  ContatosIP67
//
//  Created by ios7245 on 29/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import UIKit
import ObjectMapper

class Weather: Mappable {

    var temperaturaMinima: Double?
    var temperaturaMaxima: Double?
    var condicao: String?
    var icone: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.temperaturaMaxima <- map["main.temp_max"]
        self.temperaturaMinima <- map["main.temp_min"]
        self.condicao <- map["weather.0.main"]
        self.icone <- map["weather.0.icon"]
    }
}
