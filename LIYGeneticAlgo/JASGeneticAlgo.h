//
//  JASGeneticAlgo.h
//  LIYGeneticAlgo
//
//  Created by Jason Cheladyn on 7/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JASGeneticAlgo : NSObject
@property (nonatomic, readonly, assign) NSInteger generations;
@property (nonatomic, readonly, strong) NSString *result;
@property (nonatomic, readwrite, strong) NSMutableArray *chromos;
@property (nonatomic, readwrite, strong) NSMutableArray *chromoFitness;
- (id)initWithTargetSequence:(NSString *)sequence;
- (void) execute;
@end
