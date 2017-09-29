//
//  CollectionViewController.swift
//  MyName
//
//  Created by Surendra Singh on 9/29/17.
//  Copyright © 2017 Surendra Singh. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var viewModel: VideoViewModel?
    var videos =  [Video]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel = VideoViewModel()
        viewModel?.videoDelegate = self
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 160, height: 200)        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func performSearch(_ sender: UIButton) {
        self.activityIndicator.startAnimating()
        self.viewModel?.getVideoData(text: self.searchTextField.text!)
    }
    
}

// MARK: UITextFieldDelegate method implementation

extension CollectionViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.activityIndicator.startAnimating()
        self.viewModel?.getVideoData(text: textField.text!)
        return true
    }
}
// MARK: VideoProtocol method implementation

extension CollectionViewController:VideoProtocol{
    
    func resetTableData(videos:[Video]){
        self.videos = videos
        self.collectionView.reloadData()
        self.activityIndicator.stopAnimating()
    }
}
// MARK: UITableView method implementation
extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCellVideo",
                                                      for: indexPath as IndexPath) as! YouTubeViewCell
        
        let video = self.videos[indexPath.row]
        cell.titleLabel.text = video.title
        cell.imageView.image = UIImage(data: try! Data(contentsOf: URL(string: (video.thumbnail))!))
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = self.videos[indexPath.row]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let playerController = storyBoard.instantiateViewController(withIdentifier: "playerController") as! VideoPlayerViewController;
        playerController.video = video
        self.navigationController?.pushViewController(playerController, animated: true)
    }
}


