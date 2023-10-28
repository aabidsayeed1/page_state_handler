# page_state_handler

The `page_state_handler` Flutter package is designed to add a touch of elegance to your application's user experience. This package streamlines the management of various page states, making it effortless for developers to handle loading, error, empty, and retry scenarios seamlessly. By integrating this package into your Flutter project, you empower your application to respond gracefully to different states, presenting users with content and actions tailored to each specific situation.

Enhance your development workflow and elevate the overall quality of your app by incorporating the `page_state_handler` package. With its intuitive features, developers can focus on creating engaging and dynamic user interfaces without the hassle of manually managing diverse page states. Elevate your Flutter application to new heights, ensuring a smoother, more user-friendly experience for your audience.

## Example

![Screen Recording 2023-10-14 at 6 31 52 PM](https://github.com/aabidsayeed1/page_state_handler/assets/37657822/f9fa3a2e-5e6d-4e67-9076-559c7f05100c)

## Descriptions


## Sample

#### PageStateController

```
PageStateController pageStateController = PageStateController();

```

#### PageStateHandle Widget

```
 PageStateHandler(
        controller: pageStateController,
        retry: () => Future(() => retry()),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      );
```

## Author

<a class="github-button" href="https://github.com/aabidsayeed1" aria-label="Follow @aabidsayeed1 on GitHub">Follow GitHub @aabidsayeed1</a>

<a class="github-button" href="https://www.linkedin.com/in/aabidsayeed1/" aria-label="LinkedIn: aabidsayeed1">Follow LinkedIn: @aabidsayeed1</a>

