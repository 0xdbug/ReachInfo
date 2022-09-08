#import "private/AppearanceSelectionTableCell.h"

@implementation AppearanceTypeStackView

- (AppearanceTypeStackView *)initWithType:(int)type forController:(AppearanceSelectionTableCell *)controller withImage:(UIImage *)image andText:(NSString *)text andSpecifier:(PSSpecifier *)specifier {
    self = [super init];
    if (self) {
        self.type = type;
        self.hostController = controller;

        self.key = specifier.properties[@"key"];
        self.postNotification = specifier.properties[@"PostNotification"];
        self.tintColor = specifier.properties[@"tintColor"];

        self.feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [self.feedbackGenerator prepare];

        self.defaults = [[NSUserDefaults alloc] initWithSuiteName:specifier.properties[@"defaults"]];
        [self.defaults registerDefaults:@{ self.key : @0 }];

        self.axis = UILayoutConstraintAxisVertical;
        self.alignment = UIStackViewAlignmentCenter;
        self.distribution = UIStackViewDistributionEqualSpacing;
        self.spacing = 8;
        self.translatesAutoresizingMaskIntoConstraints = false;

        self.iconView = [[UIImageView alloc] init];
        self.iconView.clipsToBounds = YES;
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconView.translatesAutoresizingMaskIntoConstraints = false;
        self.iconView.image = image;

        [self addArrangedSubview:self.iconView];
        [self.iconView.widthAnchor constraintEqualToConstant:55].active = true;

        self.captionLabel = [[UILabel alloc] init];
        self.captionLabel.text = text;
        [self.captionLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.captionLabel.heightAnchor constraintEqualToConstant:17].active = true;

        [self addArrangedSubview:self.captionLabel];

        if (@available(iOS 13.0, *)) {
            [self.captionLabel setTextColor:[UIColor labelColor]];
        } else {
            [self.captionLabel setTextColor:[UIColor blackColor]];
        }

        self.checkmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.checkmarkButton.translatesAutoresizingMaskIntoConstraints = false;
        self.checkmarkButton.selected = [[self.defaults objectForKey:self.key] intValue] == self.type;
        self.checkmarkButton.tintColor = (self.checkmarkButton.selected) ? (self.tintColor ? [UIColor colorFromHexString:self.tintColor] : [UIColor systemBlueColor]) : [UIColor systemGrayColor];
        [self.checkmarkButton.heightAnchor constraintEqualToConstant:20].active = true;
        [self.checkmarkButton.widthAnchor constraintEqualToConstant:20].active = true;

        [self.checkmarkButton setImage:[[UIImage kitImageNamed:@"UIRemoveControlMultiNotCheckedImage.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [self.checkmarkButton setImage:[[UIImage kitImageNamed:@"UITintedCircularButtonCheckmark.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
        [self.checkmarkButton addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addArrangedSubview:self.checkmarkButton];

        self.tapGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapped:)];
        self.tapGestureRecognizer.minimumPressDuration = 0.07;
        [self setUserInteractionEnabled:true];
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }

    return self;
}

- (void)buttonTapped:(UILongPressGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 0.5;
        } completion:^(BOOL finished) {}];
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 1;
            [self.hostController updateForType:self.type];
        } completion:^(BOOL finished) {}];

        [self.feedbackGenerator impactOccurred];

        [self.defaults setObject:[NSNumber numberWithInt:self.type] forKey:self.key];
        [self.defaults synchronize];

        if(self.postNotification) {
            CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)self.postNotification, NULL, NULL, true);
        }
    }
}

@end

@implementation AppearanceSelectionTableCell

- (AppearanceSelectionTableCell *)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

    if (self) {
        NSBundle *prefsBundle = [NSBundle bundleForClass:[specifier.target class]];
        self.options = specifier.properties[@"options"];

        self.containerScrollView = [[UIScrollView alloc] init];
        self.containerScrollView.translatesAutoresizingMaskIntoConstraints = false;

        self.containerStackView = [[UIStackView alloc] init];
        self.containerStackView.axis = UILayoutConstraintAxisHorizontal;
        self.containerStackView.alignment = UIStackViewAlignmentCenter;
        self.containerStackView.distribution = UIStackViewDistributionEqualSpacing;
        self.containerStackView.spacing = 20;
        self.containerStackView.translatesAutoresizingMaskIntoConstraints = false;

        for (NSDictionary *option in self.options) {
            AppearanceTypeStackView *stackView = [[AppearanceTypeStackView alloc] initWithType:[self.options indexOfObject:option]
                                                                                  forController:self
                                                                                  withImage:[UIImage imageNamed:option[@"image"] inBundle:prefsBundle compatibleWithTraitCollection:NULL]
                                                                                  andText:option[@"text"]
                                                                                  andSpecifier:specifier];
            [self.containerStackView addArrangedSubview:stackView];
            [stackView.topAnchor constraintEqualToAnchor:self.containerStackView.topAnchor constant:16].active = true;
            [stackView.bottomAnchor constraintEqualToAnchor:self.containerStackView.bottomAnchor constant:-16].active = true;
        }
        [self.contentView addSubview:self.containerScrollView];
        [self.containerScrollView addSubview:self.containerStackView];

        [self.containerScrollView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = true;
        [self.containerScrollView.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = true;

        [self.containerScrollView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = true;
        [self.containerScrollView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = true;

        [self.containerStackView.leadingAnchor constraintEqualToAnchor:self.containerScrollView.leadingAnchor].active = true;
        [self.containerStackView.trailingAnchor constraintEqualToAnchor:self.containerScrollView.trailingAnchor].active = true;
        [self.containerStackView.bottomAnchor constraintEqualToAnchor:self.containerScrollView.bottomAnchor].active = true;
        [self.containerStackView.topAnchor constraintEqualToAnchor:self.containerScrollView.topAnchor].active = true;
        [self.containerStackView.heightAnchor constraintEqualToAnchor:self.containerScrollView.heightAnchor].active = true;


    }

    return self;
}

- (AppearanceSelectionTableCell *)initWithSpecifier:(PSSpecifier *)specifier {
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AppearanceSelectionTableCell" specifier:specifier];
    return self;
}

- (void)updateForType:(int)type {
    for (AppearanceTypeStackView *subview in self.containerStackView.arrangedSubviews) {
        subview.checkmarkButton.selected = subview.type == type;
        subview.checkmarkButton.tintColor = (subview.checkmarkButton.selected) ? (subview.tintColor ? [UIColor colorFromHexString:subview.tintColor] : [UIColor systemBlueColor]) : [UIColor systemGrayColor];
    }
}

@end