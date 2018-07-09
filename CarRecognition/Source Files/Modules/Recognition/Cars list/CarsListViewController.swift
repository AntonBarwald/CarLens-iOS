//
//  CarsListViewController.swift
//  CarRecognition
//


import UIKit

internal final class CarsListViewController: TypedViewController<CarsListView>, UICollectionViewDataSource {
    
    /// Enum describing events that can be triggered by this controller
    ///
    /// - didTapDismiss: send when user want to dismiss the view
    enum Event {
        case didTapDismiss
    }
    
    /// Callback with triggered event
    var eventTriggered: ((Event) -> ())?
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.collectionView.dataSource = self
        customView.collectionView.register(cell: CarListCollectionViewCell.self)
        customView.recognizeButton.addTarget(self, action: #selector(recognizeButtonTapAction), for: .touchUpInside)
    }
    
    @objc private func recognizeButtonTapAction() {
        eventTriggered?(.didTapDismiss)
    }
    
    /// SeeAlso: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: Replace with the real number
        return 8
    }
    
    /// SeeAlso: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CarListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else {
            return UICollectionViewCell()
        }
        // TODO: Replace with getting the element from the model
        cell.setup(with: Car(label: "volkswagen passat")!)
        
        return cell
    }
}
