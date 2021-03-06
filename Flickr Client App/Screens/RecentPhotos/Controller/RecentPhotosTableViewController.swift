//
//  RecentPhotosTableViewController.swift
//  Flickr Client App
//
//  Created by mono on 2.07.2022.
//

import UIKit

class RecentPhotosTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var networkManager = NetworkManager()
    
    private var response:PhotosResponse? {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var ownerImage:UIImage? {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var selectedPhoto:Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        fetchRecentPhotos()
    }
    
    private func setupSearchController(){
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }
    
    private func fetchRecentPhotos(){
        print("deneme")
        
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=75416bae3ddc203c80afe9748e7192f7&format=json&nojsoncallback=1&extras=description,license,date_upload,date_taken,owner_name,icon_server,original_format,last_update,machine_tags,o_dims,views,media,url_sq,url_t,url_s,url_q,url_m,url_n,url_z,url_c,url_l,url_o") else {return}
        
        let photosGetRecentRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: photosGetRecentRequest) { data,response,error in
            print("Girdimi mi")
            if let error = error {
                print("Erorr : ",error)
                return
            }
            guard let data = data else {
                print("Something went wrong")
                return
            }
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(PhotosResponse.self, from: data)
                self.response = response
                //print(response)
            }catch{
                print("Error:",error)
            }
        }.resume()
    }
    
    private func searchPhotos(with text:String){
        guard let url = URL(string:  "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=75416bae3ddc203c80afe9748e7192f7&text=\(text)&format=json&nojsoncallback=1&extras=description,license,date_upload,date_taken,owner_name,icon_server,original_format,last_update,machine_tags,o_dims,views,media,url_sq,url_t,url_s,url_q,url_m,url_n,url_z,url_c,url_l,url_o")
        else {return}
        
        let photosGetRecentRequest = URLRequest(url: url)
     
        URLSession.shared.dataTask(with: photosGetRecentRequest) { data,response,error in
            if let error = error {
                return
            }
            if let data = data{
                let response = try? JSONDecoder().decode(PhotosResponse.self, from: data)
                self.response = response!
            }else{
                print("Bulamad??m")
            }
        }.resume()
    }
    //Table View'daki b??l??m say??s??
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //Yukar??da Belirtilen b??l??mden ka?? tane olu??sun.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print(response?.photos?.photo?.count)
        return response?.photos?.photo?.count ?? .zero
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = response?.photos?.photo?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath) as! PhotoTableViewCell
            
        networkManager.fetchImage(with:photo?.buddyIconUrl) { data in
                    cell.ownerImageView.image = UIImage(data: data)
        }
        cell.ownerNameLabel.text = photo?.ownername
        networkManager.fetchImage(with: photo?.urlN, competion: { data in
            cell.photoImageView.image = UIImage(data:data)
        })
        cell.titleLabel.text = photo!.title
        return cell
    }
    //Index'teki cell e t??klad??????m??zda olacak olaylar.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPhoto = response?.photos?.photo?[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: nil)
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PhotoDetailViewController{
            viewController.photo = selectedPhoto
        }
        
    }
    //MARK: -
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count > 2 {
            searchPhotos(with: searchController.searchBar.text!)
        }
    }

}

