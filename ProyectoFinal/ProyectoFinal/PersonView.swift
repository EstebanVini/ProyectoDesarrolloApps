import SwiftUI

struct PersonView: View {
    let person: Persona
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(randomImageName(for: person.sexo))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            Text("Nombre: \(person.nombre)")
                .font(.title)
                .foregroundColor(.primary)
            
            Text("Edad: \(person.edad)")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Comida favorita: \(person.comida)")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Vegano: \(person.vegano ? "Sí" : "No")")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Presupuesto: \(person.presupuesto)")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Restaurante favorito: \(person.restaurante)")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Teléfono: \(person.telefono)")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 5)
        )
    }
    
    private func randomImageName(for sexo: String) -> String {
        let maleImages = ["male_image1", "male_image2", "male_image3", "male_image4", "male_image5"]
        let femaleImages = ["female_image1", "female_image2", "female_image3", "female_image4", "femaleimage5"]
        
        if sexo.lowercased() == "hombre" {
            return maleImages.randomElement() ?? "default_male_image"
        } else if sexo.lowercased() == "mujer" {
            return femaleImages.randomElement() ?? "default_female_image"
        } else {
            return "default_image"
        }
    }
}
