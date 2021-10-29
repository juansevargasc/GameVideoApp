//
//  SaveData.swift
//  GameStream
//
//  Created by Juanse Vargas on 22/10/21.
//

import Foundation

class SaveData
{
    var correo: String = ""
    var contrasena: String = ""
    var nombre: String = ""
    
    func guardarDatos(correo: String, contrasena: String, nombre: String) -> Bool
    {
        print("Dentro de función guardar datos obtuve:\n \(correo) + \(contrasena) + \(nombre)")
        
        UserDefaults.standard.set([correo, contrasena, nombre], forKey: "datosUsuario") // Se guarda como datos del usuario (en mi posición sería )
        
        return true
    }
    
    func registrar(correo: String, contrasena: String) -> Bool
    {
        print("Dentro de función guardar datos obtuve:\n \(correo) + \(contrasena) + \(nombre)")
        
        UserDefaults.standard.set([correo, contrasena, nombre], forKey: "datosUsuario") // Se guarda como datos del usuario (en mi posición sería )
        
        return true
    }
    
    // Recupera toda el arreglo o lista de datos, en este caso 3 espacios.
    func recuperarDatos() -> [String]
    {
        let datosUsuario: [String] = UserDefaults.standard.stringArray(forKey: "datosUsuario")!
        print("Estoy en método recuperar datos y recuperé \(datosUsuario)")
        
        return datosUsuario
    }
    
    func validar(correo: String, contrasena: String) -> Bool
    {
        var correoGuardado = ""
        var contrasenaGuardada = ""
        
        // Print los datos ingresados
        print("Revisando si los datos ingresados COINCIDEN en user defaults. INGRESADO: Correo: \(correo) y contraseña: \(contrasena)")
        
        // "datosUsuario" es el usuario concreto que se guardó
        if UserDefaults.standard.object(forKey: "datosUsuario") != nil
        {
            correoGuardado = UserDefaults.standard.stringArray(forKey: "datosUsuario")! [0]
            contrasenaGuardada = UserDefaults.standard.stringArray(forKey: "datosUsuario")! [1]
            
            print("El correo guardado es \(correoGuardado) y contraseña guard. \(contrasenaGuardada)")
            
            
            if (correo == correoGuardado) && (contrasena == contrasenaGuardada)
            {
                print("COINCIDE")
                return true
            }else
            {
                print("NO coincide")
                return false
            }
            
        }else
        {
            print("No hay datos de usuario guardados en userDefaults")
            return false
        }
        
    }
    
}
