//
//  BubbleIOSSwitch.h
//  Bubble Spectrum iPad
//
//  Created by Ryan Shier on 9/15/14.
//
//

#import <UIKit/UIKit.h>

@interface BubbleIOSSwitch : UIControl

@property (nonatomic, retain, setter = setBackingOutlineColorOn:)   UIColor * backingOutlineColorOn;
@property (nonatomic, retain, setter = setBackingOutlineColorOff:)  UIColor * backingOutlineColorOff;

@property (nonatomic, retain, setter = setBackingInternalColorOn:)  UIColor * backingInternalColorOn;
@property (nonatomic, retain, setter = setBackingInternalColorOff:) UIColor * backingInternalColorOff;


@property (nonatomic, retain, setter = setCircleOutlineColorOn:)    UIColor * circleOutlineColorOn;
@property (nonatomic, retain, setter = setCircleOutlineColorOff:)   UIColor * circleOutlineColorOff;

@property (nonatomic, retain, setter = setCircleInternalColorOn:)   UIColor * circleInternalColorOn;
@property (nonatomic, retain, setter = setCircleInternalColorOff:)  UIColor * circleInternalColorOff;


@property (nonatomic, retain) UIColor * fontColor;
@property CGFloat fontSize;

@property BOOL on;

-(CGSize)getNecessaryBoundsSize;

@end
