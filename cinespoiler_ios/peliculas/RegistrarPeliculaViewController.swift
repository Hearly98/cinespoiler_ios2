//
//  RegistrarPeliculaViewController.swift
//  cinespoiler_ios
//

import UIKit
import CoreData
class RegistrarPeliculaViewController: UIViewController {

    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var generoTextField: UITextField!
    @IBOutlet weak var directorTextField: UITextField!
    @IBOutlet weak var autorTextField: UITextField!
    @IBOutlet weak var anioTextField: UITextField!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var precioTextField: UITextField!
    @IBOutlet weak var duracionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func registrar(_ sender: UIButton) {
        registrarPelicula()
    }
    func connectBD() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
}
    func registrarPelicula() {
        let context = connectBD()
        let entityPelicula = NSEntityDescription.insertNewObject(forEntityName: "Pelicula", into: context) as! Pelicula
        
        entityPelicula.titulo = tituloTextField.text ?? ""
        entityPelicula.precio = Double(precioTextField.text ?? "0.0") ?? 0.0
        entityPelicula.genero = generoTextField.text ?? ""
        entityPelicula.director = directorTextField.text ?? ""
        entityPelicula.autor = autorTextField.text ?? ""
        entityPelicula.anio = Int32(anioTextField.text ?? "") ?? 0
        entityPelicula.descripcion = descripcionTextField.text ?? ""
        entityPelicula.duracion = Int32(duracionTextField.text ?? "") ?? 0
        do {
            try context.save()
            showAlert(title: "Registrar Pelicula", message: "Su registro de pelicula se ha realizado exitosamente")
        } catch let error as NSError {
            print("Error al guardar: \(error.localizedDescription)")
        }
    }

    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Entiendo", style: .default)
        alert.addAction(action)
        navigationController?.popViewController(animated: true)
        present(alert, animated: true)
    }

}
