    //
    //  ShadowingView.m
    //  test
    //
    //  Created by Rob Mayoff on 5/13/17.
    //  Copyright © 2017 Rob Mayoff. All rights reserved.
    //

    #import "ShadowingView.h"

    @interface ShadowingViewAction : NSObject <CAAction>
    @property (nonatomic, strong) CABasicAnimation *pendingAnimation;
    @property (nonatomic) CGPathRef priorPath;
    @end

    @implementation ShadowingView

    - (void)layoutSubviews {
        [super layoutSubviews];

        CALayer *layer = self.layer;
        layer.backgroundColor = nil;

        CALayer *shadowedLayer = self.shadowedView.layer;
        if (shadowedLayer == nil) {
            layer.shadowColor = nil;
            return;
        }

        NSAssert(shadowedLayer.superlayer == layer, @"shadowedView must be my direct subview");

        layer.shadowColor = UIColor.blackColor.CGColor;
        layer.shadowOffset = CGSizeMake(0, 1);
        layer.shadowOpacity = 0.5;
        layer.shadowRadius = 3;
        layer.masksToBounds = NO;

        CGFloat radius = shadowedLayer.cornerRadius;
        layer.shadowPath = CGPathCreateWithRoundedRect(shadowedLayer.frame, radius, radius, nil);
    }

    - (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
        if (![event isEqualToString:@"shadowPath"]) { return [super actionForLayer:layer forKey:event]; }

        CGPathRef priorPath = layer.shadowPath;
        if (priorPath == NULL) { return [super actionForLayer:layer forKey:event]; }

        CAAnimation *sizeAnimation = [layer animationForKey:@"bounds.size"];
        if (![sizeAnimation isKindOfClass:[CABasicAnimation class]]) { return [super actionForLayer:layer forKey:event]; }

        CABasicAnimation *animation = [sizeAnimation copy];
        animation.keyPath = @"shadowPath";
        ShadowingViewAction *action = [[ShadowingViewAction alloc] init];
        action.priorPath = priorPath;
        action.pendingAnimation = animation;
        return action;
    }

    @end

    @implementation ShadowingViewAction

    - (void)runActionForKey:(NSString *)event object:(id)anObject arguments:(NSDictionary *)dict {
        if (![anObject isKindOfClass:[CALayer class]] || _pendingAnimation == nil) { return; }
        CALayer *layer = anObject;
        _pendingAnimation.fromValue = (__bridge id)_priorPath;
        _pendingAnimation.toValue = (__bridge id)layer.shadowPath;
        [layer addAnimation:_pendingAnimation forKey:@"shadowPath"];
    }

    - (void)setPriorPath:(CGPathRef)priorPath {
        CGPathRetain(priorPath);
        CGPathRelease(_priorPath);
        _priorPath = priorPath;
    }

    - (void)dealloc {
        CGPathRelease(_priorPath);
    }

    @end
