//
//  ImageDataSource.swift
//  ListLoader
//
//  Created by Eslam Shaker on 31/07/2022.
//

import UIKit
import RxDataSources

struct TableViewItem {
    let image: Image
    
    init(image: Image) {
        self.image = image
    }
}

struct TableViewSection {
    let items: [TableViewItem]
    
    init(items: [TableViewItem]) {
        self.items = items
    }
}

extension TableViewSection: SectionModelType {
    typealias Item = TableViewItem
    
    init(original: Self, items: [Self.Item]) {
        self = original
    }
}

struct ImageDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<TableViewSection> {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDetailsCell", for: indexPath) as! ImageDetailsCell
                cell.image = item.image
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsCell", for: indexPath) as! UserDetailsCell
                cell.image = item.image
                return cell
            default:
                return UITableViewCell()
            }
        })
    }
}
