//
//  ViewController.swift
//  jsonParsingExample
//
//  Created by erhan demirci on 24.02.2022.
//

import UIKit
import SwiftUI
import Alamofire
/*
enum Error: Swift.Error {
    case requestFailed
}
 https://api.themoviedb.org/3/movie/popular?&language=en-US&api_key=8c0394f0747bfda19eeca5e83186466b&page=1
*/
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data:NewsFeed!=NewsFeed(s: "as", t: 2, a: "sdsd")
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        guard let articles=self.data.articles else {
            return 0
        }
        return articles.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

             // cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        
        guard let articles=data.articles else {
            return UITableViewCell(frame: .zero)
        }
        cell.textLabel?.text=articles[indexPath.row].title

                return cell
        /*
        */
       
        
    }
    
    
    
    
  
    
    
    let apiKey:String="5dd3ff09d32841fbb693021b3fe02850"
    let baseUrlString:String="https://newsapi.org/v2/everything"
    let fullUrlString:String="https://newsapi.org/v2/everything?q=tesla&from=2022-01-27&sortBy=publishedAt&apiKey=5dd3ff09d32841fbb693021b3fe02850"
    var dataDictionary:NSDictionary!=[:]

    func getPopularMovies() {
        
        let request = Request(requestURL:fullUrlString)
        ServiceAPI.shared.callService(request: request, response: NewsFeed.self) { (result) in
            
            switch result {
            case .success(let response):
                print(response.articles?[0].author)
                break
            // print(response)
              
            case .failure(_):
                print("failure")
                break
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        
     
        // Do any additional setup after loading the view.
  //  getPopularMovies()
       
        let parameters: [String: String] = ["search": "erhan"]
        AF.request(fullUrlString).validate()
          .responseDecodable(of: NewsFeed.self) { response in
              switch response.result {
              case .success(let board):
                 
                  guard let result=board.totalResults else { return }
                  print("totalResults is \(result)") // New York Highlights
                  print(board.articles?[0].title)
                  self.data=board
                 self.tableView.reloadData()
                  
                  
              case .failure(let error):
                  print("Board creation failed with error: \(error.localizedDescription)")
              }
        }
         
        /*

        var request = URLRequest(url: URL(string: fullUrlString)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
                
            guard let data = data else {
                //.failure(error ) as? Error
                return
            }
           // debugPrint("convertedJsonIntoDict",self.convertJsonDataToDict(data: data) ?? "nil")
            self.dataDictionary=self.convertJsonDataToDict(data: data)
            let result = Result {
                try JSONDecoder().decode(NewsFeed.self, from: data)
            }
            //print("asa",Result<NewsFeed, Error>.success)
           // self.data=Result<NewsFeed, Error>.success
            
            
            

        }
        task.resume()
      
         */
        

    }
    func convertJsonDataToDict(data: Data?) -> NSDictionary? {
        
        guard let data = data else {
            return nil
        }
        do {
            if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                return convertedJsonIntoDict
            }
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    


}

