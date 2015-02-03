//
//  Teleport.m
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import "Teleport.h"
#import "Singleton.h"
#import "LogRotator.h"
#import "LogReaper.h"


@interface Teleport() {
    LogRotator *_logRotator;
    LogReaper *_logReaper;
    SimpleHttpForwarder *_forwarder;
}

@end
@implementation Teleport

IMPLEMENT_EXCLUSIVE_SHARED_INSTANCE(Teleport)

+ (void)appDidLaunch:(TeleportConfig *)config
{
    [[Teleport sharedInstance] startWithConfig:config];
}

#pragma mark - Lifecycle -

- (id) init
{
    if((self = [super init]))
    {
    }
    return self;
}

- (void)startWithConfig:(TeleportConfig *)config
{
    _logRotator = [[LogRotator alloc] init];
    _forwarder = [[SimpleHttpForwarder alloc] initWithConfig:config];
    _logReaper = [[LogReaper alloc] initWithLogRotator:_logRotator AndForwarder:_forwarder];

    [_logRotator startLogRotation];
    [_logReaper startLogReaping];
}

@end
