//
//  MovieListTableViewController.swift
//  Movies-C
//
//  Created by Ian Richins on 5/8/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    var movieSearchResults: [IGRMovie] = []
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieSearchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell()}
        
        let movie = movieSearchResults[indexPath.row]
        cell.movie = movie
      
        return cell
    }
}

extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = movieSearchBar.text, !searchTerm.isEmpty else {return}
        IGRMovieController.fetchMovie(forSearchTerm: searchTerm) {
            (movies) in
            guard let movies = movies else {return}
            self.movieSearchResults = movies
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.movieSearchBar.text = ""
            }
        }
    }
}
