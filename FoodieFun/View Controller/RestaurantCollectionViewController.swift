//
//  RestaurantCollectionViewController.swift
//  FoodieFun
//
//  Created by William Chen on 9/25/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "RestaurantCell"

class RestaurantCollectionViewController: UICollectionViewController {
    
    let restuarantController = RestaurantController()
    
    lazy var fetchRequestController: NSFetchedResultsController<Restaurant> = {
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "<#T##String?#>", ascending: true)]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreDataStack.shared.mainContext,
                                             sectionNameKeyPath: "<#T##String?#>",
                                             cacheName: nil)
        
        frc.delegate = self as? NSFetchedResultsControllerDelegate
        
        do {
            try frc.performFetch()
        } catch {
            fatalError("Error perfoming fetch for frc: \(error)")
        }
        
        return frc

    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            collectionView.reloadData()
    }
    
    @IBAction func addRestaurantTapped(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchRequestController.sections?.count ?? 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return fetchRequestController.sections?[section].numberOfObjects ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as?
        RestaurantCollectionViewCell else { return UICollectionViewCell() }
    
        let restuarant = fetchRequestController.object(at: indexPath)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


