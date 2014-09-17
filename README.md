BubbleIOSSwitch
===============

This is a custom switch object for iOS (that looks like the iOS 7 variant)

I created this object because when upgrading one of my Bubble Imagineering published apps, and trying to maintain iOS 6
compatibility, the width of the iOS 6 version of the UISwitch is quite a bit wider than the iOS 7 version.

This Object looks extremely similar to the iOS 7 variant, only is more customizable.  Users can customize the backing outline,
and internal colors when off, same for when on, and the internal circle's outline and internal colors when on or off.  The nice
thing about this object is that it will allow users to have the SAME EXACT looking switch regardless of iOS version.

This object performs similar animation between on / off states.  One difference between this object and Apple's is that this
object notifies the holder's delegate of an action only AFTER the animation has finished (instead of at first touch).

Drawing:
=================
This object will draw a 51 px wide x 31 px high switch all the way left and vertically centered within whatever sized rect the switch is initialized with


TO USE:
to use this object, the easiest way is:
  - Include both the .h and .m files within your project  
  - put a standard UIView on whatever view you wish to have the switch on, within your xib file.
  - define that newly placed UIView as a "BubbleIOSSwitch" within the xib file.
  - the UIView should be sized no smaller than 51 px wide x 31 px high (it can be larger, but look at the drawing note above)
  
