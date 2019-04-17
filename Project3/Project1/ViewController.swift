//
//  ViewController.swift
//  Project3
//
//  Created by Falmer nightprowler Fahey on 11/04/2019.
//  Copyright © 2019 School21. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

	var pictures = [String]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
	
		title = "Storm Viewer"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		performSelector(inBackground: #selector(loadData), with: nil)
		
    }
	
	@objc func loadData() {
		let fm = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try! fm.contentsOfDirectory(atPath: path)
		for item in items {
			if item.hasPrefix("nssl") {
				pictures.append(item)
			}
		}
		pictures.sort()
		tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pictures.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
		cell.textLabel?.text = pictures[indexPath.row]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
			vc.selectedImage = pictures[indexPath.row]
			vc.imagesCount = pictures.count
			vc.imageNumber = indexPath.row + 1
			navigationController?.pushViewController(vc, animated: true)
		}
	}
	
}


