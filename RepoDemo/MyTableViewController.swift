import UIKit

// Start view controller class.
class MyTableViewController: UITableViewController {
    
    // added to inside the repo class
    var jsonArray:Array< whiteHouseVM > = Array < whiteHouseVM >()
    
    enum ErrorHandler:ErrorType {
        case ErrorFetchingResults
    }
    
    @IBOutlet var myTableView: UITableView!
    
    // pass self into the repo to set values on array
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate   = self
        let whRepo = whiteHouseVMRepo();
        whRepo.getJSONData(self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("myCell",
                forIndexPath: indexPath)
            let data = jsonArray[indexPath.row]
            cell.textLabel?.text = data.description
            return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonArray.count
    }
    
    // Refresh table once data is loaded.
    func refreshTable() {
        dispatch_async(dispatch_get_main_queue(), {
        self.myTableView.reloadData()
        return
        })
    }
}
