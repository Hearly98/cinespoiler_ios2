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
        generoEditTextField.text = peliculaUpdate?.titulo
        directorEditTextField.text = peliculaUpdate?.titulo
        autorEditTextField.text = peliculaUpdate?.titulo
        anioEditTextField.text = peliculaUpdate?.titulo
        descripcionEditTextField.text = peliculaUpdate?.titulo
        precioEditTextField.text = peliculaUpdate?.titulo
        duracionEditTextField.text = peliculaUpdate?.duracion
    }
     
    func editPelicula() {
  let context = connectBD()
        personUpdate?.setValue(nameEditTextField.text, forKey: "name")
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
