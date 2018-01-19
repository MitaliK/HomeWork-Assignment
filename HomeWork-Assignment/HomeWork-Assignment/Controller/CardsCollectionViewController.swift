//
//  CardsCollectionViewController.swift
//  HomeWork-Assignment
//
//  Created by Mitali Kulkarni on 19/01/18.
//  Copyright © 2018 Mitali Kulkarni. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CardsCollectionViewController: UICollectionViewController {

    let objectURL = "https://s3-us-west-2.amazonaws.com/udacity-mobile-interview/CardData.json"
    var cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        // call API
        getIndividualCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - JSON Parse
    func getIndividualCards() {
        guard let objectURL = URL(string: objectURL) else { return }
        
        let task = URLSession.shared.dataTask(with: objectURL) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            // ParseJSON data
            if let data = data {
                self.cards = self.parseJsonData(data: data)
                
                // reload collection view
                OperationQueue.main.addOperation {
                    self.collectionView?.reloadData()
                }
            }
        }
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Card] {
        var cardArray = [Card]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: AnyObject]]

            // Parse Json data
            if let jsonCards = jsonResult {
                
                for individualCard in jsonCards {
                    let card = Card()
                    
                    if let firstName = individualCard["firstName"] as? String {
                        card.firstName = firstName
                    }
                    if let lastName = individualCard["lastName"] as? String {
                       card.lastName = lastName
                    }
                    if let bio = individualCard["bio"] as? String{
                        card.bio = bio
                    }
                    if let company = individualCard["company"] as? String{
                        card.company = company
                    }
                    if let email = individualCard["email"] as? String{
                        card.email = email
                    }
                    if let startDate = individualCard["startDate"] as? String{
                       card.startDate = startDate
                    }
                    if let avatarURL = individualCard["avatar"]  as? String{
                        card.avatarURL = avatarURL
                    }
                    
                    cardArray.append(card)
                }
            }
        } catch {
            print(error)
        }
        
        return cardArray
    }


    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.cards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardsCollectionViewCell
    
        // Configure the cell
        cell.nameLabel.text = cards[indexPath.row].firstName + " " + cards[indexPath.row].lastName
        cell.companyLabel.text = cards[indexPath.row].company
        cell.bioLabel.text = cards[indexPath.row].bio
        cell.emailLabel.text = cards[indexPath.row].email
        cell.startDateLabel.text = cards[indexPath.row].startDate
        cell.avatarImageView.setImageFromURl(stringImageUrl: cards[indexPath.row].avatarURL)
        return cell
    }
}
