//
//  JASGeneticAlgo.m
//  LIYGeneticAlgo
//
//  Created by Jason Cheladyn on 7/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "JASGeneticAlgo.h"
#import "JASChromosome.h"

@interface JASGeneticAlgo()
@property (nonatomic, readwrite, strong) NSString *result;
@property (nonatomic, readwrite, assign) NSInteger generations;
@property (nonatomic, strong) NSMutableArray *population;
@property (nonatomic, copy) NSString *targetSequence;
- (void)populate;
- (void)run;
- (void)breedNextGeneration;
- (void)shufflePopulation;
- (void)analyzePopulation;
@end

@implementation JASGeneticAlgo
@synthesize generations;
@synthesize population;
@synthesize result;
@synthesize targetSequence;
@synthesize chromos;
#define MAX_GENERATIONS 1000
#define POPULATION_SIZE 750

- (id)initWithTargetSequence:(NSString *)sequence
{
    self = [super init];
    if (self)
    {
        self.targetSequence = sequence;
        self.population = [NSMutableArray arrayWithCapacity:POPULATION_SIZE];
        self.chromos = [NSMutableArray array];
    }
    return self;
}

- (void)execute
{
    [self populate];
    [self run];
}

- (void)populate
{
    NSUInteger geneCount = self.targetSequence.length;
    JASChromosome *chromo;
    for (int i=0; i < POPULATION_SIZE; ++i)
    {
        chromo = [[JASChromosome alloc] initWithGeneCount:geneCount];
        [self.population addObject:chromo];
    }
}

- (void)run
{
    for (self.generations = 0;
         self.generations < MAX_GENERATIONS && !self.result;
         self.generations++)
    {
        [self breedNextGeneration];
        [self shufflePopulation];
        [self analyzePopulation];
    }
    --self.generations;
}

- (void)breedNextGeneration
{
    NSUInteger index1, index2, deadIndex;
    JASChromosome *chromo1, *chromo2, *child;
    NSString *seq = self.targetSequence;
    BOOL keepFirst;
    NSUInteger count = self.population.count;
    
    for (int i =0; i < count; i += 2)
    {
        index1 = i;
        index2 = i + 1;
        chromo1 = [self.population objectAtIndex:index1];
        chromo2 = [self.population objectAtIndex:index2];
        keepFirst = [chromo1 isFitterThanChromosome:chromo2 forTargetSequence:seq];
        deadIndex = keepFirst ? index2 : index1;
        child = [chromo1 mateWithChromosome:chromo2];
        [self.population replaceObjectAtIndex:deadIndex withObject:child];
        NSLog(@"%i", i);
    }
}

- (void)shufflePopulation
{
    JASChromosome *last = [self.population lastObject];
    [population removeLastObject];
    [population insertObject:last atIndex:0];
}

- (void)analyzePopulation
{
    JASChromosome *champion = nil;
    NSString *seq = self.targetSequence;
    for (JASChromosome *contender in self.population)
    {
        if (!champion || [contender isFitterThanChromosome:champion forTargetSequence:seq])
        {
            champion = contender;
        }
    }
    NSString *fittest = champion.geneSequence;
    NSNumber *fittestInt = champion.geneFitness;
    NSArray * entry= @[fittest,fittestInt];
    
    BOOL matchesTarget = [fittest isEqualToString:seq];
    if (matchesTarget)
    {
        self.result = fittest;
        [chromos addObject:@[fittest, fittestInt]];
        NSLog(@"Matched the target seqeunce during the generation #%1d", self.generations);
    }
    else
    {
        [chromos addObject:entry];
        NSLog(@"Fittest Sequence for generation #%1d: %@", self.generations, fittest);
    }
}





@end
