import SwiftUI

struct ConfiguracionView: View {
        @State var nombre: String = ""
       @Binding var number: Int
       @State var vegano: Bool = false
       @State private var seleccionComida = ""
       @State var presupuesto: Int = 0
       @State private var seleccionRestaurante = ""
       let comida = ["Enchiladas", "Pollo empanizado","Pizza","Hamburguesas", "Tacos", "Lassagna"]
       let restaurante = ["Carls Jr.", "KFC", "Casa de Toño", "Los Arcos", "Tacos Rifados", "Glory bee", "La Mansion", "Burger King"]
       @State private var personasList: [Personas] = []
    
    var body: some View {
        Form {
            Section(header: Text("Datos personales").font(.headline)) {
                TextField("Nombre", text: $nombre)
                    .font(.body)
                Picker("Tu edad", selection: $number) {
                    ForEach(1...100, id: \.self) { number in
                        Text("\(number)")
                            .font(.body)
                    }
                }
                Toggle("Vegano", isOn: $vegano)
                    .font(.body)
            }
            
            Section(header: Text("Preferencias").font(.headline)) {
                VStack {
                    Picker("Comida favorita", selection: $seleccionComida) {
                        ForEach(comida, id: \.self) {
                            Text($0)
                                .font(.body)
                        }
                    }
                    .pickerStyle(.menu)
                    Text("Comida favorita seleccionada: \(seleccionComida)")
                        .font(.body)
                }
                
                TextField("Presupuesto", value: $presupuesto, format: .number)
                    .font(.body)
                VStack {
                    Picker("Restaurante favorito", selection: $seleccionRestaurante) {
                        ForEach(restaurante, id: \.self) {
                            Text($0)
                                .font(.body)
                        }
                    }
                    .pickerStyle(.menu)
                    Text("Restaurante favorito seleccionado: \(seleccionRestaurante)")
                        .font(.body)
                }
            }
            
            Button(action: {
                let personas = Personas(nombre: nombre, number: number, vegano: vegano, comida: seleccionComida, presupuesto: presupuesto, restaurante: seleccionRestaurante)
                personasList.append(personas)
                saveData(personasList: personasList)
            }) {
                Text("Guardar cambios")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear {
            loadData()
        }
    }
    
    func saveData(personasList: [Personas]) {
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("datos.txt") else {
            print("No se pudo obtener el directorio de documentos.")
            return
        }
        
        do {
            let data = try JSONEncoder().encode(personasList)
            try data.write(to: fileURL)
            print("Los datos se han guardado correctamente en el archivo: \(fileURL.path)")
        } catch {
            print("Error al guardar los datos: \(error.localizedDescription)")
        }
    }
    
    func loadData() {
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("datos.json") else {
            print("No se pudo obtener el directorio de documentos.")
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            personasList = try JSONDecoder().decode([Personas].self, from: data)
            print("Los datos se han cargado correctamente desde el archivo: \(fileURL.path)")
        } catch {
            print("Error al cargar los datos: \(error.localizedDescription)")
        }
    }
}

struct Personas: Codable, Hashable {
    let nombre: String
    let number: Int
    let vegano: Bool
    let comida: String
    let presupuesto: Int
    let restaurante: String
}
