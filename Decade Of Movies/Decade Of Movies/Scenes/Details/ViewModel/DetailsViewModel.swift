//
//  DetailsViewModel.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit
import CoreData

protocol DetailsProtocol {
    var updateLoadingStatus: ((_ state: State) -> Void)? { get }
    var reloadTableView: ((_ isHidden: Bool) -> Void)? { get }
    var moviesData: MasterDataViewModel? {get}
}
class DetailsViewModel {
    // MARK: - properties
    var delegate: DetailsProtocol?
    // MARK: - Context
    private var mainContext: NSManagedObjectContext
    private let backgroundContext: NSManagedObjectContext
    // callback for interfaces
    private var state: State = .empty {
        didSet {
            delegate?.updateLoadingStatus?(state)
        }
    }
    // MARK: - Movies
    // MARK: - Fetch PhotoSearch
    private let apiService: PhotoSearchService
    // MARK: - Fetching Result
    private var photosModel: PhotosModel? {
        didSet {
            self.processFetchedPhotos(data: photosModel)
        }
    }
    private var photosVM: [PhotoSearchViewModel] = [] {
        didSet {
            processFetchedPhotosURL(data: photosVM)
        }
    }
    var photosURL: [String] = [] {
        didSet {
            delegate?.reloadTableView?(false)
            state = .populated
        }
    }
    // MARK: - initialization
    init(apiService: PhotoSearchService = PhotoSearchServiceImpl(),
         mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext,
         backgroundContext: NSManagedObjectContext = CoreDataStack.shared.backgroundContext,
         delegate: DetailsProtocol?) {
        self.apiService = apiService
        self.delegate = delegate
        self.mainContext = mainContext
        self.backgroundContext = backgroundContext
    }
}
// MARK: - SetUpTableView Data
extension DetailsViewModel {
    func getItemByIndexPath(for indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return delegate?.moviesData?.title ?? ""
        case 1:
            return "\(delegate?.moviesData?.year ?? 0)"
        case 2:
            let genres = delegate?.moviesData?.genres ?? []
            return getItemByRow(items: genres, for: indexPath)
        case 3:
            let cast = delegate?.moviesData?.cast ?? []
            return getItemByRow(items: cast, for: indexPath)
        default:
            return ""
        }
    }
    private func getItemByRow(items: [String], for indexPath: IndexPath) -> String {
        guard items.count > indexPath.row else {return ""}
        return items[indexPath.row]
    }
}
// MARK: - SetUpTableView
extension DetailsViewModel {
    var numOfSections: Int {
        return 5
    }
    func getNumOfRow(for section: Int) -> Int {
        switch section {
        case 2:
            return (delegate?.moviesData?.genres ?? []).count
        case 3:
            return (delegate?.moviesData?.cast ?? []).count
        default:
            return 1
        }
    }
}
// MARK: - Header
extension DetailsViewModel {
    var heightForHeader: CGFloat {
        return 45
    }
    func getTitleOfHeader(for section: Int) -> String {
        switch section {
        case 0:
            return "Title"
        case 1:
            return "Year"
        case 2:
            return "Genres"
        case 3:
            return "Cast"
        default:
            return "Pictures"
        }
    }
}
// MARK: - Fetch PhotoSearch from core data or api
extension DetailsViewModel {
    func getPhotos() {
        let storedPhotos = getStoredPhotos()
        if storedPhotos == nil {
            fetchPhotos()
        }
        else {
            photosURL = storedPhotos?.images as? [String] ?? []
        }
    }
}
// MARK: - Fetch PhotoSearch
extension DetailsViewModel {
    private func fetchPhotos() {
        state = .loading
        let title = delegate?.moviesData?.title ?? ""
        apiService.getPhotoSearch(text: title)
        { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                self.photosModel = data.photos
            case .failure(let error):
                print("error ->>> ", error)
                delegate?.reloadTableView?(false)
                self.state = .error
                return
            }
        }
    }
    private func processFetchedPhotos(data: PhotosModel?) {
        photosVM = data?.photo?.compactMap {PhotoSearchViewModel(data: $0) } ?? []
    }
    private func processFetchedPhotosURL(data: [PhotoSearchViewModel]) {
        photosURL = photosVM.compactMap {String($0.photoURL)}
        saveFetchedPhotos()
    }
}
// MARK: - CoreData
extension DetailsViewModel {
    // 1. Create/ Save
    private func saveFetchedPhotos() {
        let fetchedPhotos = Photos(context: mainContext)
        fetchedPhotos.images = photosURL as NSObject
        fetchedPhotos.movie = delegate?.moviesData?.title ?? ""
        // MARK: - Read data from background thread
        backgroundContext.perform { [weak self] in
            guard let self = self else {return}
            if mainContext.hasChanges {
                do {
                    try mainContext.save()
                } catch {
                    print("Error saving context \(error)")
                }
            }
        }
    }
    
    // 1. Read
    private func getStoredPhotos() -> Photos? {
        state = .loading
        let movie = delegate?.moviesData?.title ?? ""
        let request: NSFetchRequest<Photos> = Photos.fetchRequest()
        var photos: Photos? = nil
        // MARK: - Read data from main thread
        mainContext.performAndWait { [weak self] in
            guard let self = self else {return}
            do {
                let storedPhotos = try mainContext.fetch(request)
                photos = storedPhotos.filter {$0.movie == movie}.first
            } catch {
                print("Error fetching data from context \(error)")
            }
        }
        return photos
    }
}
