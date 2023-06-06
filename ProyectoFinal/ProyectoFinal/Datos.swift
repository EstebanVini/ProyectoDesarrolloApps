//
//  Datos.swift
//  ProyectoFinal
//
//  Created by iOS Lab on 23/05/23.
//

import Foundation
import SwiftUI

struct Persona: Identifiable, Codable {
    var id = UUID()
    var nombre: String
    var edad: Int
    var sexo: String
    var comida: String
    var vegano: Bool
    var presupuesto: Int
    var restaurante: String
    var telefono: String
}

class ReadData: ObservableObject {
    @Published var users = [Persona]()

    func loadData() {
        guard let url = Bundle.main.url(forResource: "UserData", withExtension: "json") else {
            print("Json file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let users = try JSONDecoder().decode([Persona].self, from: data)
            self.users = users
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

