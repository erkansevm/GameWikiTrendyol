//
//  InformationCustomView.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 18.07.2022.
//

import UIKit

class InformationCustomView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func subViewXibInit(name: String, value: String){
        nameLabel.text = name
        valueLabel.text = value
    }
   

}
