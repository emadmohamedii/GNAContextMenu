//
//  Created by Kateryna Gridina.
//  Copyright (c) gridNA. All rights reserved.
//  Latest version can be found at https://github.com/gridNA/GNAContextMenu
//

import UIKit
import GNAContextMenu

class ViewController: UIViewController, GNAMenuItemDelegate, UITableViewDelegate, UITableViewDataSource {

    var table: UITableView!
    var menuView: GNAMenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        createMenuItem()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        cell.textLabel?.text = "Some title"
        return cell
    }
    
    @objc private func handleLongPress(gesture: UILongPressGestureRecognizer) {
        let point = gesture.location(in: table)
        if let indexPath = table.indexPathForRow(at: point) {
            menuView.additionalInfo = ["cellPath": indexPath as NSIndexPath]
        }
        menuView.handleGesture(gesture, inView: table)
    }
    
    private func setupTable() {
        table = UITableView()
        table.frame = view.bounds
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(ViewController.handleLongPress)))
    }
    
    private func createMenuItem() {
        let customItem = GNAMenuItem(icon: UIImage(named: "shopingCart_inactive")!, activeIcon: UIImage(named: "shopingCart"), title: "Shop it")
        customItem.changeTitle(withTitle: "ttt")
        customItem.changeActiveIcon(withIcon: UIImage(named: "defaultImage")!)
        customItem.changeIcon(withIcon: UIImage(named: "wishlist_inacitve")!)
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 60))
        titleView.backgroundColor = .red
        let titleLabel = UILabel(frame: .zero)
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: 1)
        customItem.changeTitleView(withView: titleView)
        customItem.changeTitleLabel(withLabel: titleLabel)
        menuView = GNAMenuView(touchPointSize: CGSize(width: 80, height: 80), touchImage: UIImage(named: "defaultImage"), menuItems: [
                        customItem,
                        GNAMenuItem(icon: UIImage(named: "wishlist_inacitve")!, activeIcon: UIImage(named: "wishlist"), title: "Wish"),
                        GNAMenuItem(icon: UIImage(named: "wishlist_inacitve")!, activeIcon: UIImage(named: "wishlist"), title: "Wish")
            ])
        menuView.delegate = self
    }
    
    private func menuItemWasPressed(menuItem: GNAMenuItem, info: [String: AnyObject]?) {
        let indexPath = info!["cellPath"] as? NSIndexPath
        print("\(indexPath)")
    }
}

