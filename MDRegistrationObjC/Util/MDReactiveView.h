//
//  MDReactiveView.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/8/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MDReactiveView <NSObject>

/// Binds the given view model to the view
- (void)bindViewModel:(id)viewModel;

@end
