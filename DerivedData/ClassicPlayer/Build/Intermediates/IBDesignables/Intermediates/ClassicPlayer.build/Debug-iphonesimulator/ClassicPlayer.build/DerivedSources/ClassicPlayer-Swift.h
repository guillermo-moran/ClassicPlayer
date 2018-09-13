// Generated by Apple Swift version 3.1 (swiftlang-802.0.53 clang-802.0.42)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import Foundation;
@import CoreGraphics;
@import AudioToolbox;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC13ClassicPlayer13AboutScreenVC")
@interface AboutScreenVC : UIViewController
@property (nonatomic, readonly) UIStatusBarStyle preferredStatusBarStyle;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (IBAction)dismissAbout:(id _Nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13ClassicPlayer7AboutVC")
@interface AboutVC : UIViewController
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)stopListeningForClickwheelChanges;
- (void)startListeningForClickwheelChanges;
- (void)clickWheelDidMoveUpWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelDidMoveDownWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)menuClickedWithNotification:(NSNotification * _Nonnull)notification;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIImage;
@class UITableView;
@class UITableViewCell;

SWIFT_CLASS("_TtC13ClassicPlayer12AlbumsMenuVC")
@interface AlbumsMenuVC : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull albumsArray;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull artistsArray;
@property (nonatomic, copy) NSArray<UIImage *> * _Nonnull artworkArray;
@property (nonatomic, copy) NSIndexPath * _Nonnull currentIndexPath;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidLoad;
- (void)loadAlbums;
- (void)didReceiveMemoryWarning;
- (void)stopListeningForClickwheelChanges;
- (void)startListeningForClickwheelChanges;
- (void)clickWheelDidMoveUpWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelDidMoveDownWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)menuClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)tableView:(UITableView * _Nonnull)tableView didHighlightRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIWindow;
@class UIApplication;

SWIFT_CLASS("_TtC13ClassicPlayer11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> * _Nullable)launchOptions SWIFT_WARN_UNUSED_RESULT;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13ClassicPlayer13ArtistsMenuVC")
@interface ArtistsMenuVC : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull menuItems;
@property (nonatomic, copy) NSIndexPath * _Nonnull currentIndexPath;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidLoad;
- (void)loadArtists;
- (void)didReceiveMemoryWarning;
- (void)stopListeningForClickwheelChanges;
- (void)startListeningForClickwheelChanges;
- (void)clickWheelDidMoveUpWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelDidMoveDownWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)menuClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)tableView:(UITableView * _Nonnull)tableView didHighlightRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIColor;
@class UITouch;
@class UIEvent;

SWIFT_CLASS("_TtC13ClassicPlayer13C2AClickWheel")
@interface C2AClickWheel : UIButton
@property (nonatomic, readonly) CGFloat π;
@property (nonatomic, strong) UIColor * _Nonnull wheelColor;
@property (nonatomic, strong) UIColor * _Nonnull buttonColor;
@property (nonatomic) BOOL feedbackSound;
@property (nonatomic) CGFloat arcWidth;
@property (nonatomic) NSInteger angle;
@property (nonatomic) CGRect frame;
@property (nonatomic) NSInteger counter;
@property (nonatomic, strong) UIButton * _Nullable centerButton;
@property (nonatomic, copy) NSURL * _Nullable soundURL;
@property (nonatomic) SystemSoundID soundID;
- (void)layoutSubviews;
- (void)drawRect:(CGRect)rect;
- (BOOL)continueTrackingWithTouch:(UITouch * _Nonnull)touch withEvent:(UIEvent * _Nullable)event SWIFT_WARN_UNUSED_RESULT;
- (double)AngleFromNorth:(CGPoint)p1 p2:(CGPoint)p2 flipped:(BOOL)flipped SWIFT_WARN_UNUSED_RESULT;
- (void)orientationChanged;
- (double)DegreesToRadians:(double)value SWIFT_WARN_UNUSED_RESULT;
- (double)RadiansToDegrees:(double)value SWIFT_WARN_UNUSED_RESULT;
- (CGFloat)Square:(CGFloat)value SWIFT_WARN_UNUSED_RESULT;
- (CGRect)calculateButtonFrame SWIFT_WARN_UNUSED_RESULT;
- (CGFloat)calculateCenterButtonSize:(CGFloat)width arcWidth:(CGFloat)arcWidth SWIFT_WARN_UNUSED_RESULT;
- (void)prepareSound;
- (void)playClickSound;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UILabel;
@class UIImageView;

SWIFT_CLASS("_TtC13ClassicPlayer14ImageTableCell")
@interface ImageTableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified cellTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified cellSubtitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified cellImageView;
- (void)awakeFromNib;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class MPMediaItem;

SWIFT_CLASS("_TtC13ClassicPlayer10MainMenuVC")
@interface MainMenuVC : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray<MPMediaItem *> * _Nonnull mediaItems;
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull menuItems;
@property (nonatomic, copy) NSIndexPath * _Nonnull currentIndexPath;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidLoad;
- (void)animateArtwork;
- (void)didReceiveMemoryWarning;
- (void)stopListeningForClickwheelChanges;
- (void)startListeningForClickwheelChanges;
- (void)clickWheelDidMoveUpWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelDidMoveDownWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)menuClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (void)loadAlbumArtwork;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13ClassicPlayer13MenuTableCell")
@interface MenuTableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified cellLabel;
- (void)awakeFromNib;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13ClassicPlayer11MusicMenuVC")
@interface MusicMenuVC : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull menuItems;
@property (nonatomic, copy) NSIndexPath * _Nonnull currentIndexPath;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)stopListeningForClickwheelChanges;
- (void)startListeningForClickwheelChanges;
- (void)clickWheelDidMoveUpWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelDidMoveDownWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)menuClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIProgressView;
@class MPMusicPlayerController;

