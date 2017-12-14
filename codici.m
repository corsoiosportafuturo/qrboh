//
//  codici.m
//  QRCodeReaderViewControllerExample
//
//  Created by studiostaff6 on 12/12/17.
//  Copyright © 2017 Yannick Loriot. All rights reserved.
//

#import "codici.h"

@interface codici ()

@end

@implementation codici

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if((self = [super init])){
        
        [self setNumeroCode:[dic objectForKey:@"NumeroCode"]];
        [self setNome:[dic objectForKey:@"nome"]];
        
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  

    
    
@end
