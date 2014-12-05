//
//  Created by Ole Gammelgaard Poulsen on 05/12/13.
//  Copyright (c) 2012 SHAPE A/S. All rights reserved.
//

#import "UsernameViewModel.h"
#import "AFHTTPRequestOperationManager+RACSupport.h"
#import "NSString+EmailAdditions.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"

static NSString *const kSubscribeURL = @"http://reactivetest.apiary.io/subscribers";

@interface UsernameViewModel ()
@property(nonatomic, strong) RACSignal *usernameValidSignal;
@end

@implementation UsernameViewModel

- (id)init {
	self = [super init];
	if (self) {
		[self mapUsernameCommandStateToStatusMessage];
	}
	return self;
}

- (void)mapUsernameCommandStateToStatusMessage {
	RACSignal *startedMessageSource = [self.usernameCommand.executionSignals map:^id(RACSignal *subscribeSignal) {
		return NSLocalizedString(@"Sending request...", nil);
	}];

	RACSignal *completedMessageSource = [self.usernameCommand.executionSignals flattenMap:^RACStream *(RACSignal *subscribeSignal) {
		return [[[subscribeSignal materialize] filter:^BOOL(RACEvent *event) {
			return event.eventType == RACEventTypeCompleted;
		}] map:^id(id value) {
			return NSLocalizedString(@"Thanks", nil);
		}];
	}];

	RACSignal *failedMessageSource = [[self.usernameCommand.errors subscribeOn:[RACScheduler mainThreadScheduler]] map:^id(NSError *error) {
		return NSLocalizedString(@"Error :(", nil);
	}];

	RAC(self, statusMessage) = [RACSignal merge:@[startedMessageSource, completedMessageSource, failedMessageSource]];
}

- (RACCommand *)usernameCommand {
	if (!_usernameCommand) {
		@weakify(self);
		_usernameCommand = [[RACCommand alloc] initWithEnabled:self.usernameValidSignal signalBlock:^RACSignal *(id input) {
			@strongify(self);
            [self.delegate shouldLoadNextPage];
			return [RACSignal empty];
		}];
	}
	return _usernameCommand;
}

+ (RACSignal *)postEmail:(NSString *)email {
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	manager.requestSerializer = [AFJSONRequestSerializer new];
	NSDictionary *body = @{@"email": email ?: @""};
	return [[[manager rac_POST:kSubscribeURL parameters:body] logError] replayLazily];
}

- (RACSignal *)usernameValidSignal {
	if (!_usernameValidSignal) {
		_usernameValidSignal = [RACObserve(self, username) map:^id(NSString *email) {
			return @([email isValidEmail]);
		}];
	}
	return _usernameValidSignal;
}

@end