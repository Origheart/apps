//
//  AnimalPickerViewController.swift
//  UnwindSegue
//
//  Created by 刘康 on 16/8/18.
//  Copyright © 2016年 刘康. All rights reserved.
//

import UIKit

//protocol AnimalPickerViewControllerDelegate: class {
//    func animalPicker(picker: AnimalPickerViewController, didSelectAnimal animal: String)
//}
//
//class AnimalPickerViewController: UIViewController {
//    weak var delegate: AnimalPickerViewControllerDelegate?
//    
//    @IBAction func tap(sender: UIButton) {
//        selectAnimal(sender.currentTitle)
//    }
//    
//    private func selectAnimal(animal: String!) {
//        delegate?.animalPicker(self, didSelectAnimal: animal)
//        dismissViewControllerAnimated(true, completion: nil)
//    }
//}


class AnimalPickerViewController: UIViewController {
    static let UnwindSegue = "UnwindAnimalPicker"
    private(set) var selectedAnimal: String!
    
    @IBAction func tap(sender: UIButton) {
        selectAnimal(sender.currentTitle)
    }
    
    private func selectAnimal(animal: String!) {
        selectedAnimal = animal
        performSegueWithIdentifier(AnimalPickerViewController.UnwindSegue, sender: nil)
    }
}