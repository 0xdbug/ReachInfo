#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#import <MediaRemote/MediaRemote.h>
#import <Cephei/HBPreferences.h>
#import "../Helpers/UIDevice+notchedDevice.h"

@interface SBMediaController : NSObject{
    //NSDictionary* _nowPlayingInfo;
}
+ (id)sharedInstance;
- (BOOL)isPaused;
- (BOOL)isPlaying;
- (void)setNowPlayingInfo:(id)arg1;
- (BOOL)changeTrack:(int)arg1 eventSource:(long long)arg2;
- (BOOL)togglePlayPauseForEventSource:(long long)arg1;
- (BOOL)toggleShuffleForEventSource:(long long)arg1;
- (BOOL)toggleRepeatForEventSource:(long long)arg1;
-(id)_nowPlayingInfo;
@end

@interface MRUVisualStylingProvider : NSObject
- (id)init;
- (void)applyStyle:(long long)arg1 toView:(id)arg2;
@end

@interface MediaControlsPanelViewController : UIViewController
+ (id)panelViewControllerForCoverSheet;
- (NSInteger)style;
- (void)setStyle:(NSInteger)arg1 ;
@end

@interface MRUNowPlayingTimeControlsView : UIControl
@end

@interface MRUNowPlayingControlsView : UIView
@property (nonatomic,readonly) MRUNowPlayingTimeControlsView * timeControlsView;
@end

@class MPMediaControls;

@interface MRUNowPlayingView: UIView
@property (nonatomic,retain) MRUVisualStylingProvider * stylingProvider;
@property (nonatomic,retain) MRUNowPlayingControlsView * controlsView;
@end

@interface MRUNowPlayingViewController: UIViewController
+ (id)coversheetViewController;
@property (nonatomic,retain) MRUNowPlayingView * view;
@property (nonatomic,retain) MRUVisualStylingProvider * stylingProvider;
-(void)setMediaControls:(MPMediaControls *)arg1;
@property (assign,nonatomic) id delegate;
@end


@interface RIMediaPlayer : UIView
@property (nonatomic, retain) MRUNowPlayingViewController *MRUNowPlayingViewController;
@property (nonatomic, retain) MediaControlsPanelViewController *MediaControlsPanelViewController;
@end

BOOL MediaBG;
