//
//  EditProfileView.swift
//  GameStream
//
//  Created by Juanse Vargas on 18/10/21.
//

import SwiftUI

struct EditProfileView: View
{
    @State var imagenPerfil:Image? = Image("perfilEjemplo")
    @State var isCameraActive = false
    
    var body: some View
    {
        ZStack
        {
            Color("Marine").ignoresSafeArea()
            
            
            ScrollView
            {
                
                VStack
                {
                    
                    
                    Button(action: { isCameraActive = true }, label: {
                        
                        ZStack
                        {
                            imagenPerfil!
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 118, height: 118)
                                .clipShape(Circle())
                                .sheet(isPresented: $isCameraActive, content: { // Sheet, para activar una hoja, en este caso el contenido de
                                    SUImagePickerView(sourceType: .camera, image: self.$imagenPerfil, isPresented: $isCameraActive)
                                })
                            
                            Image(systemName: "camera")
                                .foregroundColor(.white)
                        }
                        
                        
                    })
                    
                }.padding(.bottom, 18.0)
                
                // Modulo Editar
                ModuloEditar()
                
            }
            
        }
    }
    
}


struct ModuloEditar: View
{
    @State var correo: String = ""
    @State var contraseña: String = ""
    @State var nombre: String = ""
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            // CORREO
            Text("Correo electrónico").foregroundColor(Color("Dark-cian"))
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
            Text("Contraseña").foregroundColor(.white)
            ZStack(alignment: .leading)
            {
                if contraseña.isEmpty
                {
                    Text("Introduce tu contraseña").font(.caption).foregroundColor(.gray)
                }
                SecureField("", text: $contraseña).foregroundColor(.white)

            }
            Divider().frame(height: 1).background(Color("Dark-cian"))
                .padding(.bottom)
            
            //CONFIRMAR CONTRASEÑA
            Text("Nombre").foregroundColor(.white)
            ZStack(alignment: .leading)
            {
                if nombre.isEmpty
                {
                    Text("Introduce tu nombre").font(.caption).foregroundColor(.gray)
                }
                TextField("", text: $nombre).foregroundColor(.white)

            }
            Divider().frame(height: 1).background(Color("Dark-cian"))
                .padding(.bottom, 32.0)

            
            // Botón de actualizar datos
            Button(action:{ actualizarDatos() }) {
                            Text("ACTUALIZAR DATOS")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame( maxWidth: .infinity, alignment: .center)
                                .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                                .overlay(RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("Dark-cian"), lineWidth: 3).shadow(color: .white, radius: 6))
                
            }.padding(.bottom)

        }.padding(.horizontal, 77.0)
        
        
    }
    
    func actualizarDatos()
    {
        let objetoActualizadorDatos = SaveData()
        
        let resultado = objetoActualizadorDatos.guardarDatos(correo: correo, contrasena: contraseña, nombre: nombre)
        
        print("Se guardaron los datos con exito?: \(resultado)")
    }
}

struct EditProfileView_Previews: PreviewProvider
{
    static var previews: some View {
        EditProfileView()
    }
}
