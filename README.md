# ArticleTask
New York Times Popular Articles


### How to run the app
 - Pull the latest code from "https://github.com/ahmed23khan/ArticleTask.git"
 - Navigate to the folder ArticleTask/Articles
 - Open Articles.xcodeproj
 - Select Articles Target and Select iPhone X
 - Click on Run or ⌘R
 
### How to test the app
 - Pull the latest code from "https://github.com/ahmed23khan/ArticleTask.git"
 - Navigate to the folder ArticleTask/Articles
 - Open Articles.xcodeproj
 - Select Articles Target
 - Click on Products and Test or ⌘U
 
### Code Walkthrough 
- Design Pattern: MVVM
- Latest Swift Features: Codalble Protocol for Parsing JSON Response.
- AritcleManager: A singleton class designed for network transactions. This class fetchs the API and returns parsed JSON values to ViewModel.
- ViewController: Class contains view realted code like Initialising UI and updating the UI after fetching data from API.
- ArticleViewModel: Contains the business logic and the intermediate between View (ViewController) and the Model(Article) binded by closure callbacks.
- Article : Class that acts the model to contains the data fetched from API.
- ArticelTableViewCell: A custom class for custom cells inheriting from UITableViewCell.
- Constants: A struct that contains constant values. No hardcodings:)

### Class Diagram
![Alt text](https://github.com/ahmed23khan/ArticleTask/blob/master/Articles/Class%20Architecture.png)
