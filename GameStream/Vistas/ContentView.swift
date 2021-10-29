//
//  ContentView.swift
//  GameStream
//
//  Created by Juanse Vargas on 26/09/21.
//

import SwiftUI

struct ContentView: View
{
    var body: some View
    {
        NavigationView
        {
            ZStack
            {
                Spacer()
                //Color(.blue).ignoresSafeArea()
                Color(red: 21/255, green: 31/255, blue: 59/255, opacity: 1.0).ignoresSafeArea()
                
                VStack
                {
                    Image("appLogo").resizable().aspectRatio(contentMode: .fit).frame(width: 250)
                        .padding(.bottom, 42)
                    
                    InicioYRegistroView()
                }
                
                
                //Text("Hello, world!").padding().foregroundColor(.red)
            }.navigationBarHidden(true)
        }
    }
}

struct InicioYRegistroView: View
{
    @State var tipoInicioSesion:Bool = true
    var body: some View
    {
        VStack
        {
            HStack
            {
                Spacer()
                Button("INICIA SESIÓN")
                {
                    tipoInicioSesion = true
                    print("Pantalla Inicio sesión")
                }
                .foregroundColor(tipoInicioSesion ? .white : .gray)
                
                Spacer()
                
                Button("REGÍSTRATE")
                {
                    tipoInicioSesion = false
                    print("pantalla registro")
                }
                .foregroundColor(tipoInicioSesion ? .gray : .white)
                
                Spacer()
                
            }
            
            Spacer(minLength: 42)
            
            if tipoInicioSesion == true
            {
                InicioSesionView()
            }else
            {
                RegistroView()
            }
            
        }
    }
}

struct InicioSesionView: View
{
    @State var correo:String = ""
    @State var contraseña:String = ""
    @State var isPantallaHomeActive = false
    @State var ifNotUserFound = false
    
    var body: some View
    {
        
        ScrollView
        {
            VStack(alignment: .leading)
            {
                // CORREO
                Text("Correo electrónico").foregroundColor(Color("Dark-cian"))
                
                ZStack(alignment: .leading)
                {
                    if correo.isEmpty
                    {
                        Text("").foregroundColor(.red).font(.caption)
                    }
                      TextField("ejemplo@gmail.com", text: $correo).foregroundColor(.white)
                    
//                    TextField("Search", text: $correo)
//                        .font(Font.system(size: 14))
//                        .padding()
//                        .background(RoundedRectangle(cornerRadius: 50).fill(Color.white))
//
//                        .foregroundColor(.black)
//                        .padding()
//                        .offset(x:8, y: 10)
                    
                }
                Divider().frame(height: 1).background(Color("Dark-cian"))
                    .padding(.bottom)
                
                
                // CONTRASEÑA
                Text("Contraseña").foregroundColor(.white)
                ZStack(alignment: .leading)
                {
                    if contraseña.isEmpty
                    {
                        Text("Contraseña").font(.caption).foregroundColor(.gray)
                    }
                    SecureField("", text: $contraseña).foregroundColor(.white)
                    
                }
                Divider().frame(height: 1).background(Color("Dark-cian"))
                    .padding(.bottom)
                
                Text("¿Olvidaste tu contraseña?").font(.footnote)
                    .frame(width: 300, alignment: .trailing)
                    .foregroundColor(Color("Dark-cian"))
                    .padding(.bottom)
                
                Button(action: {iniciarSesion()},
                       label:
                       {
                            Text("Iniciar Sesión").fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                                .overlay(RoundedRectangle(cornerRadius: 6.0)
                                .stroke(Color("Dark-cian"), lineWidth: 1.0)
                                .shadow(color: .white, radius: 6))
                       }).alert(isPresented: $ifNotUserFound, content:
                                    {
                                        Alert(title: Text("Error"), message: Text("No se encontró nigún usuario o la contraseña es incorrecta"), dismissButton: .default(Text("Entendido")))
                                    }
                                         )
                
                Text("Inicia sesión con redes sociales").foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack
                {
                    Button(action: {print("Presionó botón facebook")},
                           label:
                           {
                                Text("Facebook").fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(EdgeInsets(top: 4, leading: 18, bottom: 4, trailing: 18))
                                    .overlay(RoundedRectangle(cornerRadius: 6.0).stroke()
                                    .shadow(color: .white, radius: 2) )
                        
                           })
                    
                    Button(action: {print("Presionó botón twitter")},
                           label:
                            {
                                Text("Twitter").fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(EdgeInsets(top: 4, leading: 18, bottom: 4, trailing: 18))
                                    .overlay(RoundedRectangle(cornerRadius: 6.0).stroke()
                                    .shadow(color: .white, radius: 2) )
                    
                            })
                    
                }
                
                
                
            }.padding(.horizontal, 77.0)
            
            NavigationLink(destination: Home(), isActive: $isPantallaHomeActive, label: {EmptyView()})
        }
        
        
    }
    
    func iniciarSesion()
    {
        // Comienza el inicio de sesión
        print("Estoy iniciando sesión.")
        
        // Creación de instancias. En este caso la clase SaveData
        let objetoActualizadorDatos = SaveData()
        let resultado = objetoActualizadorDatos.validar(correo: self.correo, contrasena: self.contraseña)
        
        if resultado == true
        {
            // Se activa la pantalla Home
            ifNotUserFound = false
            isPantallaHomeActive = true
        }else
        {
            ifNotUserFound = true
        }
        
    }
}


