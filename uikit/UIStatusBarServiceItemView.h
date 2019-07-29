#import <UIKit/UIStatusBarItemView.h>
#import <UIKit/UIStatusBar.h>

@interface UIStatusBarServiceItemView : UIStatusBarItemView {
	NSString* _serviceString;
	double _serviceImageWidth;
	double _serviceImageLetterSpacing;
	NSString* _crossfadeString;
	unsigned long long _crossfadeStep;
	double _maxWidth;
	double _serviceWidth;
	double _crossfadeWidth;
	int _contentType;
	BOOL _loopingNecessaryForString;
	BOOL _loopNowIfNecessary;
	BOOL _loopingNow;
	double _letterSpacing;
}
-(double)extraRightPadding;
-(id)contentsImage;
-(BOOL)updateForNewData:(id)arg1 actions:(int)arg2 ;
-(long long)legibilityStyle;
-(double)updateContentsAndWidth;
-(double)standardPadding;
-(void)setVisible:(BOOL)arg1 frame:(CGRect)arg2 duration:(double)arg3 ;
-(double)resetContentOverlap;
-(double)addContentOverlap:(double)arg1 ;
-(BOOL)animatesDataChange;
-(void)performPendedActions;
-(BOOL)updateForContentType:(int)arg1 serviceString:(id)arg2 serviceCrossfadeString:(id)arg3 maxWidth:(double)arg4 actions:(int)arg5 ;
-(id)_contentsImageFromString:(id)arg1 withWidth:(double)arg2 letterSpacing:(double)arg3 ;
-(void)_crossfadeStepAnimation;
-(BOOL)_crossfaded;
-(BOOL)_loopingNecessary;
-(id)_crossfadeContentsImage;
-(id)_serviceContentsImage;
-(void)_loopAnimationDidStop:(id)arg1 finished:(id)arg2 context:(id)arg3 ;
-(void)_finalAnimationDidStop:(id)arg1 finished:(id)arg2 context:(id)arg3 ;
@end
