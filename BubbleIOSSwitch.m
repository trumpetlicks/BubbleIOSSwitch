//
//  BubbleIOSSwitch.m
//  Bubble Spectrum iPad
//
//  Created by Ryan Shier on 9/15/14.
//
//

#import "BubbleIOSSwitch.h"

#define DEG_TO_RADIANS(x) (((float)(x) * 3.141592654f) / 180.0f)

#define __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__                  1.25f
#define __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE    0.25f
#define __BUBBLE_IO_SWITCH_CIRCLE_OUTLINE_WIDTH__                   1.25

/*
 * This is a supporting backing view that performs the custom drawing of the backing of the Switch
 */
#pragma mark -
#pragma mark Private BubbleIOSwitchBackingView
@interface BubbleIOSwitchBackingView : UIControl

@property (nonatomic, retain) UIColor * outlineColor;
@property (nonatomic, retain) UIColor * backingColor;

@end

@implementation BubbleIOSwitchBackingView

@synthesize outlineColor = _outlineColor;
@synthesize backingColor = _backingColor;

-(id)init{
    
    if( self = [super init] ){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if( self = [super initWithFrame:frame] ){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setOutlineColor:(UIColor *)outlineColor{
    _outlineColor = outlineColor;
    [self setNeedsDisplay];
}

-(void)setBackingColor:(UIColor *)backingColor{
    _backingColor = backingColor;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef ctx    = UIGraphicsGetCurrentContext();
	CGRect       frame  = self.bounds;
    CGFloat      radius = (frame.size.height - ( __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__  * 2.0 ) ) / 2.0;
    
    // Store the graphics state for restoring after we have drawn
    CGContextSaveGState(ctx);
    
    CGContextSetFillColorWithColor(ctx, _backingColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, _outlineColor.CGColor);
    
    // Set the line width for the corner drawing
    CGContextSetLineWidth(ctx, __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ );
    
    // Create the enclosing path with a left and a right half circle
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, nil, radius + __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ , radius + __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ , radius, DEG_TO_RADIANS(270), DEG_TO_RADIANS(90), 1);
    CGPathAddArc(path, nil, frame.size.width - radius - __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ , radius + __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ , radius, DEG_TO_RADIANS(90), DEG_TO_RADIANS(270), 1);
    CGPathCloseSubpath(path);
    
    // Fill the enclosed path
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    
    // Outline the path
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    
    // Restore the graphics state prior to drawing
    CGContextRestoreGState(ctx);
    
}

@end


/*
 * This is a supporting circle UIView to be used / drawn within the Switch
 */
#pragma mark -
#pragma mark Private BubbleIOSwitchCircleView
@interface BubbleIOSwitchCircleView : UIControl

@property (nonatomic, retain) UIColor * outlineColor;
@property (nonatomic, retain) UIColor * backingColor;

@end

@implementation BubbleIOSwitchCircleView

@synthesize outlineColor = _outlineColor;
@synthesize backingColor = _backingColor;

-(id)init{
    
    if( self = [super init] ){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if( self = [super initWithFrame:frame] ){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setOutlineColor:(UIColor *)outlineColor{
    _outlineColor = outlineColor;
    [self setNeedsDisplay];
}

-(void)setBackingColor:(UIColor *)backingColor{
    _backingColor = backingColor;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef ctx    = UIGraphicsGetCurrentContext();
	CGRect       frame  = self.bounds;
    CGFloat      radius = (frame.size.height - ( __BUBBLE_IO_SWITCH_CIRCLE_OUTLINE_WIDTH__  * 2.0 ) ) / 2.0;
    
    // Store the graphics state for restoring after we have drawn
    CGContextSaveGState(ctx);
    
    CGContextSetFillColorWithColor(ctx, _backingColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, _outlineColor.CGColor);
    
    // Set the line width for the corner drawing
    CGContextSetLineWidth(ctx, __BUBBLE_IO_SWITCH_CIRCLE_OUTLINE_WIDTH__ );
    
    // Create the enclosing path with a left and a right half circle
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, nil, radius + __BUBBLE_IO_SWITCH_CIRCLE_OUTLINE_WIDTH__ , radius + __BUBBLE_IO_SWITCH_CIRCLE_OUTLINE_WIDTH__ , radius, DEG_TO_RADIANS(0), DEG_TO_RADIANS(360), 1);
    CGPathCloseSubpath(path);
    
    // Fill the enclosed path
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    
    // Outline the path
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    
    // Restore the graphics state prior to drawing
    CGContextRestoreGState(ctx);
    
}

@end


/*
 *
 */
#pragma mark - 
#pragma BubbleIOSSwitch private properties interface
@interface BubbleIOSSwitch ()

@property (nonatomic, retain) BubbleIOSwitchBackingView * backing;
@property (nonatomic, retain) BubbleIOSwitchBackingView * middle;
@property (nonatomic, retain) BubbleIOSwitchCircleView *  circle;
@property (nonatomic, retain) BubbleIOSwitchCircleView *  onCircle;

@end


#pragma mark -
#pragma mark BubbleIOSSwitch Implementation
@implementation BubbleIOSSwitch

@synthesize backingOutlineColorOn   = _backingOutlineColorOn;
@synthesize backingOutlineColorOff  = _backingOutlineColorOff;

@synthesize backingInternalColorOn  = _backingInternalColorOn;
@synthesize backingInternalColorOff = _backingInternalColorOff;

@synthesize circleOutlineColorOn    = _circleOutlineColorOn;
@synthesize circleOutlineColorOff   = _circleOutlineColorOff;

@synthesize circleInternalColorOn   = _circleInternalColorOn;
@synthesize circleInternalColorOff  = _circleInternalColorOff;

@synthesize fontColor               = _fontColor;
@synthesize fontSize                = _fontSize;

@synthesize on                      = _on;

@synthesize backing   = _backing;
@synthesize middle    = _middle;
@synthesize circle    = _circle;
@synthesize onCircle  = _onCircle;

#pragma mark -
#pragma mark Custom Initialization
-(void)initSwitch{
    
    // Set the background to clear
    self.backgroundColor = [UIColor clearColor];
    
    // Initialize the switch to position OFF
    _on = NO;
    
    _backingInternalColorOff = [UIColor clearColor];
    _backingInternalColorOn  = [UIColor colorWithRed:74.0 / 255.0
                                               green:215.0 / 255.0
                                                blue:99.0 / 255.0
                                               alpha:1.0];
    
    _backingOutlineColorOff  = [UIColor colorWithWhite:209.0 / 255.0 alpha:1.0];
    _backingOutlineColorOn   = [UIColor colorWithRed:74.0 / 255.0
                                               green:215.0 / 255.0
                                                blue:99.0 / 255.0
                                               alpha:1.0];
    
    _circleOutlineColorOn    = [UIColor whiteColor];
    _circleOutlineColorOff   = [UIColor whiteColor];
    
    _circleInternalColorOn   = [UIColor whiteColor];
    _circleInternalColorOff  = [UIColor whiteColor];
    
    // Add the backing UIView
    CGRect aRect = CGRectMake(0, (self.frame.size.height - 31.0) / 2, 51.0, 31.0);
    _backing = (BubbleIOSwitchBackingView *)[[BubbleIOSwitchBackingView alloc] initWithFrame:aRect];
    _backing.outlineColor = _backingOutlineColorOff;
    _backing.backingColor = _backingInternalColorOff;
    [_backing addTarget:self
                 action:@selector(switchAction:)
       forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self addSubview:_backing];
    
    
    // Add the UIView between the backing and circle
    _middle = (BubbleIOSwitchBackingView *)[[BubbleIOSwitchBackingView alloc] initWithFrame:aRect];
    _middle.outlineColor = _backingOutlineColorOn;
    _middle.backingColor = _backingInternalColorOn;
    [_middle addTarget:self
                 action:@selector(switchAction:)
       forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    _middle.alpha = 0.0;
    [self addSubview:_middle];
    
    
    // Add the circle on top of the backing
    aRect = CGRectMake(__BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE,
                       __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE,
                       31.0 - ( 2.0 * ( __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE ) ),
                       31.0 - ( 2.0 * ( __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE ) ) );
    _circle = (BubbleIOSwitchCircleView *)[[BubbleIOSwitchCircleView alloc] initWithFrame:aRect];
    _circle.outlineColor = _circleOutlineColorOff;
    _circle.backingColor = _circleInternalColorOff;
    [_circle addTarget:self
                 action:@selector(switchAction:)
       forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self addSubview:_circle];
    
    // Add the on Circle
    _onCircle = (BubbleIOSwitchCircleView *)[[BubbleIOSwitchCircleView alloc] initWithFrame:aRect];
    _onCircle.outlineColor = _circleOutlineColorOn;
    _onCircle.backingColor = _circleInternalColorOn;
    [_onCircle addTarget:self
                action:@selector(switchAction:)
      forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    _onCircle.alpha = 0.0;
    [self addSubview:_onCircle];
}

#pragma mark -
#pragma mark Necessary Overloaded Initialization
-(id)init{
    
    if( self = [super init] ){
        [self initSwitch];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if( self = [super initWithFrame:frame] ){
        [self initSwitch];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        [self initSwitch];
    }
    return self;
}

#pragma mark -
#pragma mark Custom Color Setter Routines for Backing View
-(void)setBackingOutlineColorOn:(UIColor *)backingOutlineColorOn{
    _backingOutlineColorOn = backingOutlineColorOn;
    
    if( YES == _on ){
        _backing.outlineColor = _backingOutlineColorOn;
        [self setNeedsDisplay];
    }
}

-(void)setBackingOutlineColorOff:(UIColor *)backingOutlineColorOff{
    _backingOutlineColorOff = backingOutlineColorOff;
    
    if( NO == _on ){
        _backing.outlineColor = _backingOutlineColorOff;
        [self setNeedsDisplay];
    }
}

-(void)setBackingInternalColorOn:(UIColor *)backingInternalColorOn{
    _backingInternalColorOn = backingInternalColorOn;
    
    if( YES == _on ){
        _backing.backingColor = _backingInternalColorOn;
        [self setNeedsDisplay];
    }
}

-(void)setBackingInternalColorOff:(UIColor *)backingInternalColorOff{
    _backingInternalColorOff = backingInternalColorOff;
    
    if( NO == _on ){
        _backing.backingColor = _backingInternalColorOff;
        [self setNeedsDisplay];
    }
}

#pragma mark -
#pragma mark Custom Color Setter Routines for Circle View
-(void)setCircleOutlineColorOn:(UIColor *)circleOutlineColorOn{
    _circleOutlineColorOn = circleOutlineColorOn;
    
    if( YES == _on ){
        _circle.outlineColor = _circleOutlineColorOn;
        [self setNeedsDisplay];
    }
}

-(void)setCircleOutlineColorOff:(UIColor *)circleOutlineColorOff{
    _circleOutlineColorOff = circleOutlineColorOff;
    
    if( NO == _on ){
        _circle.outlineColor = _circleOutlineColorOff;
        [self setNeedsDisplay];
    }
}

-(void)setCircleInternalColorOn:(UIColor *)circleInternalColorOn{
    _circleInternalColorOn = circleInternalColorOn;
    
    if( YES == _on ){
        _circle.backingColor = _circleInternalColorOn;
        [self setNeedsDisplay];
    }
}

-(void)setCircleInternalColorOff:(UIColor *)circleInternalColorOff{
    _circleInternalColorOff = circleInternalColorOff;
    
    if( YES == _on ){
        _circle.backingColor = _circleInternalColorOff;
        [self setNeedsDisplay];
    }
}

#pragma mark -
#pragma mark Action to be taken by backing OR circle
-(void)switchAction:(id)sender{
    _on = !_on;
    
    CGRect aRect;
    
    // Move the backing view to it's new position
    [UIView beginAnimations:@"switch_change" context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    if( YES == _on ){
        _middle.alpha = 1.0;
        
        aRect = CGRectMake(51.0 -
                            (__BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE) -
                            ( 31.0 - ( 2.0 * ( __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE ) ) ),
                           __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE,
                           31.0 - ( 2.0 * ( __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE ) ),
                           31.0 - ( 2.0 * ( __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE ) ) );
        
        // Position the circle on the right side of the switch
        [_circle setFrame: aRect];
        
        _onCircle.alpha = 1.0;
        [_onCircle setFrame:aRect];
    }else{
        _middle.alpha = 0.0;
        
        aRect = CGRectMake(__BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE,
                           __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE,
                           31.0 - ( 2.0 * ( __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE ) ),
                           31.0 - ( 2.0 * ( __BUBBLE_IO_SWITCH_BACKING_OUTLINE_WIDTH__ + __BUBBLE_IO_SWITCH_SEPARATION_BETWEEN_BACKING_AND_CIRCLE ) ) );
        
        // Position the circle on the left side of the switch
        [_circle setFrame:aRect];
        
        _onCircle.alpha = 0.0;
        [_onCircle setFrame:aRect];
    }
    
    [UIView commitAnimations];
    
}

-(void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context{
    
    /*
    if( YES == _on ){
        // Setup all of the colors for the outlines and internals for the backing and the circle
        _backing.outlineColor = _backingOutlineColorOn;
        _backing.backingColor = _backingInternalColorOn;
        
        _circle.outlineColor  = _circleOutlineColorOn;
        _circle.backingColor  = _circleInternalColorOn;
    }else{
        // Setup all of the colors for the outlines and internals for the backing and the circle
        _backing.outlineColor = _backingOutlineColorOff;
        _backing.backingColor = _backingInternalColorOff;
        
        _circle.outlineColor  = _circleOutlineColorOff;
        _circle.backingColor  = _circleInternalColorOff;
    }
    */
    
    // Fire the action to the above caller
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(CGSize)getNecessaryBoundsSize{
    
}

@end
