//
//  TextFileCell.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 24/4/21.
//

import UIKit

class TextFileCell: UITableViewCell {
    static let TAG = String(describing: TextFileCell.self)
    
    @IBOutlet weak var tv_file_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setCell(_ file: FileObject) {
        tv_file_name.text = "\(file.getName())\(file.getFileType())"
    }
    
    public func selectRow() {
        self.accessoryType = .checkmark
    }
    
    public func deselectRow() {
        self.accessoryType = .none
    }
}
