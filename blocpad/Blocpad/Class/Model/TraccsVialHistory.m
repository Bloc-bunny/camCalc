//
//  TraccsVialHistory.m
//  Blocpad
//
//  Created by Hugh Lang on 3/27/13.
//
//

#import "TraccsVialHistory.h"

@implementation TraccsVialHistory

@synthesize contractId, qtrname, actUnits;
@synthesize state;

static NSString *rowFormat = @"%i|%@|%i";

- (NSString *) toString
{
    NSString *result = [NSString stringWithFormat:rowFormat, contractId, qtrname, actUnits];
    
    return result;
}

@end
