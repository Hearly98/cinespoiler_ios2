//
//  Pelicula.swift
//  cinespoiler_ios
//
//  Created by DISEÑO on 15/12/24.
//

import Foundation

struct MovieResponse: Codable {
    let id: Int
    let titulo: String
    let descripcion: String
    let imagen: String
    let genero: String
    let director: String
    let duracion: Int
    let anio: Int
    let precio: Double
}

