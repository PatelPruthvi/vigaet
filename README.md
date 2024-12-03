# Flutter Video Player with Comments and Markers

This project is a Flutter-based application that demonstrates video playback functionality with a dynamic comment system. Users can view comments at specific video timestamps, and artists can reply to comments. Markers on the video slider indicate the timestamps of comments, dynamically updating as new comments are added.

## Features

- **Video Playback**: Plays a sample video with controls.
- **Comment System**: Users can add comments at specific timestamps, and markers appear on the video slider for each comment.
- **Reply System**: Artists can reply to comments.
- **Dynamic Markers**: Comments are represented as markers on the video slider, updated in real-time.
- **Mock Data**: Includes sample data for easy testing and demonstration.

---

## Project Structure

- **`lib/`**: Contains the main application code.
  - **`home_view.dart`**: Handles video playback and slider with markers.
  - **`comment_section/`**: Implements the comment and reply system using BLoC.
  - **`bloc/`**: Contains BLoC logic for managing video and comment state.
  - **`models/`**: Defines models for comments and replies.
  - **`widgets/`**: Contains reusable UI components.

---

## Prerequisites

1. **Flutter SDK**: Ensure that Flutter is installed on your system. Follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install).
2. **Dependencies**: Install the required dependencies listed in `pubspec.yaml`:
   - `flutter_bloc`
   - `video_player`
   - `fluttertoast`

---

## Setup Instructions

1. **Clone the Repository:**

   ```bash
   $ git clone https://github.com/PatelPruthvi/vigaet.git

2. **Navigate to Project Directory**
   
   ```bash
   $ cd vigaet
3. **Install dependencies**
   
   ```bash
   $ flutter pub get
4. **Run application**

   ```bash
   $ flutter run
## Usage

1. Launch the application.
2. The main video playback screen displays a video with a slider and markers for comments.
3. Add a new comment at the current video timestamp via the comment input field.
4. Switch to the comment section to view and reply to comments.
5. Watch markers on the slider update dynamically as comments are added.

---

## Demo Data

- **Video**: Sample video of a butterfly from Flutter's assets.
- **Initial Comments**:
  ```json
  [
    {
      "commentId": 0,
      "commentValue": "Beautiful scene with the butterfly!",
      "videoTimestamp": 2.0,
      "artistReply": null
    },
    {
      "commentId": 1,
      "commentValue": "What camera did you use for this shot?",
      "videoTimestamp": 4.0,
      "artistReply": {
        "commentId": 201,
        "commentValue": "I used a DSLR Canon 80D for this clip."
      }
    }
  ]
