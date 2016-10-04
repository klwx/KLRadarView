//
//  RadarView.m
//  Maice
//
//  Created by kl on 16/9/21.
//  Copyright © 2016年 kl. All rights reserved.
//

#define kWidth [UIScreen mainScreen].bounds.size.width
#define MAKE_COLOR(rr,gg,bb) [UIColor colorWithRed:(rr)/255.0f green:(gg)/255.0f blue:(bb)/255.0f alpha:1.0f]

#import "RadarView.h"

@implementation RadarView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    for (NSInteger i = 0; i < 5; i++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBStrokeColor(context, 151/255.0f, 151/255.0f, 151/255.0f, 1);
        CGContextSetLineWidth(context, 0.5);
        CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, 20 + i*20, 0, 2*M_PI, 0);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    if (_dataArray.count != 0) {
        NSArray *array = [NSArray arrayWithArray:_dataArray[0]];
        for (NSInteger i = 0; i < array.count; i++) {
            CGPoint start = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            CGPoint end = CGPointMake(self.frame.size.width/2 + 100*cos(M_PI_2 + 2*M_PI*i/array.count), self.frame.size.height/2 - 100*sin(M_PI_2 + 2*M_PI*i/array.count));
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 0.5);
            CGContextSetRGBStrokeColor(context, 151/255.0f, 151/255.0f, 151/255.0f, 1.0);
            CGContextMoveToPoint(context, start.x, start.y);
            CGContextAddLineToPoint(context, end.x, end.y);
            CGContextStrokePath(context);
            
            NSString *string = [[array[i] objectForKey:@"text"] isEqual:[NSNull null]] ? @"" : array[i][@"text"];
            [string drawInRect:[self getRectWithPoint:end withText:string] withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : MAKE_COLOR(50, 50, 50)}];
        }
        
        for (NSInteger i = 0; i < _dataArray.count; i++) {
            
            NSArray *data = [NSArray arrayWithArray:_dataArray[i]];
            NSMutableArray *pointArray = [NSMutableArray array];
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetRGBStrokeColor(context, [_rgbFloats[i][0] integerValue]/255.0f, [_rgbFloats[i][1] integerValue]/255.0f, [_rgbFloats[i][2] integerValue]/255.0f, 1.0);
            CGContextSetLineWidth(context, 2);
            for (NSInteger i = 0; i < data.count; i++) {
                CGFloat value = [data[i][@"value"] isEqual:[NSNull null]] ? 0 : [data[i][@"value"] floatValue];
                CGFloat radius = value*100;
                CGPoint point = CGPointMake(self.frame.size.width/2 + radius*cos(M_PI_2 + 2*M_PI*i/data.count), self.frame.size.height/2 - radius*sin(M_PI_2 + 2*M_PI*i/data.count));
                if (i == 0) {
                    CGContextMoveToPoint(context, point.x, point.y);
                }else {
                    CGContextAddLineToPoint(context, point.x, point.y);
                }
                [pointArray addObject:@{@"x" : @(point.x), @"y" : @(point.y)}];
            }
            CGContextClosePath(context);
            CGContextStrokePath(context);
            
            for (NSDictionary *dictionary in pointArray) {
                CGContextSetLineWidth(context, 2);
                CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
                CGContextAddArc(context, [dictionary[@"x"] floatValue], [dictionary[@"y"] floatValue], 4, 0, 2*M_PI, 0);
                CGContextDrawPath(context, kCGPathFillStroke);
            }
            
        }
    }
}

- (CGRect)getRectWithPoint:(CGPoint)point withText:(NSString *)text {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat textWidth = [self getTextWidthWithText:text withFont:[UIFont systemFontOfSize:13]];
    if (ABS(point.x - width/2) <= 10) {
        if (point.y > height/2) {
            return CGRectMake(point.x - textWidth/2, point.y + 10, textWidth, 18);
        }else {
            return CGRectMake(point.x - textWidth/2, point.y - 28, textWidth, 18);
        }
    }else if (point.x - width/2 > 10) {
        if (point.y == height) {
            if (point.x + textWidth + 10 >= kWidth) {
                return CGRectMake(point.x + 10, point.y - 18, kWidth - point.x - 20, 36);
            }else {
                return CGRectMake(point.x + 10, point.y - 9, kWidth - point.x, 18);
            }
        }else if (point.y < height) {
            if (point.x + textWidth + 10>= kWidth) {
                return CGRectMake(point.x + 10, point.y - 30, kWidth - point.x - 20, 36);
            }else {
                return CGRectMake(point.x + 10, point.y - 18, kWidth - point.x, 18);
            }
        }else {
            if (point.x + textWidth + 10 >= kWidth) {
                return CGRectMake(point.x + 10, point.y, kWidth - point.x - 20, 36);
            }else {
                return CGRectMake(point.x + 10, point.y + 9, kWidth - point.x, 18);
            }
        }
    }else {
        if (point.y == height) {
            if (point.x <= textWidth + 10) {
                return CGRectMake(10, point.y - 18, point.x - 20, 36);
            }else {
                return CGRectMake(point.x - textWidth - 10, point.y - 9, textWidth, 18);
            }
        }else if (point.y < height) {
            if (point.x <= textWidth + 10) {
                return CGRectMake(10, point.y - 30, point.x - 20, 36);
            }else {
                return CGRectMake(point.x - textWidth - 10, point.y - 18, textWidth, 18);
            }
        }else {
            if (point.x <= textWidth + 10) {
                return CGRectMake(10, point.y, point.x - 20, 36);
            }else {
                return CGRectMake(point.x - textWidth - 10, point.y + 9, textWidth, 18);
            }
        }
    }
}

- (CGFloat)getTextWidthWithText:(NSString *)string withFont:(UIFont *)font {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}


@end
