//
//  RFKeyboardToolbar.h
//
//  Created by Rex Finn on 12/3/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFKeyboardToolbar : UIView

@property (nonatomic, assign) BOOL tapSoundEnabled;

+ (instancetype)toolbarViewWithButtons:(NSArray *)buttons;

@end
