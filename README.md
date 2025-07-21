# sky_feels

 🧠 How I Learned BLoC


I began with the official Bloc documentation and examples to understand the core concepts of:
Events, States, Bloc lifecycle, BlocProvider, BlocBuilder, BlocListener
To be honest, the official documentation felt a bit overwhelming at first 😅. So instead of going deep into dry docs, I took a more practical route.
I followed a YouTube tutorial by Asif Taj, watching it at 1.5x speed (because I was racing the clock ⏱️). His way of explaining the BLoC pattern — events, states, and clean architecture — helped me grasp the core concepts much faster and more clearly.
I then practiced with small sample apps (e.g., counter, login flow) to become comfortable with emitting and reacting to state changes. Once comfortable, I explored integrating BLoC with clean architecture, using flutter_bloc, freezed, and equatable for best practices.


⚙️ How I Set Up the Project
I structured the app using Clean Architecture with these layers:

bash
Copy
Edit
lib/
├── core/                # Shared utilities (Dio, API client, errors)
├── features/
│   └── weather/
│       ├── data/        # Models, data sources, repository impl
│       ├── domain/      # Entities, abstract repositories, use cases
│       └── presentation/# Bloc, UI, widgets
├── injection_container.dart
└── main.dart

Setup included:
Bloc & state class generation with freezed + build_runner
Global Dio instance with interceptor
NetworkInfo to switch between cache and API

🧩 Challenges Faced & How I Solved Them
1. Architectural Layering
Problem: Initially, I found it difficult to manage dependencies between layers.
Solution: I introduced get_it as a service locator and built a proper DI system (injection_container.dart) that respects Clean Architecture boundaries.

3. Testing Dio with Freezed Models
Problem: Dio response parsing with custom WeatherModel required precise structure matching the API.
Solution: I debugged raw JSON responses and fine-tuned the model's fromJson and toJson methods to mirror the API payload exactly.
