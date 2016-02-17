//
//  TouchView.m
//  LineDemo
//
//  Created by 徐继垚 on 16/2/17.
//  Copyright © 2016年 Sunny土. All rights reserved.
//

#import "TouchView.h"
@interface TouchView()
@property (nonatomic ,retain)NSMutableArray * pointArray;
@property (nonatomic, assign) CGPoint lineStartPoint;
@property (nonatomic, assign) CGPoint lineEndPoint;

@property (nonatomic ,assign) CGPoint oldStart;
@property (nonatomic ,assign) CGPoint oldEnd;
@end
@implementation TouchView
-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.pointArray = [NSMutableArray array];
        
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    
    for (int i = 0; i < self.pointArray.count ; i ++) {
        CGContextRef context  = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 3);
        
        CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
        
        self.oldStart  = [[self.pointArray[i] objectAtIndex:0]CGPointValue];
        self.oldEnd = [[self.pointArray[i] objectAtIndex:1] CGPointValue];
        
        CGContextMoveToPoint(context, self.oldStart.x, self.oldStart.y);
        CGContextAddLineToPoint(context, self.oldEnd.x, self.oldEnd.y);
        
        CGContextStrokePath(context);
    }
    
    
    
    CGContextRef context  = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3);
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    
    CGContextMoveToPoint(context, self.lineStartPoint.x, self.lineStartPoint.y);
    CGContextAddLineToPoint(context, self.lineEndPoint.x, self.lineEndPoint.y);
    
    CGContextStrokePath(context);
 
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (self.pointArray.count == 2) {
        [self.pointArray removeAllObjects];
    }
    
    CGPoint touchPoint;
    
    UITouch *touch = [touches anyObject];
    if (touch) {
        touchPoint = [touch locationInView:self];
        self.lineStartPoint = touchPoint;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint;
    
    UITouch *touch = [touches anyObject];
    if (touch) {
        touchPoint = [touch locationInView:self];
        self.lineEndPoint = touchPoint;
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    

    [self.pointArray addObject:@[[NSValue valueWithCGPoint:self.lineStartPoint] , [NSValue valueWithCGPoint:self.lineEndPoint]]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CGFloat lastLong = distabceFromPoxits(self.lineStartPoint, self.lineEndPoint);
        CGFloat newLong = distabceFromPoxits(self.oldStart, self.oldEnd);
        CGFloat angle = angleBetweenLines(self.lineStartPoint, self.lineEndPoint, self.oldStart, self.oldEnd);
        
        NSString * message = [NSString stringWithFormat:@"线长度为%f , %f  角度为%f" , lastLong  , newLong , angle];
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    });

    
    
}

CGFloat distabceFromPoxits(CGPoint start , CGPoint end) {
    
    float distance;
    
    CGFloat xDist = (end.x - start.x);
    CGFloat yDist = (end.y - start.y);
    distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

CGFloat angleBetweenLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End) {
    
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    
    return  180.0 * rads / M_PI;
  
    
}
@end
