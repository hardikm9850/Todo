# Simple ToDo App (iOS)

A simple iOS To-Do application built using **UIKit** and **MVC architecture**.

---

## Features

* Display list of To-Do items using `UITableView`
* Add new tasks using an `UIAlertController` with:

  * `UITextField` (task name)
  * `UIDatePicker` (`.dateAndTime` with `.wheel` style)
* Delete functionaloty (swipe to delete)


---

## Components Used 

### **UIKit Elements**

| Component               | Purpose                    |
| ----------------------- | -------------------------- |
| `UITableViewController` | Manages the list of tasks  |
| `UITableView`           | Displays items using cells |
| `UIAlertController`     | Collect task name + date   |
| `UIDatePicker`          | Selects date & time        |
| `UITableViewCell`       | Shows each task            |

---


## Screenshots 

* Home screen with list

<p align="left"> <img src="resources/home.png" width="260" height="500"> </p>

* Add task popup with date picker

<p align="left"> <img src="resources/add%20todo.png" width="260" height="500"> </p>

---

## Pending / To-Do

* [x] Add “completed” checkbox
* [ ] Add unit tests
* [ ] Add editing support
* [ ] Add search/filter

