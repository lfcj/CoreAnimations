import UIKit

protocol GenericPickerItem: AnyObject {
    var title: String { get }
    var pickerSubtitle: String { get }
}

//final class PickerViewController<E: GenericPickerItem>: UIViewController {
//
//    // MARK: - Properties
//
//    private let items: [E]
//    private let selectedItem: E?
//    private lazy var tableView = makeTableView()
//
//    // MARK: - Init/Deinit
//
//    init(items: [E], selectedItem: E?) {
//        self.items = items
//        self.selectedItem = selectedItem
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Configuring Views
//    func makeTableView() -> UITableView {
//        let tableView = UITableView()
//        
//    }
//
//}
