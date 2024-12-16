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
            duracionEditTextField.text = nil
        }
        descripcionEditTextField.text = peliculaUpdate?.descripcion
        if let precio = peliculaUpdate?.precio {
            precioEditTextField.text = "\(precio)"
        } else {
            duracionEditTextField.text = nil
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
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
            print("Se actualizó la pelicula")
        } catch let error as NSError {
            print("Error al actualizar: \(error.localizedDescription)")
        }
    }
     
    @IBAction func didTapEdit(_ sender: UIButton) {
        editPelicula()
    }

}
