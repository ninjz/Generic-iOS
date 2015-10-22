//
//  Button.m
//  Generic
//
//  Created by Calvin Cheng on 2013-01-02.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Button.h"


@implementation Button

+(id)buttonWithFile:(NSString *)fileName radius:(float)radius {
    return [[self alloc] initWithFile:fileName radius:radius];
}

-(id)initWithFile:(NSString *)filename radius:(float)radius {
    if ((self = [super initWithFile:filename])) {
        _radius = radius;
        _isHeld = NO;
        [self scheduleUpdate];
    }
    return self;
}

-(void)onEnterTransitionDidFinish {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:1 swallowsTouches: NO];
}

-(void) onExit {
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

-(void)update:(ccTime)dt {
    if(_isHeld){
        [_delegate holdAttack:self];
    }
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    float distanceSQ = ccpDistanceSQ(location, position_);
    if (distanceSQ <= _radius * _radius) {
        [_delegate attack:self];
        _isHeld = YES;
        return YES;
    }
    return NO;
    
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
   
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    _isHeld = NO;
    [_delegate buttonTouchEnded:self];
}

@end
