BubbleIOSSwitch
===============

This is a custom switch object for iOS (that looks like the iOS 7 variant)

I created this object because when upgrading one of my Bubble Imagineering published apps, and trying to maintain iOS 6
compatibility, the width of the iOS 6 version of the UISwitch is quite a bit wider than the iOS 7 version.

This Object looks extremely similar to the iOS 7 variant, only is more customizable.  Users can customize the backing outline,
and internal colors when off, same for when on, and the internal circle's outline and internal colors when on or off.

This object performs similar animation between on / off states.  One difference between this object and Apple's is that this
object notifies the holder's delegate of an action only AFTER the animation has finished (instead of at first touch).
