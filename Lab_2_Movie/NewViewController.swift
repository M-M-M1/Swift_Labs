//
//  NewViewController.swift
//  Lab_2_Movie
//
//  Created by Mostafa on 5/2/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import UIKit

class NewViewController: UIViewController,imgDel{
    func imgDel(txt:String) {
        imgF.text = txt
    }
    

    var newD:newMovDel?
    
    @IBOutlet weak var titleF: UITextField!
    @IBOutlet weak var rateF: UITextField!
    @IBOutlet weak var releaseF: UITextField!
    @IBOutlet weak var genreF: UITextField!
    @IBOutlet weak var imgF: UILabel!
    
    @IBAction func imgBtn(_ sender: Any) {
        let ITVC:ImgTableViewController! = self.storyboard?.instantiateViewController(withIdentifier: "ITVC") as? ImgTableViewController
        ITVC.imgD = self
        self.navigationController?.pushViewController(ITVC, animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let movie = Movie()
        movie.title = titleF.text!
        movie.rating = Float(rateF.text!)!
        movie.releaseYear = Int(releaseF.text!)!
        movie.genre.append(genreF.text!)
        movie.image = imgF.text!
        newD?.newMovie(movie: movie)
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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


