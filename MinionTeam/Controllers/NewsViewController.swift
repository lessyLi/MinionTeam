//
//  NewsViewController.swift
//  MinionTeam
//
//  Created by MacBook on 22.05.2022.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    let likeCounterIdentifier = "LikeCounterView"
    
    var newsImages = [UIImage]()
    var newsTexts = [String]()
    
    private func fillNewsImages() {
        let nakedImage = UIImage(named: "naked")!
        let scooterImage = UIImage(named: "scooter")!
        let selfieImage = UIImage(named: "selfie")!
        
        newsImages.append(nakedImage)
        newsImages.append(scooterImage)
        newsImages.append(selfieImage)
    }
    private func fillNewsTexts() {
        let nakedText = """
Torrential rains have been pouring down all week. The minions have no dry clothes anymore.
"""
        let scooterText = """
Getting an adult electric scooter could be for various reasons. They are easy to learn and perfect, easy to assemble and offers great mobility. Other than that, these fun rides are perfect for any age.
"""
        let selfieText = """
Download the perfect selfie pictures. Find over 100+ of the best free selfie images. Free for commercial use No attribution required Copyright-free.
"""
        
        newsTexts.append(nakedText)
        newsTexts.append(scooterText)
        newsTexts.append(selfieText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillNewsImages()
        fillNewsTexts()
        
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        
        title = "News"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        cell.newsTitle.text = "The most important news"
        cell.newsText.text = newsTexts[indexPath.row]
        cell.newsImage.image = newsImages[indexPath.row]
        return cell
    }

}
