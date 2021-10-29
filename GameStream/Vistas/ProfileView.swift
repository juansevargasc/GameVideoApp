//
//  ProfileView.swift
//  GameStream
//
//  Created by Juanse Vargas on 18/10/21.
//

import SwiftUI

struct ProfileView: View
{
    @State var nombreUsuario: String = "Lorem"
    @State var imagenPerfil: UIImage = UIImage(named: "perfilEjemplo")!
    
    
    var body: some View
    {
        
        ZStack
        {
            Color("Marine").ignoresSafeArea()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
            VStack
            {
                    
                Text("PERFIL").fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .center)
                    .padding()
                  
                VStack
                {
                    Image(uiImage: imagenPerfil).resizable().aspectRatio(contentMode: .fill)
                     .frame(width: 118.0, height: 118.0)
                     .clipShape(Circle())
           
                    Text(nombreUsuario)
                     .fontWeight(.bold)
                     .foregroundColor(Color.white)
                        

                }.padding(EdgeInsets(top: 16, leading: 0, bottom: 32, trailing: 0))
                
               
                Text("Ajustes")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity,  alignment: .leading)
                    .padding(.leading,18)
                
           
                ModuloAjustes()
                
                Spacer()
             
               
            }
            
                 
        }.onAppear(
                    
                    perform: {
                        
                       // Recuperar imgen
                        if returnUiImage(named: "fotoperfil") != nil
                        {
                            imagenPerfil = returnUiImage(named: "fotoperfil")!
                        }else
                        {
                            print("No encontré foto de perfil en dispositivo.")
                        }
                        
                        
                       print("revisando si tengo datos en user defaults")
                        
                        if UserDefaults.standard.object(forKey: "datosUsuario") != nil
                        {
                            
                            nombreUsuario = UserDefaults.standard.stringArray(forKey: "datosUsuario")![2]
                            print("Si encontre nombre de usuario \(nombreUsuario)")
                        }else{
                            
                            print("no encontre nombre de usuario guardado en objeto global de userdefaults")
                            
                        }
                        
                    }
                
                
                )
               
    }
    
    func returnUiImage(named: String) -> UIImage?
    {
    
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        {
            
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path )
            
        }
        
        return nil // En caso que no la pueda recuperar
    
    }
}


struct ModuloAjustes:View
{
    @State var isToggleOn = true
    @State var isEditProfielViewActive = false
    
    var body: some View
    {
        // Code here
        VStack(spacing: 3.0)
        {
            // Cuenta
            Button(action: {}, label: {
                
                
                HStack
                {
                                    
                    Text("Cuenta")
                    .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Text(">")
                    .foregroundColor(Color.white)
                            
                }.padding()
                
            }).background(Color("TabBar-Color"))
                .clipShape(RoundedRectangle(cornerRadius: 1.0))
                //.padding(.horizontal, 8.0)
            
            // Notificaciones
            Button(action: {}, label: {
                
                
                HStack
                {
                                    
                    Text("Notificaciones")
                    .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Toggle("", isOn: $isToggleOn)
                            
                }.padding()
                
            }).background(Color("TabBar-Color"))
                .clipShape(RoundedRectangle(cornerRadius: 1.0))
            
            
            // Editar perfil
            Button(action: {isEditProfielViewActive = true}, label: {
                
                
                HStack
                {
                                    
                    Text("Editar Perfil")
                    .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Text(">")
                    .foregroundColor(Color.white)
                            
                }.padding()
                
            }).background(Color("TabBar-Color"))
                .clipShape(RoundedRectangle(cornerRadius: 1.0))
            
            // Califiación
            Button(action: {}, label: {
                
                
                HStack
                {
                                    
                    Text("Califica esta aplicación")
                    .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Text(">")
                    .foregroundColor(Color.white)
                            
                }.padding()
                
            }).background(Color("TabBar-Color"))
                .clipShape(RoundedRectangle(cornerRadius: 1.0))
            
            
            // Navigation link
            NavigationLink(destination: EditProfileView(),
                           isActive: $isEditProfielViewActive,
                           label: {
                                EmptyView()
            })
            
            // Text("Hola")
        }
        
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
