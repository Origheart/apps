//
//  ViewController.swift
//  UnwindSegue
//
//  Created by 刘康 on 16/8/18.
//  Copyright © 2016年 刘康. All rights reserved.
//

import UIKit

//class ViewController: UIViewController {
//
//    @IBOutlet weak var label: UILabel!
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let identifier = segue.identifier where identifier == "ShowAnimalPicker" {
//            if let pickerVC = (segue.destinationViewController as? UINavigationController)?.topViewController as? AnimalPickerViewController{
//                pickerVC.delegate = self
//            }
//        }
//    }
//}
//
//extension ViewController: AnimalPickerViewControllerDelegate {
//    func animalPicker(picker: AnimalPickerViewController, didSelectAnimal animal: String) {
//        label.text = animal
//    }
//}

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func performUnwindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == AnimalPickerViewController.UnwindSegue {
            label.text = (segue.sourceViewController as! AnimalPickerViewController).selectedAnimal
        }
    }
}