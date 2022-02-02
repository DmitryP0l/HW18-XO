//
//  ViewController.swift
//  HW18-XO
//
//  Created by lion on 19.11.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    //массив по энаму с пустыми ячейками
    private var symbolArray: [XO] = [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty]
    // сет "ячеек"
    private var emptyCellsSet: Set = [0, 1, 2, 3, 4, 5, 6, 7, 8]
   
    
    // получаем рандомный элемент, для хода компа
    func setRandomIndex() -> Int? {
        guard let randomElement = emptyCellsSet.randomElement() else {return nil}
        emptyCellsSet.remove(randomElement)
        return randomElement
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName:"MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return symbolArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as? MyCollectionViewCell  else {return UICollectionViewCell()}
        cell.symbolLabel.text = symbolArray[indexPath.row].rawValue
        return cell
    }
    
    
    
    // pressed. надо добавить в выбранную ячейку рандом из SymbolArray
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        symbolArray[indexPath.row] = .x
        //symbolArray[indexPath.row] = randomXO()
        // удаляем число из сета для хода компа
        emptyCellsSet.remove(indexPath.row)
        // ходит комп
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            
            if let randomIndex = self?.setRandomIndex() {
    //            symbolArray[randomIndex] = randomXO()
                self?.symbolArray[randomIndex] = .o
                collectionView.reloadData()
            }
        }
        
        collectionView.reloadData()
//        if let setRandom = setRandomIndex() {
//            symbolArray[setRandom] = .x
//            collectionView.reloadData()
//        }
    }
    
    func randomXO() -> XO {
        let XOArray: [XO] = [.o, .x]
        guard let random = XOArray.randomElement() else {return .empty}
        return random
    }
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGFloat(collectionView.frame.width / 3.2)
            return CGSize(width: size, height: size)
    }
}






extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given object:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}


// MARK: - enum
enum XO: String {
    case x = "X"
    case o = "O"
    case empty = ""
}

