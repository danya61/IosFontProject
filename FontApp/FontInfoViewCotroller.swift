//
//  FontInfoViewCotroller.swift
//  FontApp
//
//  Created by Danya on 20.08.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

class FontInfoViewCotroller: UIViewController {

    var font : UIFont!
    var favorite : Bool = false
    @IBOutlet weak var fontSampleLable: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var fontSizeLable: UILabel!
    @IBOutlet weak var favoriteSwitch : UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fontSampleLable.font = font
        fontSampleLable.text = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVv" + "WwXxYyZz 0123456789"
        fontSizeSlider.value = Float(font.pointSize)
        fontSizeLable.text = "\(Int(font.pointSize))"
        favoriteSwitch.on = favorite
    }
    
    @IBAction func slideFontSize(slider: UISlider){
        let newSize = roundf(slider.value)
        fontSampleLable.font = font.fontWithSize(CGFloat(newSize))
        fontSizeLable.text = "\(Int(newSize))"
    }
    
    @IBAction func toggleFavorite(sender: UISwitch){
        let favoritesList = FavoritesList.sharedFavoriteList
        if sender.on{
            favoritesList.addFavorite(font.fontName)
        } else {
            favoritesList.removeFvorite(font.fontName)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
