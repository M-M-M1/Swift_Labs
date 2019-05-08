//
//  SecViewController.swift
//  Lab_2_Movie
//
//  Created by Mostafa on 5/2/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import UIKit
import SDWebImage
class SecViewController: UIViewController {

    
    @IBOutlet weak var titleT: UILabel!
    @IBOutlet weak var ratingT: UILabel!
    @IBOutlet weak var releaseT: UILabel!
    @IBOutlet weak var genreT: UITextView!
    @IBOutlet weak var imgV: UIImageView!
    
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleT.text = movie!.title
        ratingT.text = "\(movie!.rating)"
        releaseT.text = "\(movie!.releaseYear)"
        genreT.text = "\(movie!.genre)"
//        imgV.image = UIImage.init(named: movie!.image)
        imgV.sd_setImage(with: URL(string: movie!.image), placeholderImage: UIImage(named: "2.jpg"))
        
    }
    @objc func changeSc(){
        self.dismiss(animated: true, completion: nil)
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
