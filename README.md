# TMDBTestTask
Test task with TMTB api.

Requirements
Display a scrollable list of repositories of “square” organisation in GitHub.
Each repository should present at least the name and description of the repo.
Use Swift and UIKit.
Architecture
In this test task I decided to use Clean Architecture. This architecture is using a VIP cycle (view controller, interactor, presenter) to help you separate logic in your application. The ViewController is responsible for the display logic, the Interactor is responsible for the business logic and the Presenter is responsible for the presentation logic. And it's help you to divide your difficult logic to the simpler layers with own responsibilities. In Clean Architecture there are a less dependencies because your View Controller know only about your Interactor, your Interactor knows only about Presenter and Presenter knows only about View Controller. It's also can help you during writing unit/ui tests. This architecture - is a nice chose for the large and difficult projects. This test task wasn't good example (because the task wasn't large or difficult) but in requirements you told to use favourite architecture, that's why I used this one.