struct RegistroView: View
{
    @State var correo = ""
    @State var contraseña = ""
    @State var confirmarContraseña = ""
    @State var contraseñaIsNotConfirmed = false
    @State var isPantallaHomeActive = false
    
    var body: some View
    {
        ScrollView
        {
            
            VStack(alignment: .center) // Foto de perfil
            {
                Text("Elige una foto de perfil")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Puedes cambiarla o elegirla más adelante")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                Button(action: tomarFoto, label: {
                    
                    ZStack
                    {
                        Image("perfilEjemplo").resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: "camera").foregroundColor(.white)
                    }
                })
                    .padding(.bottom)
                
            }
            
            VStack(alignment: .leading)
            {
                // CORREO
                Text("Correo electrónico*").foregroundColor(Color("Dark-cian"))
                    .frame(width: 300, alignment: .leading) // Para lograr que todos los Text tengan 300 de anchura, de otra manera quedaban centrados.

                ZStack(alignment: .leading)
                {
                    if correo.isEmpty
                    {
                        Text("ejemplo@gmail.com").font(.caption).foregroundColor(.gray)
                    }
                    TextField("", text: $correo).foregroundColor(.white)

                }
                Divider().frame(height: 1).background(Color("Dark-cian"))
                    .padding(.bottom)


                // CONTRASEÑA
                Text("Contraseña*").foregroundColor(.white)
                ZStack(alignment: .leading)
                {
                    if contraseña.isEmpty
                    {
                        Text("Contraseña").font(.caption).foregroundColor(.gray)
                    }
                    SecureField("", text: $contraseña).foregroundColor(.white)

                }
                Divider().frame(height: 1).background(Color("Dark-cian"))
                    .padding(.bottom)
                
                //CONFIRMAR CONTRASEÑA
                Text("Confirmar contraseña*").foregroundColor(.white)
                ZStack(alignment: .leading)
                {
                    if contraseña.isEmpty
                    {
                        Text("Contraseña").font(.caption).foregroundColor(.gray)
                    }
                    SecureField("", text: $confirmarContraseña).foregroundColor(.white)

                }
                Divider().frame(height: 1).background(Color("Dark-cian"))
                    .padding(.bottom)

                

            }.padding(.horizontal, 77.0) // Campos de correo - contraseña
            
            VStack
            {
                Button(action: {registrate()},
                       label:
                       {
                            Text("REGÍSTRATE").fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                                .overlay(RoundedRectangle(cornerRadius: 6.0)
                                .stroke(Color("Dark-cian"), lineWidth: 1.0)
                                .shadow(color: .white, radius: 6))
                       }).alert(isPresented: $contraseñaIsNotConfirmed, content:
                                    {
                                        Alert(title: Text("Error"), message: Text("La contraseña no coincide. Confirma tu contraseña"), dismissButton: .default(Text("Entendido")))
                                    }
                                         )

                Text("Inicia sesión con redes sociales").foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)

                HStack
                {
                    Button(action: {print("Presionó botón facebook")},
                           label:
                           {
                                Text("Facebook").font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.vertical, 3.0)
                                    .frame(maxWidth: .infinity, alignment: .center) // Para que ocupe el máximo espacio del contenedor padre, osea Hstack que contiene a los ods botones Fb y twitter
                                    .background(.gray)
                                    .clipShape( RoundedRectangle(cornerRadius: 4.0) ) // El corner radius es el nivel de redondeado.

                    }).padding()

                    Button(action: {print("Presionó botón twitter")},
                           label:
                            {
                                Text("Twitter").font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.vertical, 3.0)
                                    .frame(maxWidth: .infinity, alignment: .center) // Para que ocupe el máximo espacio del contenedor padre, osea Hstack que contiene a los ods botones Fb y twitter
                                    .background(.gray)
                                    .clipShape( RoundedRectangle(cornerRadius: 4.0) ) // El corner radius es el nivel de redondeado.

                            }).padding()

                }
            }.padding(.horizontal, 77.0) // Botones
        }
        
        // Navegar a la pantalla Home
        NavigationLink(destination: Home(), isActive: $isPantallaHomeActive, label: {EmptyView()})
    
    } // var body
    
    func registrate()
    {
        // Confirmar que la contraseña haya sido escrita correctamente
        if contraseña != confirmarContraseña
        {
            contraseñaIsNotConfirmed = true
        }else
        {
            // Contraseña confirmada. No se muestra la alerta.
            contraseñaIsNotConfirmed = false
            
            // Objeto de la clase SavData.
            let objetoActualizadorDatos = SaveData()
            // Registro que no requiere nombre.
            let resultado = objetoActualizadorDatos.registrar(correo: self.correo, contrasena: self.contraseña)
            
            // Activar la pantalla home
            isPantallaHomeActive = true
            print("Se guardaron los datos con exito?: \(resultado)")
        }
        
        
    }
}



func tomarFoto()
{
    print("Tomar fotografía de perfil")
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        Image("pantalla02").resizable()
        ContentView()
    }
}
