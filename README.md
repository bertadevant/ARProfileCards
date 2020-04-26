# ARProfileCards
AR workshop for Swift Aveiro 2019

## Requirements 
- IOS 13 device 
- Xcode 11 Beta 

## Starting Project 🛠
The starting project contains some helper code and some Entities and Models to kickstart the workshop. It also contains some code that places a banana where user touches, we will run through this code together and start building off from it. 

![GIF of placing a banana](banana.gif)

- [ ] ARSession && Tracking
- [ ] ARView 
- [ ] ARAnchor && Anchor Entities
- [ ] Entity 
- [ ] ARCoachingView

If you want to play around ARKit and try different things, this are some idea of how to "clean" the starting project or add more functionality: 

- Clean `StatusView` how it shows and when 
- Allow for only one banana to be shown on the app at all times (you can remove entities and anchors from a scene before adding new ones)
- Add segment or buttons on screen that allows the user to switch between the three different bananas 
- Create your own model on Reality Composer and add it to the app 
- Place animations on the banana (Entities have a composite box and they can react to being touched)

## Let's code! 👩‍💻 

We will be slowly building a better app and learning new things from AR step by step. 

### Lights, shadows and actions 

The banana looks ok now but it does not really seem to be in place, we can add some shadows, estimated light and some actions that would make it look more real in the world 

###  Banana for scale

We can also recognize a lot of different tracking and anchors in AR, in this part we will check Image Recognition and tracking and play around with 3D text. 

###  Hide and Seek 

Let's get our banana to not only be in the world but interact with it and use people occlusion to not appear when is not wanted. 

## Extra things you can do in AR ✨

- [Face Tracking]()
- [Body tracking]()
- [3D object tracking]()
- [People Occlusion]()

## Resources for further understanding concepts

- [Understanding World Tracking](https://developer.apple.com/documentation/arkit/understanding_world_tracking)
- [Tracking and visualizing planes](https://developer.apple.com/documentation/arkit/tracking_and_visualizing_planes)
- [Placing objects and handeling 3d Interactions](https://developer.apple.com/documentation/arkit/placing_objects_and_handling_3d_interaction)
- [RealityKit docs](https://developer.apple.com/documentation/realitykit)
- [Introducing RealityKit and RealityComposer](https://developer.apple.com/videos/play/wwdc2019/603/)
- [Building app with RealityKit](https://developer.apple.com/videos/play/wwdc2019/605/)
- [Raycasting on AR to polish your apps](https://developer.apple.com/documentation/arkit/artrackedraycast?language=objc)
