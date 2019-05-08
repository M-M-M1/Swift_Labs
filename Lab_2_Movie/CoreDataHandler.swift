//
//  CoreDataHandler.swift
//  Lab_2_Movie
//
//  Created by Mostafa on 5/4/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHandeler{
    let appDelegate:AppDelegate?
    
    init(appDelegate:AppDelegate?){
        self.appDelegate = appDelegate
    }
    
    func saveCore(movies:Array<Movie>){
        //2
        let managedContext = self.appDelegate?.persistentContainer.viewContext
        //3
        let entity1 = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext!)
        let entity2 = NSEntityDescription.entity(forEntityName: "Genre", in: managedContext!)
        for mv in movies {
            //4
            let movie = NSManagedObject(entity: entity1!, insertInto: managedContext!)
            //5
            movie.setValue(mv.title, forKeyPath: "title")
            movie.setValue(mv.image, forKeyPath: "image")
            movie.setValue(mv.rating, forKeyPath: "rating")
            movie.setValue(mv.releaseYear, forKeyPath: "releaseYear")
            movie.setValue(Date(), forKey: "date")
            
            for gr in mv.genre{
                let genre = NSManagedObject(entity: entity2!, insertInto: managedContext!)
                
                genre.setValue(gr, forKeyPath: "genre")

                
//                movie.setValue(NSSet(object: genre), forKey: "genre")
                // Add Genres to movie
                let genres = movie.mutableSetValue(forKey: "genre")
                genres.add(genre)
            }
        }
        //6
        do{
            try managedContext!.save()
        }catch let error{
            print(error)
        }
    }
    
    func fetchCore()->Array<Movie>{
        let managedContext = self.appDelegate!.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        
        let dateSort = NSSortDescriptor(key:"date", ascending:true)
        fetchRequest.sortDescriptors = [dateSort]
        
        var movies:Array<Movie> = []
        // Execute Fetch Request
        do {
            let results = try managedContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
            
            for mv in results {
                let movie = Movie()
                movie.title = mv.value(forKey: "title") as! String
                movie.rating = mv.value(forKey: "rating") as! Float
                movie.releaseYear = mv.value(forKey: "releaseYear") as! Int
                movie.image = mv.value(forKey: "image") as! String
                let records = mv.mutableSetValue(forKey: "Genre")
    
                for record in records {
                    movie.genre.append((record as AnyObject).value(forKey: "genre") as! String)
                }
               
                movies.append(movie)
            }
        } catch let error {
            print(error)
        }
        return movies
    }
    
    func deleteAllData(entity: String)
    {
        let managedContext = self.appDelegate!.persistentContainer.viewContext
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try managedContext.execute(DelAllReqVar) }
        catch { print(error) }
    }
}