SWIFT_CLASS("_TtC13ClassicPlayer12NowPlayingVC")
@interface NowPlayingVC : UIViewController
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified albumArt;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified songTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified artistTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified albumTitleLabel;
@property (nonatomic, weak) IBOutlet UIProgressView * _Null_unspecified songProgressBar;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified currentTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified totalTimeLabel;
@property (nonatomic, readonly, strong) MPMusicPlayerController * _Nonnull player;
- (void)viewWillAppear:(BOOL)animated;
- (void)updateNPView;
- (void)updateTimeElapsed;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)stopListeningForClickwheelChanges;
- (void)startListeningForClickwheelChanges;
- (void)clickWheelDidMoveUpWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelDidMoveDownWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)menuClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)songChangedWithNotification:(NSNotification * _Nonnull)notification;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13ClassicPlayer15PlaylistsMenuVC")
@interface PlaylistsMenuVC : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, readonly, copy) NSString * _Nonnull NO_PLAYLISTS;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull menuItems;
@property (nonatomic, copy) NSIndexPath * _Nonnull currentIndexPath;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidLoad;
- (void)loadPlaylists;
- (void)didReceiveMemoryWarning;
- (void)stopListeningForClickwheelChanges;
- (void)startListeningForClickwheelChanges;
- (void)clickWheelDidMoveUpWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelDidMoveDownWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)menuClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)tableView:(UITableView * _Nonnull)tableView didHighlightRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UISwitch;

SWIFT_CLASS("_TtC13ClassicPlayer28SettingsScreenViewController")
@interface SettingsScreenViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified aboutButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified doneButton;
@property (nonatomic, weak) IBOutlet UISwitch * _Null_unspecified darkModeToggle;
@property (nonatomic, weak) IBOutlet UISwitch * _Null_unspecified soundEffectsToggle;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (IBAction)dismissSettings:(id _Nonnull)sender;
- (IBAction)switchToggled:(id _Nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13ClassicPlayer17SettingsTableCell")
@interface SettingsTableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * _Nullable label;
@property (nonatomic, weak) IBOutlet UISwitch * _Nullable toggle;
- (void)awakeFromNib;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13ClassicPlayer10SettingsVC")
@interface SettingsVC : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView * _Null_unspecified menuTable;
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull menuItems;
@property (nonatomic, copy) NSIndexPath * _Nonnull currentIndexPath;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)stopListeningForClickwheelChanges;
- (void)startListeningForClickwheelChanges;
- (void)clickWheelDidMoveUpWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelDidMoveDownWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)menuClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIView;

SWIFT_CLASS("_TtC13ClassicPlayer14SongListMenuVC")
@interface SongListMenuVC : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified alphabetView;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified alphabetViewLabel;
@property (nonatomic, copy) NSString * _Nullable filter;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidLoad;
- (void)searchSongsWithLetter:(NSString * _Nonnull)letter;
- (void)loadSongsWithFilter:(NSString * _Nonnull)filter;
- (void)didReceiveMemoryWarning;
- (void)setAlphabetLetterWithLetter:(NSString * _Nonnull)letter;
- (void)toggleAlphabetView;
- (void)buildAlphabetArray;
- (void)stopListeningForClickwheelChanges;
- (void)startListeningForClickwheelChanges;
- (void)clickWheelDidMoveUpWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelDidMoveDownWithNotification:(NSNotification * _Nonnull)notification;
- (void)clickWheelClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)menuClickedWithNotification:(NSNotification * _Nonnull)notification;
- (void)tableView:(UITableView * _Nonnull)tableView didHighlightRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSNotification;

SWIFT_CLASS("_TtC13ClassicPlayer23StatusBarViewController")
@interface StatusBarViewController : UIViewController
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified timeLabel;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified batteryImage;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)updateTime;
- (float)batteryLevel SWIFT_WARN_UNUSED_RESULT;
- (UIDeviceBatteryState)batteryState SWIFT_WARN_UNUSED_RESULT;
- (void)batteryStateDidChangeWithNotification:(NSNotification * _Nonnull)notification;
- (void)batteryLevelDidChangeWithNotification:(NSNotification * _Nonnull)notification;
- (void)updateBatteryImage;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13ClassicPlayer14ViewController")
@interface ViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified menuButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified rewindButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified forwardButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified playButton;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified menuScreenContainerView;
@property (nonatomic, weak) IBOutlet C2AClickWheel * _Null_unspecified clickWheel;
@property (nonatomic, readonly) BOOL isMultipleTouchEnabled;
@property (nonatomic) NSInteger counter;
- (void)setupClickWheel;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidLoad;
- (void)settingsUpdatedWithNotification:(NSNotification * _Nonnull)notification;
- (void)refreshView;
- (void)didReceiveMemoryWarning;
- (IBAction)clickWheelValueChanged:(C2AClickWheel * _Nonnull)sender;
- (IBAction)centerClicked:(C2AClickWheel * _Nonnull)sender;
@property (nonatomic, readonly, strong) MPMusicPlayerController * _Nonnull player;
- (IBAction)menuPressed:(id _Nonnull)sender;
- (IBAction)forwardPressed:(id _Nonnull)sender;
- (IBAction)rewindPressed:(id _Nonnull)sender;
- (IBAction)playPausePressed:(id _Nonnull)sender;
- (void)postClickWheelDidMoveUpNotification;
- (void)postClickWheelDidMoveDownNotification;
- (void)postClickWheelClickedNotification;
- (void)postMenuPressedNotification;
- (void)postSongChangedNotification;
- (void)vibrate;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
