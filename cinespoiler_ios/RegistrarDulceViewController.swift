//
//  RegistrarDulceViewController.swift
//  cinespoiler_ios
//
//  Created by DAMII on 15/12/24.
//

import UIKit
import CoreData
class RegistrarDulceViewController: UIViewController {

    @IBOutlet weak var nombreDulceTextField: UITextField!
    @IBOutlet weak var precioDulceTextField: UITextField!
    @IBOutlet weak var descripcionDulcesTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func registrar(_ sender: UIButton) {
        registrarDulce()
    }
    func connectBD() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
}
    func registrarDulce() {
        let context = connectBD()
        let entityDulce = NSEntityDescription.insertNewObject(forEntityName: "Dulcerias", into: context) as! Dulcerias
        
        entityDulce.nombre = nombreDulceTextField.text ?? ""
        entityDulce.descripcion = descripcionDulcesTextField.text ?? ""
        entityDulce.precio = Double(precioDulceTextField.text ?? "") ?? 0.0

        do {
            try context.save()
            showAlert(title: "Registrar Dulce", message: "Su registro de dulce se ha realizado exitosamente")
        } catch let error as NSError {
            showAlert(title: "Mensaje de Error", message: "Error al guardar: \(error.localizedDescription)")
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
