# Core Animations Lab
Let us learn all of CALayer properties by animating Leonardo Fibonacci.
The goal is to be able to see a quick working demo of any Core Animation.

All properties can be found [here](https:developer.apple.comlibraryarchivedocumentationCocoaConceptualCoreAnimation_guideAnimatablePropertiesAnimatableProperties.html).

## List of demoed animations

### CALayer
- [x] anchorPoint
- [x] backgroundColor
- [x] borderColor
- [x] borderWidth
- [x] bounds
- [x] borderWidth
- [x] bounds
- [x] cornerRadius
- [x] contentsRect
- [x] hidden
- [x] opacity
- [x] position
- [x] shadowColor
- [x] shadowOffset
- [x] shadowOpacity
- [x] shadowPath
- [x] shadowRadius

### CAGradientLayer
- [x] colors
- [x] locations
- [x] startPoint
- [x] endPoint

### CAShapeLayer

- [ ] fillColor
- [ ] lineDashPhase
- [ ] miterLimit
- [ ] lineWidth
- [ ] strokeColor
- [ ] strokeStart
- [ ] strokeEnd

### CATextLayer

- [x] fontSize
- [x] foregroundColor

### CAEmitterLayer

- [x] emitterPosition
- [x] emitterSize

### CAReplicatorLayer
- [x] instanceDelay
- [x] instanceTransform
- [x] instanceColor
- [x] instanceRedOffset

### CATransform3D

- [x] transform.scale
- [x] transform.translation
- [x] transform.rotation

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
