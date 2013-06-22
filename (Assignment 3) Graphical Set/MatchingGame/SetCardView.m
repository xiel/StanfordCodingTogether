//
//  SetCardView.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/22/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

- (void)setColor:(NSUInteger)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setSymbol:(NSUInteger)symbol {
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setShade:(NSUInteger)shade {
    _shade = shade;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

#define CORNER_RADIUS_IN_WIDTH 0.1

//drawing code
- (void)drawRect:(CGRect)rect {
    NSLog(@"Draw SetCard with %d %d %d %d", self.color, self.symbol, self.shade, self.elementsCount);
    
    //draw the card
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.width * CORNER_RADIUS_IN_WIDTH];
    
    //clip all further drawing to this rounded rect
    [roundedRect addClip];
    
    //fill with background color
    [[UIColor colorWithHue:0 saturation:0 brightness: self.faceUp ? 1 : .95 alpha:1] setFill];
    UIRectFill(self.bounds);
    
    //stroke the card
    [[UIColor colorWithHue:0 saturation:0 brightness: .6 alpha:1] setStroke];
    [roundedRect stroke];
    
    //card specific
    UIColor *baseColor = [self getColorFor:self.color];
    
    [self drawSymbolsIn:baseColor];
    
    
}


#define WIDTH_IN_PERCENT 0.6
#define HEIGHT_IN_PERCENT 0.15
#define VERTICAL_GAPS_IN_PERCENT 0.05


- (void)drawSymbolsIn:(UIColor *)color {
    
    float rectWidth = self.bounds.size.width * WIDTH_IN_PERCENT;
    float rectHeight = self.bounds.size.height * HEIGHT_IN_PERCENT;
    float verticalGapHeight = self.bounds.size.height * VERTICAL_GAPS_IN_PERCENT;
    
    float transformXCentered = (self.bounds.size.width - rectWidth) / 2;
    float transformYCentered = (self.bounds.size.height - rectHeight) / 2;
    
    if(self.elementsCount == 1){
        
        //symbol in center
        [self saveAndTranslateContextToX:transformXCentered y:transformYCentered];
        [self drawSymbolWithWidth:rectWidth height:rectHeight color:color];
        [self restoreContext];
        
    } else if (self.elementsCount == 2){
        
        //symbol top
        [self saveAndTranslateContextToX:transformXCentered y:transformYCentered + rectHeight/2 - verticalGapHeight/2 - rectHeight];
        [self drawSymbolWithWidth:rectWidth height:rectHeight color:color];
        [self restoreContext];
        
        //symbol top
        [self saveAndTranslateContextToX:transformXCentered y:transformYCentered + rectHeight/2  + verticalGapHeight/2];
        [self drawSymbolWithWidth:rectWidth height:rectHeight color:color];
        [self restoreContext];

    
    } else if (self.elementsCount == 3){
        
        //symbol in center
        [self saveAndTranslateContextToX:transformXCentered y:transformYCentered];
        [self drawSymbolWithWidth:rectWidth height:rectHeight color:color];
        [self restoreContext];
        
        //symbol at top
        [self saveAndTranslateContextToX:transformXCentered y:transformYCentered - (verticalGapHeight + rectHeight)];
        [self drawSymbolWithWidth:rectWidth height:rectHeight color:color];
        [self restoreContext];
        
        //symbol at bottom
        [self saveAndTranslateContextToX:transformXCentered y:transformYCentered + rectHeight + verticalGapHeight];
        [self drawSymbolWithWidth:rectWidth height:rectHeight color:color];
        [self restoreContext];
        
    }
    
}

- (void)saveAndTranslateContextToX:(float)x y:(float)y {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, x, y);
}

- (void)restoreContext {
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}


