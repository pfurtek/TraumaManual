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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let downView = try? DownView(frame: self.view.bounds, markdownString: mditem.mdText, didLoadSuccessfully: {print("mkdown loaded")}) else { return }
        view.addSubview(downView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
