import SwiftUI

struct AppContentView: View {
    @State var signInSuccess = false
    
    var body: some View {
        return Group {
            if signInSuccess {
                AppHome()
            }
            else {
                LoginFormView(signInSuccess: $signInSuccess)
            }
        }
    }
}

struct LoginFormView: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    let verticalPaddingForForm = 40.0

    @State private var showError = false

    @Binding var signInSuccess: Bool

    var body: some View {
        ZStack {
            Color.yellow // Color de fondo amarillo
                .ignoresSafeArea()

            VStack(spacing: CGFloat(verticalPaddingForForm)) {
                Spacer()

                Text("Welcome")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.orange)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    )
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(Color.gray)
                    TextField("Enter your name", text: $userName)
                        .foregroundColor(Color.black)
                        .font(.title3)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)

                HStack {
                    Image(systemName: "key")
                        .foregroundColor(Color.gray)
                    SecureField("Enter password", text: $password)
                        .foregroundColor(Color.black)
                        .font(.title3)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)

                Button(action: {
                    if self.userName == "Username" && self.password == "Password" {
                        self.signInSuccess = true
                    }
                    else {
                        self.showError = true
                    }

                }) {
                    Text("Sign in")
                        .padding(10)
                        .foregroundColor(Color.white)
                        .background(Color.orange) // Color de fondo azul
                        .cornerRadius(10)
                        .font(.title3)
                }

                Spacer()

                if showError {
                    Text("Incorrect username/password")
                        .foregroundColor(Color.red)
                        .font(.subheadline)
                }
            }
            .padding(.horizontal, CGFloat(verticalPaddingForForm))
        }
    }
}

struct AppHome: View {
    @State private var selectedPerson: Persona?
    @State private var filteredPersons: [Persona] = [] // Personas filtradas según el rango de edad
    @State private var number: Int = 20 // Edad del usuario

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Text("Hola \(usuario)")
                        .font(.largeTitle)
                        .foregroundColor(Color.white) // Color de texto blanco
                        .padding(.leading) // Añadir espaciado izquierdo
                    Spacer()
                    NavigationLink(destination: ConfiguracionView(number: $number)) {
                        Image(systemName: "gear")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                    Spacer()
                }
                .background(Color.yellow) // Color de fondo azul
                .padding(.bottom, 20) // Añadir espaciado inferior
                Spacer()
                
                Button(action: {
                    filterPersons()
                }) {
                    Text("Mostrar personas")
                        .font(.title3)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange) // Color de fondo azul del botón
                        .cornerRadius(10)
                }
                .padding(.bottom, 10) // Añadir espaciado inferior
                
                Button(action: {
                    refreshCount += 1
                    filterPersons()
                }) {
                    Text("Refresh")
                        .font(.title3)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange) // Color de fondo azul del botón
                        .cornerRadius(10)
                }
                .padding(.bottom, 20) // Añadir espaciado inferior
                
                List(filteredPersons.prefix(10)) { persona in
                    Button(action: {
                        selectedPerson = persona
                    }) {
                        VStack(alignment: .leading) {
                            Text(persona.nombre)
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Edad: \(persona.edad)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .onAppear {
                datas.loadData()
            }
            .sheet(item: $selectedPerson) { person in
                PersonView(person: person)
            }
            .navigationBarHidden(true) // Oculta la barra de navegación
        }
    }

    private func filterPersons() {
        let range = number - 3...number + 3
        let filtered = datas.users.filter { range.contains($0.edad) }
        let offset = refreshCount * 10
        filteredPersons = Array(filtered[offset..<offset + 10])
    }
@State private var path = NavigationPath()
@State private var screen = 2
@State private var usuario = "Usuario"
@ObservedObject var datas = ReadData()
@State private var refreshCount = 0
}

struct SplashView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                AppContentView()
            } else {
                Rectangle()
                    .fill(Color.yellow)
                    .edgesIgnoringSafeArea(.all)
                
                Image("FooDate")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
