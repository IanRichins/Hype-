//
//  MovieTableViewCell.swift
//  Movies-C
//
//  Created by Ian Richins on 5/8/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: IGRMovie? {
        didSet {
            guard let movie = movie else {return}
            movieTitleLabel.text = movie.title
            movieRatingLabel.text = "\(movie.rating)"
            movieOverviewLabel.text = movie.overview
            posterImageView.image = nil
            
            
            IGRMovieController.fetchPoster(for: movie) { (posterImage) in
                if let posterImage = posterImage {
                DispatchQueue.main.async {
                    self.posterImageView.image = posterImage
                    }
                }
            }
        }
    }
}
