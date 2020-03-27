

import UIKit
import CoreData

class HomeViewModel: ViewModel {
    
    var readableThoughts: [Thought] = []
    private var allThoughts: [Thought] = []
    private var allTopics: [Orbit] = []
    unowned var delegate: ViewModelDelegate!
    unowned var moc: NSManagedObjectContext
    var dataType: PreviewType { return delegate.previewType }
    
    func update() {
        print("updating")
        
    }
    
    required init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func start() {
//        allThoughts = getThoughts(batchSize: 1000)
//        delegate.dataRecieved()
    }
    
    deinit {
        delegate = nil
    }
    
}

extension HomeViewModel: ViewModelFilterDelegate {
    
    func clear() {
        print("clearing filter/sort objects")
    }
    
    func sort(withOption option: SortOption) {
        print("sorting with  option: \(option)")
    }
    func filter(withPredicate predicate: String) {
        print("filtering with predicate")
    }
    
}

extension HomeViewModel: ViewModelTableDataSource {
    var count: Int {
        return 0
    }
    
    func loadedPreview(forIndex index: Int) -> DataPreview? {
        return nil
    }
}


protocol TopicVMPlugin: ViewModel { }
extension TopicVMPlugin {
    func getTopics() -> [Orbit] {
        return []
    }
}



