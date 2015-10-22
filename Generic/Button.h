//
//  Button.h
//  Generic
//
//  Created by Calvin Cheng on 2013-01-02.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
//Alex is gay

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Button;

@protocol ButtonDelegate <NSObject>

-(void)attack: (Button *)button;
-(void)holdAttack:(Button *)button;
-(void)buttonTouchEnded:(Button *)button;

@end

@interface Button : CCSprite <CCTargetedTouchDelegate> {
    float _radius;
}
@property(nonatomic,weak)id <ButtonDelegate> delegate;
@property(nonatomic,assign)BOOL isHeld;

+(id)buttonWithFile:(NSString *)fileName radius:(float)radius;
-(id)initWithFile:(NSString *)filename radius:(float)radius;

@end
