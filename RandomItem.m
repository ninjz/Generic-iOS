//
//  RandomItem.m
//  Generic
//
//  Created by Calvin Cheng on 2013-01-16.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "RandomItem.h"
#import "Item.h"
#import "PowerUp.h"



@implementation RandomItem

-(id)init{
    if((self = [super init])){
        
        CCArray *itemList = [[CCArray alloc] initWithCapacity:10];
        CCArray *powerUpList = [[CCArray alloc] initWithCapacity:10];
           
        
    }

    return self;
}

-(Item*)giveItem{
    
}

-(PowerUp*)givePowerUp{
    
}


@end


