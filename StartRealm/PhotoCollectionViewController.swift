//
//  PhotoCollectionViewController.swift
//  StartRealm
//
//  Created by Mijeong Jeon on 21/03/2017.
//  Copyright © 2017 Jo Seong Gyu. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //=====================================================//
        //                      Realm Init                    //
        //====================================================//
        
        
        //=====================================================//
        //               Realm Sort : 사진 최신 정렬              //
        //====================================================//
        
        
        //=====================================================//
        //             Realm Notification Token                //
        //====================================================//
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        alertToEditorDelete(selectedIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.frame.size.width - 10)/3
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    
    // MARK: 사진 추가
    @IBAction func addImage(_ sender: UIBarButtonItem) {
        let imagePickerView = UIImagePickerController()
        imagePickerView.delegate = self
        imagePickerView.sourceType = .photoLibrary
        
        self.present(imagePickerView, animated: true) { }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //=====================================================//
        //              Realm Write : 사진 추가                 //
        //====================================================//

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 사진 삭제
    func alertToEditorDelete(selectedIndexPath: IndexPath) {
        //=====================================================//
        //              Realm Delete : 삭제 삭제                 //
        //====================================================//

    }
}
