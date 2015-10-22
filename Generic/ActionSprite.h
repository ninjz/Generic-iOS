//
//  ActionSprite.h
//  Generic
//

//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "RandomItem.h"

@interface ActionSprite : CCSprite {
    
}
//actions
@property(nonatomic, strong)id idleAction;
@property(nonatomic, strong)id attackAction;
@property(nonatomic, strong)id startAction;
@property(nonatomic, strong)id walkAction;
@property(nonatomic, strong)id hurtAction;
@property(nonatomic, strong)id knockedOutAction;

//states
@property(nonatomic, assign)ActionState actionState;

//attributes
@property(nonatomic, assign)float walkSpeed;
@property(nonatomic, assign)float hitPoints;
@property(nonatomic, assign)float damage;
@property(nonatomic, assign)BOOL carryingItem;
@property(nonatomic, assign)RandomItem *item;

//movement

@property(nonatomic, assign)CGPoint velocity;
@property(nonatomic, assign)CGPoint desiredPosition;

//hitboxes
@property(nonatomic, assign)float centerToSides;
@property(nonatomic, assign)float centerToBottom;
@property(nonatomic, assign)BoundingBox hitBox;
@property(nonatomic, assign)BoundingBox attackBox;

//action methods

-(void)idle;
-(void)attack;
-(void)hurtWithDamage:(float)damage;
-(void)knockout;
-(void)walkWithDirection:(CGPoint)direction;
-(void)walkWithDirectionEnemy:(CGPoint)direction;
-(void)walk;

//scheduled methods
-(void)update:(ccTime)dt;

-(BoundingBox)createBoundingBoxWithOrigin:(CGPoint)origin size:(CGSize)size;

@end
