//
//  MovieDetailViewController.swift
//  flixster
//
//  Created by Nancy Ng  on 2/19/21.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {
   
    @IBOutlet weak var movie_backdrop: UIImageView!
    @IBOutlet weak var movie_title: UILabel!
    @IBOutlet weak var movie_synopsis: UILabel!
    @IBOutlet weak var movie_poster: UIImageView!
    
    
    var movie : [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
        movie_title.text = movie["title"] as? String
        movie_title.sizeToFit()
        
        movie_synopsis.text = movie["overview"] as? String
        movie_synopsis.sizeToFit()
        
        let base_url = "https://image.tmdb.org/t/p/w185"
        
        let posterpath = movie["poster_path"] as! String
        let posterURL = URL(string: base_url+posterpath)
        
        movie_poster.af.setImage(withURL: posterURL!)
        
        //backdrop poster
        let backdropPath = movie["backdrop_path"] as! String
        let backdrop_posterURL = URL(string: "https://image.tmdb.org/t/p/w780"+backdropPath)
        
        movie_backdrop.af.setImage(withURL: backdrop_posterURL!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
