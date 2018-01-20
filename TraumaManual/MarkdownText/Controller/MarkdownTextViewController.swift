//
//  MarkdownTextViewController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/14/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit
import Down

class MarkdownTextViewController: UIViewController {
    
    var mditem: MarkdownText!
    
    var bookmarkItem: UIBarButtonItem!
    
    var numberedTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let downView = try? DownView(frame: self.view.frame, markdownString: mditem.mdText, didLoadSuccessfully: nil) else { return }
        view.addSubview(downView)
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        
        if TraumaModel.shared.isBookmark(title: self.numberedTitle) {
            self.bookmarkItem = UIBarButtonItem(image: UIImage(named: "bookmark_filled"), style: .plain, target: self, action: #selector(bookmarkAction(_:)))
        } else {
            self.bookmarkItem = UIBarButtonItem(image: UIImage(named: "bookmark"), style: .plain, target: self, action: #selector(bookmarkAction(_:)))
        }
        self.navigationItem.rightBarButtonItem = self.bookmarkItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        TraumaModel.shared.addRecentlyViewed(title: self.numberedTitle, object: mditem)
    }
    
    @objc func bookmarkAction(_: Any) {
        if let title = self.numberedTitle {
            if TraumaModel.shared.isBookmark(title: title) {
                TraumaModel.shared.removeBookmark(title: title)
                self.bookmarkItem = UIBarButtonItem(image: UIImage(named: "bookmark"), style: .plain, target: self, action: #selector(bookmarkAction(_:)))
            } else {
                TraumaModel.shared.addBookmark(title: title, object: self.mditem)
                self.bookmarkItem = UIBarButtonItem(image: UIImage(named: "bookmark_filled"), style: .plain, target: self, action: #selector(bookmarkAction(_:)))
            }
            self.navigationItem.rightBarButtonItem = self.bookmarkItem
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
