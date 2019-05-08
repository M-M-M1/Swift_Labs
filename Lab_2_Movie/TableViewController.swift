//
//  TableViewController.swift
//  Lab_2_Movie
//
//  Created by Mostafa on 5/2/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import UIKit
import SDWebImage
import Reachability
import CoreData

class TableViewController: UITableViewController,newMovDel {
    func newMovie(movie: Movie) {
        Movies.append(movie)
        self.tableView.reloadData()
    }
    
    @IBAction func newBtn(_ sender: Any) {
        let NVC = self.storyboard?.instantiateViewController(withIdentifier: "NVC") as? NewViewController
        NVC?.newD = self
        self.navigationController?.pushViewController(NVC!, animated: true)
    }
    
//    var movie1 = Movie()
//    var movie2 = Movie()
//    var movie3 = Movie()
    var Movies:Array<Movie> = []
    
//    var Movies:Array<Dictionary<String,Any>> = []

    override func viewDidLoad() {
        super.viewDidLoad()

//        movie1.title = "movie1"
//        movie1.image = "1.jpg"
//        movie1.rating = 8.8
//        movie1.releaseYear = 2018
//        movie1.genre = ["action","drama"]
//
//        movie2.title = "movie2"
//        movie2.image = "2.jpg"
//        movie2.rating = 9.7
//        movie2.releaseYear = 2017
//        movie2.genre = ["action","romance"]
//
//        movie3.title = "movie3"
//        movie3.image = "3.jpg"
//        movie3.rating = 6.8
//        movie3.releaseYear = 2019
//        movie3.genre = ["action","drama"]
//
//        Movies.append(movie1)
//        Movies.append(movie2)
//        Movies.append(movie3)
        
        
        let reachability = Reachability()!
        if reachability.connection != .none {
                    print("there is network")
                    //1
                    let url:URL? = URL.init(string: "https://api.androidhive.info/json/movies.json?fbclid=IwAR2GK9vqVJReno9zh58tGeBJwvk_nVOmX-80tYOwyBRM1sNiOYVoBxouofU")
            
                    //2
                    let request:URLRequest = URLRequest.init(url: url!)
            
                    //3
                    let session:URLSession = URLSession.init(configuration: URLSessionConfiguration.default)
            
                    //4
                    let task = session.dataTask(with: request) { (data, response, error) in
                        do{
                            var json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Array<Dictionary<String,Any>>
            //                print(json!)
                            
                            for mv in json! {
                                let movie = Movie()
                                movie.title = mv["title"] as! String
                                movie.rating = Float(truncating: mv["rating"] as! NSNumber)
                                movie.releaseYear = Int(truncating: mv["releaseYear"] as! NSNumber)
                                movie.image = mv["image"] as! String
                                movie.genre = mv["genre"] as! Array<String>
                                self.Movies.append(movie)
                            }
                            
                            DispatchQueue.main.async {
//                                self.Movies = json!
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                let CDH = CoreDataHandeler(appDelegate: appDelegate)
                                CDH.deleteAllData(entity: "Movie")
                                CDH.deleteAllData(entity: "Genre")
                                CDH.saveCore(movies: self.Movies)
                                self.tableView.reloadData()
                            }
                        }catch let err{
                            print(err)
                        }
                    }
                    //5
                    task.resume()
        } else {
            print("no network")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let CDH = CoreDataHandeler(appDelegate: appDelegate)
            self.Movies = CDH.fetchCore()
            self.tableView.reloadData()
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = Movies[indexPath.row].title
        cell.imageView?.sd_setImage(with: URL(string: (Movies[indexPath.row].image)), placeholderImage: UIImage(named: "2.jpg"))
//        cell.imageView?.image = UIImage.init(named: Movies[indexPath.row].image)
//        cell.textLabel?.text = Movies[indexPath.row]["title"] as! String
//        cell.imageView?.sd_setImage(with: URL(string: (Movies[indexPath.row]["image"] as! String)), placeholderImage: UIImage(named: "2.jpg"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var SVC = self.storyboard?.instantiateViewController(withIdentifier: "SVC") as? SecViewController
        SVC?.movie = Movies[indexPath.row]
//        let movie = Movie()
//        movie.title = Movies[indexPath.row]["title"] as! String
//        movie.rating = Float(truncating: Movies[indexPath.row]["rating"] as! NSNumber)
//        movie.releaseYear = Int(Movies[indexPath.row]["releaseYear"] as! NSNumber)
//        movie.image = Movies[indexPath.row]["image"] as! String
//        movie.genre = Movies[indexPath.row]["genre"] as! Array<String>
//        SVC?.movie = movie
        self.navigationController?.pushViewController(SVC!, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
