//
//  SafeActionsViewController.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/15/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit

class SafeActionsViewController: UIViewController {
    
    var pages : [View] {
        get {
            
            let page1: View = Bundle.main.loadNibNamed("View", owner: self, options: nil)?.first as! View
            page1.view.backgroundColor = UIColor.white
            page1.mainLabel.text = "Corona Virus Prevention!"
            page1.secondLabel.text = "Follow these steps by yourself!"
            page1.viewImage.image = UIImage(named: "all")
            
            
            let page2: View = Bundle.main.loadNibNamed("View", owner: self, options: nil)?.first as! View
            page2.view.backgroundColor = UIColor.white
            page2.mainLabel.text = "Wash your hands frequently!"
            page2.secondLabel.text = "The proper way to wash your hands"
            page2.viewImage.image = UIImage(named: "washhands")
            
            
            let page3: View = Bundle.main.loadNibNamed("View", owner: self, options: nil)?.first as! View
            page3.view.backgroundColor = UIColor.white
            page3.mainLabel.text = "Wearning Mask & Gloves!"
            page3.secondLabel.text = "The proper way to use Maks and Shields"
            page3.viewImage.image = UIImage(named: "wearmask")
            
            let page4: View = Bundle.main.loadNibNamed("View", owner: self, options: nil)?.first as! View
            page4.view.backgroundColor = UIColor.white
            page4.mainLabel.text = "Social Distance!"
            page4.secondLabel.text = "Keep the distance with other persons"
            page4.viewImage.image = UIImage(named: "socialdistance")
            
            let page5: View = Bundle.main.loadNibNamed("View", owner: self, options: nil)?.first as! View
            page5.view.backgroundColor = UIColor.white
            page5.mainLabel.text = "Stay Home!"
            page5.secondLabel.text = "Stay safe & helathy with your loved once at home"
            page5.viewImage.image = UIImage(named: "stayhome")
            
            
            return [page1, page2, page3, page4,page5]
        }
    }

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.bringSubviewToFront(pageControl)
        
        setupScrollView(pages: pages)
        
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
    }

        func setupScrollView(pages: [View]) {
            scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pages.count), height: view.frame.height)
            scrollView.isPagingEnabled = true
            
            for i in 0 ..< pages.count {
                pages[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
                scrollView.addSubview(pages[i])
            }
        }
    
    }

extension SafeActionsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}





