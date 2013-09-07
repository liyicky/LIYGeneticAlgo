//
//  JASChromosome.h
//  LIYGeneticAlgo
//
//  Created by Jason Cheladyn on 7/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JASChromosome : NSObject
@property (nonatomic, readonly, strong) NSString *geneSequence;
@property (nonatomic, readonly, strong) NSNumber *geneFitness;
- (id)initWithGeneCount:(NSUInteger)count;
- (JASChromosome *)mateWithChromosome:(JASChromosome *)other;
- (BOOL)isFitterThanChromosome:(JASChromosome *)other forTargetSequence:(NSString *)sequence;
@end
