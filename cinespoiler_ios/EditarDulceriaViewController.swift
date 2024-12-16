//
//  EditarDulceriaViewController.swift
//  cinespoiler_ios
//
//  Created by DAMII on 15/12/24.
//

import UIKit
import CoreData
class EditarDulceriaViewController: UIViewController {

    @IBOutlet weak var nombreDulceEditTextField: UITextField!
    @IBOutlet weak var precioDulceEditTextField: UITextField!
    @IBOutlet weak var descripcionDulceEditTextField: UITextField!
    var dulceriaUpdate: Dulcerias?
    var onDulceriaUpdated: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
    }
     
    func connectBD() -> NSManagedObjectContext {
     let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
     
    func configureTextField() {
        nombreDulceEditTextField.text = dulceriaUpdate?.nombre
        if let precio = dulceriaUpdate?.precio {
            precioDulceEditTextField.text = "\(precio)"
        } else {
            precioDulceEditTextField.text = nil
        }
        descripcionDulceEditTextField.text = dulceriaUpdate?.descripcion
    }
     
    func editDulceria() {
        let context = connectBD()
        dulceriaUpdate?.setValue(nombreDulceEditTextField.text, forKey: "nombre")
        
        if let precioText = precioDulceEditTextField.text, let precio = Double(precioText) {
            dulceriaUpdate?.setValue(precio, forKey: "precio")
        } else {
            dulceriaUpdate?.setValue(nil, forKey: "precio")
        }
        dulceriaUpdate?.setValue(descripcionDulceEditTextField.text, forKey: "descripcion")
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
            showAlert(title: "Editar Dulcería",message:"Se actualizó el dulce correctamente")
        } catch let error as NSError {
            showAlert(title: "Mensaje de Error",message: "Error al actualizar: \(error.localizedDescription)")
        }
    }

    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Entiendo", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
        alert.addAction(action)
        present(alert, animated: true)
    }
    @IBAction func didTapEdit(_ sender: UIButton) {
        editDulceria()
    }
}
