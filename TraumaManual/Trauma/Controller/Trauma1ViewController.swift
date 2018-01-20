//
//  Trauma1ViewController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/17/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit
import Down

class Trauma1ViewController: UIViewController {
    
    var mdText: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let downView = try? DownView(frame: self.view.bounds, markdownString: mdText, templateBundle: Bundle.main) else { return }
        view.addSubview(downView)
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
