//
//  ListPeliculasViewController.swift
//  cinespoiler_ios
//
//  Created by DAMII on 15/12/24.
//

import UIKit
import CoreData
class ListPeliculasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var listPeliculasTableView: UITableView!
    var peliculaData = [Pelicula]()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        showData()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listPeliculasTableView.reloadData()
    }
     
    func connectBD() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
     
    func configureTableView() {
        listPeliculasTableView.delegate = self
        listPeliculasTableView.dataSource = self
        listPeliculasTableView.rowHeight = 300
    }
     
    func showData() {
        let context = connectBD()
        let fetchRequest: NSFetchRequest<Pelicula> = Pelicula.fetchRequest()
        do {
            peliculaData = try context.fetch(fetchRequest)
            print("Se mostraron los datos en la tabla")
        }
        catch let error as NSError {
            showAlert(title: "Listar Películas", message: "Error al mostrar: \(error.localizedDescription)")
        }
    }
     
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peliculaData.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
"PeliculaTableViewCell", for: indexPath) as? PeliculaTableViewCell
        let pelicula = peliculaData[indexPath.row]
        cell?.configurePelicula(pelicula: pelicula, viewController: self)
        return cell ?? UITableViewCell()
    }
     
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = connectBD()
        let pelicula = peliculaData[indexPath.row]
        if editingStyle == .delete {
            context.delete(pelicula)
            do {
                try context.save()
                showAlert(title: "Eliminar Película", message: "Se eliminó el registro")
                
            }
            catch let error as NSError {
                showAlert(title: "Mensaje de Error", message: "Error al eliminar el registro: \(error.localizedDescription)")
            }
        }
        showData()
        listPeliculasTableView.reloadData()
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editarPeliculaView", sender: self)
    }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editarPeliculaView" {
            if let id = listPeliculasTableView.indexPathForSelectedRow {
                let rowPelicula = peliculaData[id.row]
                let router = segue.destination as? EditarPeliculaViewController
                router?.peliculaUpdate = rowPelicula
                router?.onPeliculaUpdated = { [weak self] in
                                   self?.showData()
                                   self?.listPeliculasTableView.reloadData()
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
