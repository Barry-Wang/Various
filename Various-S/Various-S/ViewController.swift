//
//  ViewController.swift
//  Various-S
//
//  Created by WangWei on 14/6/17.
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: YMTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "test");
        if (cell == nil) {
            
            cell = UITableViewCell(style: .default  , reuseIdentifier: "test")
            let button = YMButton(type:.custom)
            button.frame = CGRect(x: 40, y:0, width:100, height:44)
            button.backgroundColor = UIColor.red
            cell?.contentView .addSubview(button)
            button .addTarget(self, action: #selector(self.click), for: .touchUpInside)
        }
        
        cell?.textLabel?.text = "\(indexPath.row)"
        
        return cell!
    }
    
    func click() {
        print("被点击了");
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
    }
    
}

extension ViewController:UIScrollViewDelegate {
    
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//        print("start to scrolling")
//    }
//    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("Did end Decelerating")
//    }
}


