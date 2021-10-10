//
//  HomeViewController.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/10.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, CollectionViewCellDelegate{
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    func collectionView(collectionviewcell: MovieCell?, index: Int, didTappedInTableViewCell: TableViewTitleCell) {
        
        let movieModel = MovieModel.shared
        movieModel.index = index
        
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
//
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: false)
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewTitleCell") as? TableViewTitleCell else{
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "인기"
            break
        case 1:
            cell.titleLabel.text = "현재 상영 중"
            break
        case 2:
            cell.titleLabel.text = "최신 개봉작"
            break

        default:
            print("없음")
            break
        }

        cell.cellDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 282
    }
    
    private func setupTableView(){
            // Register the xib for tableview cell
            tableView.delegate = self
            tableView.dataSource = self
            // #1
            let cell = UINib(nibName: "TableViewTitleCell", bundle: nil)
            self.tableView.register(cell, forCellReuseIdentifier: "TableViewTitleCell")
            // #2 #3
        /*
            let newsLetterCellNib = UINib(nibName: "NewsLetterCell", bundle: nil)
            self.tableView.register(newsLetterCellNib, forCellReuseIdentifier: "NewsLetterCell")
            // #4
            let categoryCellNib = UINib(nibName: "CategoryCell", bundle: nil)
            self.tableView.register(categoryCellNib, forCellReuseIdentifier: "CategoryCell")*/
    }
    
}

