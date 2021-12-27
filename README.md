# Core Animations Lab
Let us learn all of CALayer properties by animating Leonardo Fibonacci.
The goal is to be able to see a quick working demo of any Core Animation.

All properties can be found [here](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html).

## List of demoed animations

### CALayer
* anchorPoint [/]
* backgroundColor [/]
* borderColor [/]
* borderWidth [/]
* bounds [/]
* borderWidth [/]
* bounds [/]
* cornerRadius [/]
* contentsRect [/]
* hidden [/]
* opacity [/]
* position [/]
* shadowColor [/]
* shadowOffset [/]
* shadowOpacity [/]
* shadowPath [/]
* shadowRadius [/]

### CAGradientLayer
* colors [/]
* locations [/]
* startPoint [/]
* endPoint [/]

### CAShapeLayer

* fillColor [/]
* lineDashPhase [/]
* miterLimit [/]
* lineWidth [/]
* strokeColor [/]
* strokeStart [/]
* strokeEnd [/]

### CATextLayer

* fontSize [/]
* foregroundColor [/]

### CAEmitterLayer

* emitterPosition [/]
* emitterSize [/]

### CAReplicatorLayer
* instanceDelay [/]
* instanceTransform [/]
* instanceColor [/]
* instanceRedOffset [/]

### CATransform3D

* transform.scale [/]
* transform.translation [/]
* transform.rotation [/]

## LIST OF TODOs

[ ] Replicator layer animations are not deterministic, the opacity animation works depending on the first replicator animation that is played.
[ ] transform.scale.z and transform.translation.z do not work.
[ ] The emitter layer does not stop emitting.
[ ] Add animation zPosition
[ ] Add backgroundFilters animation
[ ] Add compositingFilter animation
[ ] Add contents animation
[ ] Add filters animation
[ ] Add mask animation
[ ] Add masksToBounds animation
[ ] Add sublayers animation
[ ] Add sublayerTransform animation
[ ] Add instanceGreenOffset animation
[ ] Add instanceBlueOffset animation
[ ] Add UI to show current animation properties
[ ] Add UI to be able to change current animation properties