- (void)drawSymbolWithWidth:(float)width height:(float)height color:(UIColor *)color {
        
    UIBezierPath *symbolPath;
    
    //draw symbol
    if(self.symbol == 1){ //diamonds
        symbolPath = [UIBezierPath bezierPath];
        [symbolPath moveToPoint:CGPointMake(width/2, 0)];
        [symbolPath addLineToPoint:CGPointMake(width, height/2)];
        [symbolPath addLineToPoint:CGPointMake(width/2, height)];
        [symbolPath addLineToPoint:CGPointMake(0, height/2)];
        [symbolPath closePath];
    }
    else if(self.symbol == 2) { //oval
        CGRect drawRect = CGRectMake(0, 0, width, height);
        symbolPath = [UIBezierPath bezierPathWithOvalInRect:drawRect];
    }
    else if(self.symbol == 3) { //squiggles
        symbolPath = [UIBezierPath bezierPath];
        
        float unitX = width/8;
        float unitY = height/4;
        
        [symbolPath moveToPoint:CGPointMake(unitX*2, 0)];
        [symbolPath addCurveToPoint:CGPointMake(unitX*5, unitY*1) controlPoint1:CGPointMake(unitX*3, 0) controlPoint2:CGPointMake(unitX*4, unitY*1)];
        [symbolPath addCurveToPoint:CGPointMake(unitX*7, unitY/4) controlPoint1:CGPointMake(unitX*6, unitY*1) controlPoint2:CGPointMake(unitX*7-unitX/2, unitY/4)]; //top right turn
        [symbolPath addCurveToPoint:CGPointMake(unitX*8, unitY*2) controlPoint1:CGPointMake(unitX*7+unitX/2, unitY/4) controlPoint2:CGPointMake(unitX*8, unitY*1)];
        [symbolPath addCurveToPoint:CGPointMake(unitX*6, unitY*4) controlPoint1:CGPointMake(unitX*8, unitY*3) controlPoint2:CGPointMake(unitX*7, unitY*4)];
        [symbolPath addCurveToPoint:CGPointMake(unitX*3, unitY*3) controlPoint1:CGPointMake(unitX*5, unitY*4) controlPoint2:CGPointMake(unitX*4, unitY*3)];
        [symbolPath addCurveToPoint:CGPointMake(unitX*1, unitY*4 - unitY/4) controlPoint1:CGPointMake(unitX*2, unitY*3) controlPoint2:CGPointMake(unitX*1+unitX/2, unitY*4 - unitY/4)]; //bottom left turn
        [symbolPath addCurveToPoint:CGPointMake(0, unitY*2) controlPoint1:CGPointMake(unitX*1-unitX/2, unitY*4 - unitY/4) controlPoint2:CGPointMake(0, unitY*3)];
        [symbolPath addCurveToPoint:CGPointMake(unitX*2, 0) controlPoint1:CGPointMake(0, unitY*1) controlPoint2:CGPointMake(unitX*1, 0)];
        //[symbolPath closePath];
    }
    
    //clip filling to symbol
    [symbolPath addClip];
    
    //draw a stroke for all fillings
    [color setStroke];
    [symbolPath stroke];
    
    //filling
    if(self.shade == 1){ //solid
        //fill path
        [color setFill];
        [symbolPath fill];
    }
    else if (self.shade == 2){ //striped
        
        UIBezierPath *stripePath = [UIBezierPath bezierPath];
        stripePath.lineWidth = 0.3;
        
        for(NSUInteger xPos = 1; xPos <= width; xPos += 2){
            [stripePath moveToPoint:CGPointMake(xPos, 0)];
            [stripePath addLineToPoint:CGPointMake(xPos, height)];
        }
        
        [stripePath stroke];
    }
    
    
    
}


- (UIColor *)getColorFor:(NSUInteger)colorNumber {
    UIColor *color;
    
    switch (colorNumber) {
        case 1:
            color = [UIColor colorWithRed: 119.0/255.0 green:69.0/255.0 blue:176.0/255.0 alpha:1]; //purple
            break;
        case 2:
            color = [UIColor colorWithRed:215.0/255.0 green:41.0/255.0 blue:33.0/255.0 alpha:1]; //red
            break;
        case 3:
            color = [UIColor colorWithRed:108.0/255.0 green:176.0/255.0 blue:47.0/255.0 alpha:1]; //green
            break;
        default:
            //gray as fallback
            color = [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:1];
            break;
    }
        
    return color;
}

- (void)setup {
    // do initialization here
}

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
