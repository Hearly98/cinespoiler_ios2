//
//  ListPeliculasViewController.swift
//  cinespoiler_ios
//
//  Created by DAMII on 15/12/24.
//

import UIKit

class ListPeliculasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var listTableView: UITableView!
    
   
    var arrayPeliculas = [MovieResponse]()
    var peliculaSeleccionada: MovieResponse?

    override func viewDidLoad() {
            super.viewDidLoad()
            configureTableView()
            fetchData()
    }

    

        func configureTableView() {
            listTableView.delegate = self
            listTableView.dataSource = self
            listTableView.register(UINib(nibName: "ListTablePeliculaViewCell", bundle: nil), forCellReuseIdentifier: "ListTablePeliculaViewCell")
            listTableView.rowHeight = 600
            listTableView.showsVerticalScrollIndicator = false
            listTableView.separatorStyle = .none
        }

        func fetchData() {
            let webService = "http://apipeliculas-o8pp.onrender.com/api/peliculas"
            guard let url = URL(string: webService) else { return }
            
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                    print("Error de conexión: \(String(describing: error?.localizedDescription))")
                    return
                }
                do {
                    guard let dataJSON = data else { return }
                    self?.arrayPeliculas = try JSONDecoder().decode([MovieResponse].self, from: dataJSON)
                    DispatchQueue.main.async {
                        self?.listTableView.reloadData()
                    }
                } catch {
                    print("Error al parsear los datos: \(error)")
                }
            }.resume()
        }

        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrayPeliculas.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = listTableView.dequeueReusableCell(withIdentifier: "ListTablePeliculaViewCell", for: indexPath) as? ListTablePeliculaViewCell else {
                return UITableViewCell()
            }
            let pelicula = arrayPeliculas[indexPath.row]
            cell.configureView(movie: pelicula)
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            peliculaSeleccionada = arrayPeliculas[indexPath.row]
            print("Película seleccionada: \(peliculaSeleccionada?.titulo ?? "")")
        }
}
