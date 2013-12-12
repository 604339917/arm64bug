//
//  DCAViewController.m
//  arm64bug
//
//  Created by Drew Crawford on 12/12/13.
//  Copyright (c) 2013 DrewCrawfordApps. All rights reserved.
//

#import "DCAViewController.h"

@interface DCAViewController () {
    int intVar;
    float x;
}

@end

@implementation DCAViewController

- (void)viewDidLoad
{
    
    UILabel *ll = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:ll];
    
    
    dispatch_queue_t q1 = dispatch_queue_create("q1", NULL);
    dispatch_async(q1, ^{
        while (1) {
            intVar++;
            printf("intVar: %d\n",intVar);
            usleep(100000);
        }
    });
    
    
    dispatch_queue_t q2 = dispatch_queue_create("q2", NULL);
    dispatch_async(q2, ^{
        while (1) {
            float f = (float)x;
            intVar = 0;
            dispatch_sync(dispatch_get_main_queue(), ^{
                ll.text = [NSString stringWithFormat:@"%f",f];
            });
            usleep(1000000);
        }
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
