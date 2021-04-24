//
//  AnalysisResultView.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 24/4/21.
//

import UIKit

class AnalysisResultView: UIViewController {
    
    @IBOutlet weak var tv_total_words: UILabel!
    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var bt_filter: UIButton!
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var bt_select_file: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: PRIVATE FUNCTIONS
    private func configureView() {
        bt_select_file.clipsToBounds = true
        bt_select_file.layer.cornerRadius = 20
    }
    
    // MARK: PUBLIC FUNCTIONS
    @IBAction func selectFile(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AnalysisResultView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
        
        // return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordCountCell.TAG, for: indexPath) as? WordCountCell else {
            fatalError("The dequeued cell is not an instance of WordCountCell.")
        }
        
        cell.setCell(word: "Word", count: 80)
        cell.selectionStyle = .none
        
        return cell
        
    }
}
