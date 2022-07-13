//
//  NewsViewController.swift
//  MinionTeam
//
//  Created by MacBook on 22.05.2022.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let serviceVK = ServiceVK()
    
    var news: [News] = [] {
        didSet {
            for item in news {
                print(item.newsDate)
            }
            tableView.reloadData()
        }
    }
    
    var groups: [Int: Group] = [:] {
        didSet {
            print(groups)
        }
    }
    var friends: [Int: Friend] = [:] {
        didSet {
            print(friends)
        }
    }
    
    @IBOutlet var tableView: UITableView!

//    let likeCounterIdentifier = "LikeCounterView"
//
//    var newsImages = [UIImage]()
//    var newsTexts = [String]()
    
    // MARK: - Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

//        fillNewsImages()
//        fillNewsTexts()
        
        serviceVK.getNews(method: .news) { news, groups, friends in
            self.news = news
            self.friends = friends
            self.groups = groups
        }
        
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        
        title = "News"
    }
    
//    // MARK: - Filling methods
//    private func fillNewsImages() {
//        let nakedImage = UIImage(named: "naked")!
//        let scooterImage = UIImage(named: "scooter")!
//        let selfieImage = UIImage(named: "selfie")!
//
//        newsImages.append(nakedImage)
//        newsImages.append(scooterImage)
//        newsImages.append(selfieImage)
//    }
//
//    private func fillNewsTexts() {
//        let nakedText = """
//Torrential rains have been pouring down all week. The minions have no dry clothes anymore.
//"""
//        let scooterText = """
//Getting an adult electric scooter could be for various reasons. They are easy to learn and perfect, easy to assemble and offers great mobility. Other than that, these fun rides are perfect for any age.
//"""
//        let selfieText = """
//Download the perfect selfie pictures. Find over 100+ of the best free selfie images. Free for commercial use No attribution required Copyright-free.
//"""
//        newsTexts.append(nakedText)
//        newsTexts.append(scooterText)
//        newsTexts.append(selfieText)
//    }
//
    // MARK: - Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
//        cell.newsTitle.text = "The most important news"
//        cell.newsText.text = newsTexts[indexPath.row]
//        cell.newsImage.image = newsImages[indexPath.row]
        
        let news = news[indexPath.row]
        cell.configure(news: news, groups: groups)
        
        return cell
    }

}
