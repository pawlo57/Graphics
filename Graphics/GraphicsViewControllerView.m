//
//  GraphicsViewControllerView.m
//  Graphics
//
//  Created by pawel on 12.04.2013.
//  Copyright (c) 2013 Pawel. All rights reserved.
//

#import "GraphicsViewControllerView.h"

@implementation GraphicsViewControllerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //[self drawGradient];
}

- (void)drawGradient {
    //get current graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //save state od graphics context
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //start color component
    CGFloat *startColorComponents = (CGFloat*)CGColorGetComponents([UIColor orangeColor].CGColor);
    
    //end color component
    CGFloat *endColorComponents = (CGFloat*)CGColorGetComponents([UIColor blueColor].CGColor);
    
    //cloro components martix, first orange and second blue R G B A
    CGFloat colorComponents[8] = {
        startColorComponents[0],
        startColorComponents[1],
        startColorComponents[2],
        startColorComponents[3],
        
        endColorComponents[0],
        endColorComponents[1],
        endColorComponents[2],
        endColorComponents[3]
    };
    
    //color indicies for gradient
    
    CGFloat colorIndicies[2] = {
        0.0f,
        1.0f
    };
    
    //create gradient
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents, colorIndicies, 2);
    
    //release color space
    CGColorSpaceRelease(colorSpace);
    
    CGPoint startPoint = CGPointMake(120.0f, 160.0f);
    CGPoint endPoint = CGPointMake(200.0f, 220.0f);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
}

- (void)drawArrayOfRects {
    //crete path
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect rectangle1 = CGRectMake(10.0f, 10.0f, 200.0f, 300.0f);
    CGRect rectangle2 = CGRectMake(40.0f, 100.0f, 90.0f, 300.0f);
    
    CGRect rectangles[2] = { rectangle1 , rectangle2 };
    
    CGPathAddRects(path, NULL, rectangles, 2);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(context, path);
    
    //set fill color
    [[UIColor colorWithRed:0.2f green:0.6f blue:0.8f alpha:1.0f] setFill];
    
    //set stroke color
    [[UIColor blackColor] setStroke];
    
    CGContextSetLineWidth(context, 5.0f);
    
    //draw
    CGContextDrawPath(context, kCGPathFill);
    
    
    //release
    CGContextRelease(context);
    
    
}

- (void)drawRectangle {
    //create rect path
    CGMutablePathRef path = CGPathCreateMutable();
    
    //add rect to path
    CGPathAddRect(path, NULL, CGRectMake(10.0f, 10.0f, 200.0f, 300.0f));
    
    //add second rect
    CGPathAddRect(path, NULL, CGRectMake(150.0f, 250.0f, 100.0f, 100.0f));
    
    //get graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //set shadow
    CGContextSetShadowWithColor(context,CGSizeMake(10.0f, 10.0f), 20.0f, [[UIColor grayColor] CGColor]);
    
    //add rect path to context
    CGContextAddPath(context, path);
    
    //set corn flower blue fill color
    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
    
    //set stroke color to brown
    [[UIColor brownColor] setStroke];
    
    //set line width to 5
    CGContextSetLineWidth(context, 5.0f);
    
    //draw path
    CGContextDrawPath(context, kCGPathFill);
    
    //release context
    CGContextRelease(context);
}

//drawing using path
- (void)drawX {
    //create path
    CGMutablePathRef path = CGPathCreateMutable();
    
    //get screen bounds
    CGRect screenBound = [UIScreen mainScreen].bounds;
    
    //start from to left point
    CGPathMoveToPoint(path, NULL, screenBound.origin.x, screenBound.origin.y);
    
    //draw line from top-let to bottom-right
    CGPathAddLineToPoint(path, NULL, screenBound.size.width, screenBound.size.height);
    
    //move to upper-rigt point
    CGPathMoveToPoint(path, NULL, screenBound.size.width, screenBound.origin.y);
    
    //draw to bottom-left point
    CGPathAddLineToPoint(path, NULL, screenBound.origin.x, screenBound.size.height);
    
    //create context draw
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //add path to curretn context
    CGContextAddPath(context, path);
    
    //set blue color
    [[UIColor blueColor] set];
    
    //draw path
    CGContextDrawPath(context, kCGPathStroke);
    
    //release context
    CGContextRelease(context);
}

-(void)drawFigure {
    [self drawRoofTopAtTopPoint:CGPointMake(160.0f, 40.0f) textToDisplay:@"Miter" lineJoin:kCGLineJoinMiter];
    
    [self drawRoofTopAtTopPoint:CGPointMake(160.0f, 180.0f) textToDisplay:@"Bevel" lineJoin:kCGLineJoinBevel];
    
    [self drawRoofTopAtTopPoint:CGPointMake(160.0f, 320.0f) textToDisplay:@"Round" lineJoin:kCGLineJoinRound];
}

- (void)drawRoofTopAtTopPoint:(CGPoint)toPoint textToDisplay:(NSString*)text lineJoin:(CGLineJoin)lineJoin {
    [[UIColor brownColor] set];
    
    //get current graphics context
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //set line join
    CGContextSetLineJoin(currentContext, lineJoin);
    
    //set line width
    CGContextSetLineWidth(currentContext, 20.0f);
    
    //starting point
    CGContextMoveToPoint(currentContext, toPoint.x - 140.0f, toPoint.y + 100.0f);
    
    //add the end point
    CGContextAddLineToPoint(currentContext, toPoint.x, toPoint.y);
    
    //add another point
    CGContextAddLineToPoint(currentContext, toPoint.x + 140.0f, toPoint.y + 100.0f);
    
    //draw line
    CGContextStrokePath(currentContext);
    
    //set black color for text
    [[UIColor blackColor] set];
    
    
    //draw text
    [text drawAtPoint:CGPointMake(toPoint.x - 40.0f, toPoint.y + 60.0f) withFont:[UIFont systemFontOfSize:30.0f]];
}

- (void)drawLine {
    [[UIColor brownColor] set];
    
    //get current graphics context
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //set line width
    CGContextSetLineWidth(currentContext, 5.0f);
    
    //starting point
    CGContextMoveToPoint(currentContext, 20.0f, 20.0f);
    
    //add the end point
    CGContextAddLineToPoint(currentContext, 100.0f, 100.0f);
    
    //add another point
    CGContextAddLineToPoint(currentContext, 300.0f, 100.0f);
    
    //draw line
    CGContextStrokePath(currentContext);
}

- (void)drawImage {
    UIImage *image = [UIImage imageNamed:@"xcode.png"];
    
    [image drawAtPoint:CGPointMake(0.0f, 20.0f)];
    
    [image drawInRect:CGRectMake(50.0f,10.0f,40.0f,35.0f)];
}

- (void)drawString {
    UIColor *magnetaColor = [UIColor colorWithRed:0.5f green:0.0f blue:0.5f alpha:1.0f];
    [magnetaColor set];
    
    UIFont *font = [UIFont fontWithName:@"Futura" size:40.0f];
    
    NSString *myString = @"I Learn Really Fast";
    
    [myString drawInRect:CGRectMake(100, 120, 200, 100) withFont:font];
}


@end
