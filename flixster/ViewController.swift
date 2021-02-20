//
//  ViewController.swift
//  flixster
//
//  Created by Nancy Ng  on 2/8/21.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    
    //properties go here
    
    //() indicates separation
      
    var movies = [[String:Any ]]()
    @IBOutlet weak var tableview: UITableView!
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //step 3
        tableview.dataSource = self
        tableview.delegate = self
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data
            
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            self.tableview.reloadData()
            
            print(dataDictionary)
                
            
           }
        }
        task.resume()
    }
    
    
    //step 2 implement functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count //returns number of rows with movies.count
    }
    
    //function get called 50 times
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //for row, give a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        //casting title as a String
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
    
        
        
        
        cell.titleview.text = title
        cell.synopsisview.text = synopsis
        
        let base_url = "https://image.tmdb.org/t/p/w185"
        
        let posterpath = movie["poster_path"] as! String
        let posterURL = URL(string: base_url+posterpath)
        
        cell.posterView.af.setImage(withURL: posterURL!)
        
        //? is a swift optionals, like casting and creating a dictionary
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //get the new view controller using segue.destination
        //pass the selectd object to the new view controller
        print("Loading up details screen")
        
        //find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableview.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        //pass the selected movie to the details view controller
        //casting segue to movie detail view controller
        let detailViewController = segue.destination as! MovieDetailViewController
        
        detailViewController.movie = movie
        
        //when transitioning
        tableview.deselectRow(at: indexPath, animated: true)
    }


}

