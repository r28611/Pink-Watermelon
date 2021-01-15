//
//  PhotoSceneViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 15.01.2021.
//

import UIKit

class PhotoViewController: UIViewController {

    var chosenPhoto: UIImage?
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likeControl: LikeControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let photo = chosenPhoto {
            image.image = photo
        }
        
    }
    
    @IBAction func didDoubleTapOnImage(_ sender: UITapGestureRecognizer) {
        likeControl.isLiked.toggle()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
