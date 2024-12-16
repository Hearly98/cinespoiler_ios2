//
//  ListDulceriaViewController.swift
//  cinespoiler_ios
//
//  Created by DAMII on 15/12/24.
//

import UIKit
import CoreData
class ListDulceriaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listDulceriaTableView: UITableView!
    var dulceriaData = [Dulcerias]()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        showData()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showData()
    }
     
    func connectBD() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
     
    func configureTableView() {
        listDulceriaTableView.delegate = self
        listDulceriaTableView.dataSource = self
        listDulceriaTableView.rowHeight = 300
    }
     
    func showData() {
        let context = connectBD()
        let fetchRequest: NSFetchRequest<Dulcerias> = Dulcerias.fetchRequest()
        do {
            dulceriaData = try context.fetch(fetchRequest)
            listDulceriaTableView.reloadData()
        }
        catch let error as NSError {
            showAlert(title: "Listar Dulcería", message: "Error al mostrar: \(error.localizedDescription)")
        }
    }
     
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dulceriaData.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
"DulceriaTableViewCell", for: indexPath) as? DulceriaTableViewCell
        let dulceria = dulceriaData[indexPath.row]
        cell?.configureDulceria(dulceria: dulceria, viewController: self)
        return cell ?? UITableViewCell()
    }
     
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = connectBD()
        let dulceria = dulceriaData[indexPath.row]
        if editingStyle == .delete {
            dulceriaData.remove(at: indexPath.row)
            context.delete(dulceria)
            do {
                try context.save()
                showAlert(title: "Eliminar Dulceria", message: "Se eliminó el registro")
            }
            catch let error as NSError {
                showAlert(title: "Mensaje de Error", message: "Error al eliminar el registro: \(error.localizedDescription)")
            }
        }
        showData()
        listDulceriaTableView.reloadData()
    }

     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editarDulceriaView", sender: self)
    }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editarDulceriaView" {
            if let id = listDulceriaTableView.indexPathForSelectedRow {
                let rowDulceria = dulceriaData[id.row]
                let router = segue.destination as? EditarDulceriaViewController
                router?.dulceriaUpdate = rowDulceria
                router?.onDulceriaUpdated = { [weak self] in
                                   self?.showData()
                                   self?.listDulceriaTableView.reloadData()
                               }
            }
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
}
    
