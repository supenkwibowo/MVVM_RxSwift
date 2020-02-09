# MVVM_RxSwift
Proposed idea of `MVVM` using `RxSwift`

### Components in View Model
- `BehaviorRelay` served as two way binding property. Example of usage is when there is a `UITextField` binding.
- `Driver` served as one way binding property. Example of usage is binding to `UILabel`.
- `Signal` served as observable event for view. Example of usage is for showing alert or dismissing view controller.
- `PublishRelay` served as command. Example of usage is for save action, or login action.
