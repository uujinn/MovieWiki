//
//  HomeViewController.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/10.
//

import UIKit
import Tabman
import Pageboy

class TabViewController: TabmanViewController {

    let barTitle = ["홈", "검색", "마이 페이지"]
    
    private var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchViewController
        let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyPageVC") as! MyPageViewController
            
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.backgroundColor = .white
        bar.backgroundView.style = .blur(style: .extraLight)
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        
        bar.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
        }
        
        bar.indicator.weight = .medium
        bar.indicator.tintColor = .black
        addBar(bar, dataSource: self, at: .top)
    }
    

}

extension TabViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = barTitle[index]
        return TMBarItem(title: title)
    }
}
