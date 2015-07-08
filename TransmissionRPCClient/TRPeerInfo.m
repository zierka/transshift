//
//  TRPeerInfo.m
//  TransmissionRPCClient
//
//  Created by Alexey Chechetkin on 30.06.15.
//  Copyright (c) 2015 Alexey Chechetkin. All rights reserved.
//

#import "TRPeerInfo.h"

@implementation TRPeerInfo

+ (TRPeerInfo *)peerInfoWithJSONData:(NSDictionary *)dict
{
    return [[TRPeerInfo alloc] initWithJSONData:dict];
}

- (instancetype)initWithJSONData:(NSDictionary*)dict
{
    self = [super init];
    
    if( !self ) return self;
    
    if( dict[TR_ARG_FIELDS_PEER_ADDRESS] )
        _ipAddress = dict[TR_ARG_FIELDS_PEER_ADDRESS];
    if( dict[TR_ARG_FIELDS_PEER_CLIENTNAME] )
        _clientName = dict[TR_ARG_FIELDS_PEER_CLIENTNAME];
    if( dict[TR_ARG_FIELDS_PEER_FLAGSTR] )
        _flagString = dict[TR_ARG_FIELDS_PEER_FLAGSTR];
    if( dict[TR_ARG_FIELDS_PEER_PORT] )
        _port = [(NSNumber*)dict[TR_ARG_FIELDS_PEER_PORT] intValue];
    if( dict[TR_ARG_FIELDS_PEER_PROGRESS] )
    {
        _progress = [(NSNumber*)dict[TR_ARG_FIELDS_PEER_PROGRESS] floatValue];
        _progressString = [NSString stringWithFormat:@"%02.2f%%", _progress * 100.0f];
    }
    
    NSByteCountFormatter *byteFormatter = [[NSByteCountFormatter alloc] init];
    byteFormatter.allowsNonnumericFormatting = NO;
    
    if( dict[TR_ARG_FIELDS_PEER_RATETOCLIENT] )
    {
        _rateToClient = [(NSNumber*)dict[TR_ARG_FIELDS_PEER_RATETOCLIENT] longLongValue];
        _rateToClientString = [NSString stringWithFormat:@"%@/s", [byteFormatter stringFromByteCount:_rateToClient]];
    }
    
    if( dict[TR_ARG_FIELDS_PEER_RATETOPEER ])
    {
        _rateToPeer = [(NSNumber*)dict[TR_ARG_FIELDS_PEER_RATETOPEER] longLongValue];
        _rateToPeerString = [NSString stringWithFormat:@"%@/s", [byteFormatter stringFromByteCount:_rateToPeer]];
    }
    
    if( dict[TR_ARG_FIELDS_PEER_ISENCRYPTED])
        _isEncrypted = [(NSNumber*)dict[TR_ARG_FIELDS_PEER_ISENCRYPTED] boolValue];

    if( dict[TR_ARG_FIELDS_PEER_ISUTP])
        _isUTP = [(NSNumber*)dict[TR_ARG_FIELDS_PEER_ISUTP] boolValue];
    
    
    return self;
}

@end