//
//  EditarPeliculaViewController.swift
//  cinespoiler_ios
//
//  Created by DAMII on 15/12/24.
//

import UIKit
import CoreData
class EditarPeliculaViewController: UIViewController {
    
    @IBOutlet weak var tituloEditTextField: UITextField!
    @IBOutlet weak var generoEditTextField: UITextField!
    @IBOutlet weak var directorEditTextField: UITextField!
    @IBOutlet weak var autorEditTextField: UITextField!
    @IBOutlet weak var anioEditTextField: UITextField!
    @IBOutlet weak var descripcionEditTextField: UITextField!
    @IBOutlet weak var precioEditTextField: UITextField!
    @IBOutlet weak var duracionEditTextField: UITextField!
    var peliculaUpdate: Pelicula?
    var onPeliculaUpdated: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
    }
     
    func connectBD() -> NSManagedObjectContext {
     let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
     
    func configureTextField() {
        tituloEditTextField.text = peliculaUpdate?.titulo
        generoEditTextField.text = peliculaUpdate?.genero
        directorEditTextField.text = peliculaUpdate?.director
        autorEditTextField.text = peliculaUpdate?.autor
        if let año = peliculaUpdate?.anio {
            anioEditTextField.text = "\(año)"
        } else {
            anioEditTextField.text = nil
        }
        descripcionEditTextField.text = peliculaUpdate?.descripcion
        if let precio = peliculaUpdate?.precio {
            precioEditTextField.text = "\(precio)"
        } else {
            precioEditTextField.text = nil
        }
        
        if let duracion = peliculaUpdate?.duracion {
            duracionEditTextField.text = "\(duracion)"
        } else {
            duracionEditTextField.text = nil
        }
    }
     
    func editPelicula() {
        let context = connectBD()
        peliculaUpdate?.setValue(tituloEditTextField.text, forKey: "titulo")
        
        if let precioText = precioEditTextField.text, let precio = Double(precioText) {
            peliculaUpdate?.setValue(precio, forKey: "precio")
        } else {
            peliculaUpdate?.setValue(nil, forKey: "precio")
        }
        
        peliculaUpdate?.setValue(generoEditTextField.text, forKey: "genero")
        peliculaUpdate?.setValue(directorEditTextField.text, forKey: "director")
        
        if let duracionText = duracionEditTextField.text, let duracion = Int32(duracionText) {
            peliculaUpdate?.setValue(duracion, forKey: "duracion")
        } else {
            peliculaUpdate?.setValue(nil, forKey: "duracion")
        }
        
        if let anioText = anioEditTextField.text, let anio = Int32(anioText) {
            peliculaUpdate?.setValue(anio, forKey: "anio")
        } else {
            peliculaUpdate?.setValue(nil, forKey: "anio")
        }
        
        peliculaUpdate?.setValue(descripcionEditTextField.text, forKey: "descripcion")
        peliculaUpdate?.setValue(autorEditTextField.text, forKey: "autor")
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
            showAlert(title: "Editar Película",message:"Se actualizó la pelicula correctamente")
        } catch let error as NSError {
            showAlert(title: "Mensaje de Error", message: "Error al actualizar: \(error.localizedDescription)")
        }
    }

    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Entiendo", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true) // Regresa al controlador anterior
                }
        alert.addAction(action)
        present(alert, animated: true)
    }
    @IBAction func didTapEdit(_ sender: UIButton) {
        editPelicula()
    }

}
