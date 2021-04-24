//
//  WordCountCell.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 24/4/21.
//

import UIKit

class WordCountCell: UITableViewCell {
    static let TAG = String(describing: WordCountCell.self)
    
    @IBOutlet weak var tv_word: UILabel!
    @IBOutlet weak var tv_count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setCell(word: String, count: Int) {
        tv_word.text = word
        tv_count.text = String(count)
    }
}
