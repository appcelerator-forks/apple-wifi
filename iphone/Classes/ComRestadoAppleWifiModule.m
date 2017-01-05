/**
 * appleWifi
 *
 * Created by Your Name
 * Copyright (c) 2015 Your Company. All rights reserved.
 */

#import "ComRestadoAppleWifiModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"





#import "Foundation/Foundation.h"

#import "ifaddrs.h"
#import "net/if.h"
#import "SystemConfiguration/CaptiveNetwork.h"







@interface SMTWiFiStatus : NSObject

- (int)       isWiFiEnabled;
/*
- (BOOL)       isWiFiEnabled;
- (BOOL)       isWiFiConnected;
- (NSString *) BSSID;
- (NSString *) SSID;
*/
@end

@implementation SMTWiFiStatus
/*
- (BOOL) isWiFiEnabled {
    
    NSCountedSet * cset = [NSCountedSet new];
    
    struct ifaddrs *interfaces;
    
    if( ! getifaddrs(&interfaces) ) {
        for( struct ifaddrs *interface = interfaces; interface; interface = interface->ifa_next) {
            if ( (interface->ifa_flags & IFF_UP) == IFF_UP ) {
                [cset addObject:[NSString stringWithUTF8String:interface->ifa_name]];
            }
        }
    }
    
	freeifaddrs(interfaces);
	
    return [cset countForObject:@"awdl0"] > 1 ? YES : NO;
}
*/

- (int) isWiFiEnabled {
	
	NSCountedSet * cset = [NSCountedSet new];
	
	struct ifaddrs *interfaces;
	
	if( ! getifaddrs(&interfaces) ) {
		for( struct ifaddrs *interface = interfaces; interface; interface = interface->ifa_next) {
			if ( (interface->ifa_flags & IFF_UP) == IFF_UP ) {
				[cset addObject:[NSString stringWithUTF8String:interface->ifa_name]];
			}
		}
	}
	
	freeifaddrs(interfaces);
	
	//unknown
	if ([cset countForObject:@"awdl0"] == 0) {
		return 2;
	}
	
	else {
		return [cset countForObject:@"awdl0"] > 1 ? 1 : 0;
	}

}

/*
- (NSDictionary *) wifiDetails {
    return
    (__bridge NSDictionary *)
    CNCopyCurrentNetworkInfo(
                             CFArrayGetValueAtIndex( CNCopySupportedInterfaces(), 0)
                             );
}

//new
- (NSDictionary *) wifiDetails {
	CFArrayRef supportedInterfaces = CNCopySupportedInterfaces();
	CFDictionaryRef details = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(supportedInterfaces , 0));
	CFRelease(supportedInterfaces);
	return (__bridge_transfer NSDictionary *)details;
}



- (BOOL) isWiFiConnected {
    return [self wifiDetails] == nil ? NO : YES;
}

- (NSString *) BSSID {
    return [self wifiDetails][@"BSSID"];
}

- (NSString *) SSID {
    return [self wifiDetails][@"SSID"];
}
*/

@end









@implementation ComRestadoAppleWifiModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"1a479d4f-7083-4883-81f8-378d6709a0b4";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.restado.appleWifi";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)example2:(id)args
{
	// example method
	return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}







//actual function:

-(int)isWIFIEnabled:(id)args {
    
    SMTWiFiStatus * wstatus = [SMTWiFiStatus new];
    
    //NSLog(@"Wifi Enabled   : %@", [wstatus isWiFiEnabled  ] ? @"Yes" : @"No");
    //return @"Wifi Enabled   : %@", [wstatus isWiFiEnabled  ] ? @"Yes" : @"No";
    return [wstatus isWiFiEnabled  ];
    
    
}









@end
