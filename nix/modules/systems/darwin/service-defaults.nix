{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  ##: Hostname
  system.defaults.smb.NetBIOSName = config.my.hostname;
  system.defaults.smb.ServerDescription = config.my.hostname;

  ###: APPEARANCE ==============================================================

  # `null`  => normal mode
  # `Dark`  => dark mode
  # TODO: use this to change dark mode on the fly with `specialisation`?
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
  # Whether light/dark modes are toggled automatically.
  system.defaults.NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = false;
  # Sets the level of font smoothing (sub-pixel font rendering).
  system.defaults.NSGlobalDomain.AppleFontSmoothing = 0;
  system.defaults.universalaccess.reduceTransparency = true;

  ###: SOUND ==================================================================

  # Make a feedback sound when the system volume changed. This setting accepts
  # the integers 0 or 1. Defaults to 1.
  system.defaults.NSGlobalDomain."com.apple.sound.beep.feedback" = 0;
  # 75% => 0.7788008 ; 50% => 0.6065307 ; 25% => 0.4723665
  system.defaults.NSGlobalDomain."com.apple.sound.beep.volume" = null;

  ###: LOCALE ==================================================================

  system.defaults.NSGlobalDomain.AppleMeasurementUnits = "Centimeters";
  system.defaults.NSGlobalDomain.AppleMetricUnits = 1;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.AppleTemperatureUnit = "Fahrenheit";

  ###: UPDATES/SECURITY/FIREWALL ================================================================

  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
  # Prevent nagging when opening downloaded apps.
  system.defaults.LaunchServices.LSQuarantine = false;
  system.defaults.alf.allowdownloadsignedenabled = 0;
  system.defaults.alf.allowsignedenabled = 1;
  system.defaults.alf.globalstate = 1;
  system.defaults.alf.loggingenabled = 0;
  system.defaults.alf.stealthenabled = 0;

  ###: DESKTOPS/SPACES/DOCK ====================================================

  system.defaults.dock.autohide = true;
  system.defaults.dock.autohide-delay = 0.1;
  system.defaults.dock.autohide-time-modifier = 0.1;
  system.defaults.dock.dashboard-in-overlay = false;
  system.defaults.dock.enable-spring-load-actions-on-all-items = false;
  system.defaults.dock.expose-animation-duration = 0.1;
  system.defaults.dock.expose-group-by-app = false;
  system.defaults.dock.launchanim = false;
  system.defaults.dock.mineffect = "genie";
  system.defaults.dock.minimize-to-application = true;
  system.defaults.dock.mouse-over-hilite-stack = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.show-process-indicators = true;
  system.defaults.dock.show-recents = false;
  system.defaults.dock.showhidden = true;
  system.defaults.dock.static-only = true;
  system.defaults.dock.tilesize = 16;

  system.defaults.spaces.spans-displays = true;

  ##: Corner hot actions
  # 1 => Disabled
  # 2 => Mission Control
  # 3 => Application Windows
  # 4 => Desktop
  # 5 => Start Screen Saver
  # 6 => Disable Screen Saver
  # 7 => Dashboard
  # 10 => Put Display to Sleep
  # 11 => Launchpad
  # 12 => Notification Center
  # 13 => Lock Screen
  # 14 => Quick Note
  system.defaults.dock.wvous-bl-corner = 5;
  system.defaults.dock.wvous-br-corner = 1;
  system.defaults.dock.wvous-tl-corner = 1;
  system.defaults.dock.wvous-tr-corner = 1;

  ###: WINDOW MANAGER / FINDER =================================================

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.AppleShowAllFiles = true;
  # Whether to display icons on the desktop.
  system.defaults.finder.CreateDesktop = false;
  system.defaults.finder.FXDefaultSearchScope = null;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;
  # "icnv" => Icon view
  # "Nlsv" => List view
  # "clmv" => Column View
  # "Flwv" => Gallery View
  system.defaults.finder.FXPreferredViewStyle = "Nlsv";
  system.defaults.finder.QuitMenuItem = false;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.ShowStatusBar = true;
  system.defaults.finder._FXShowPosixPathInTitle = false;

  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
  # Set the size of the finder sidebar icons
  # 1 => small; 2 => medium; 3 => large
  system.defaults.NSGlobalDomain.NSTableViewDefaultSizeMode = 1;
  system.defaults.NSGlobalDomain.NSTextShowsControlCharacters = true;
  # Disable the over-the-top focus ring animation
  system.defaults.NSGlobalDomain.NSUseAnimatedFocusRing = false;
  system.defaults.NSGlobalDomain.NSWindowResizeTime = 0.001;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;
  # Set the spring loading delay for directories. The default is the float `1.0`.
  system.defaults.NSGlobalDomain."com.apple.springing.delay" = 0.1;
  # Enable spring loading (expose) for directories.
  system.defaults.NSGlobalDomain."com.apple.springing.enabled" = true;

  ###: LOGIN ===================================================================

  system.defaults.loginwindow.DisableConsoleAccess = false;
  system.defaults.loginwindow.GuestEnabled = false;
  # Text to be shown on the login window. Default "\\U03bb".
  # system.defaults.loginwindow.LoginwindowText = null;
  system.defaults.loginwindow.PowerOffDisabledWhileLoggedIn = false;
  system.defaults.loginwindow.RestartDisabled = false;
  system.defaults.loginwindow.RestartDisabledWhileLoggedIn = false;
  system.defaults.loginwindow.SHOWFULLNAME = false;
  system.defaults.loginwindow.ShutDownDisabled = false;
  system.defaults.loginwindow.ShutDownDisabledWhileLoggedIn = false;
  system.defaults.loginwindow.SleepDisabled = true;
  system.defaults.loginwindow.autoLoginUser = null;

  ###: POINTING ================================================================

  # 0 to enable Silent Clicking, 1 to disable. The default is 1.
  system.defaults.trackpad.ActuationStrength = 1;
  # Whether to enable trackpad tap to click. The default is false.
  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.Dragging = false;
  # For normal click: 0 for light clicking, 1 for medium, 2 for firm. The default is 1.
  system.defaults.trackpad.FirstClickThreshold = 1;
  # For force touch: 0 for light clicking, 1 for medium, 2 for firm. The default is 1.
  system.defaults.trackpad.SecondClickThreshold = 1;
  system.defaults.trackpad.TrackpadRightClick = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  ##: Enables swiping left or right with two fingers to navigate backward or forward.
  system.defaults.NSGlobalDomain.AppleEnableMouseSwipeNavigateWithScrolls = true;
  system.defaults.NSGlobalDomain.AppleEnableSwipeNavigateWithScrolls = true;

  system.defaults.magicmouse.MouseButtonMode = "TwoButton";
  # Show scroll bars when an external mouse or trackball is connected.
  system.defaults.NSGlobalDomain.AppleShowScrollBars = "Automatic";
  system.defaults.NSGlobalDomain.NSScrollAnimationEnabled = true;
  # Configures the trackpad tap behavior. Mode 1 enables tap to click.
  system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  # Disable "Natural" scrolling direction.
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  # Whether to enable trackpad secondary click.
  system.defaults.NSGlobalDomain."com.apple.trackpad.enableSecondaryClick" = true;
  # Configures the trackpad tracking speed (0 to 3). The default is 1.0.
  system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 1.0;
  # Configures the trackpad corner click behavior. Mode 1 enables right click.
  # https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.com.apple.trackpad.trackpadCornerClickBehavior
  system.defaults.NSGlobalDomain."com.apple.trackpad.trackpadCornerClickBehavior" = null;
  system.defaults.universalaccess.closeViewScrollWheelToggle = true;
  system.defaults.universalaccess.closeViewZoomFollowsFocus = true;

  ###: KEYBOARD ===================================================================

  # Configures the keyboard control behavior. Mode 3 enables full keyboard control.
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;
  # Whether to use F1, F2, etc. keys as standard function keys.
  system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.nonUS.remapTilde = false;
  system.keyboard.remapCapsLockToControl = false;
  system.keyboard.remapCapsLockToEscape = true;
  system.keyboard.swapLeftCommandAndLeftAlt = false;

  ###: PROCESSES / ACTIVITY MONITOR ========================================================

  # Disable automatic termination of "inactive" apps.
  system.defaults.NSGlobalDomain.NSDisableAutomaticTermination = true;

  # 0 => Application Icon
  # 2 => Network Usage
  # 3 => Disk Activity
  # 5 => CPU Usage
  # 6 => CPU History
  system.defaults.ActivityMonitor.IconType = 5;
  system.defaults.ActivityMonitor.OpenMainWindow = true;
  # 100 => All Processes
  # 101 => All Processes, Hierarchally
  # 102 => My Processes
  # 103 => System Processes
  # 104 => Other User Processes
  # 105 => Active Processes
  # 106 => Inactive Processes
  # 107 => Windowed Processes
  system.defaults.ActivityMonitor.ShowCategory = 100;
  system.defaults.ActivityMonitor.SortColumn = "CPUUsage";
  # 0 => descending
  system.defaults.ActivityMonitor.SortDirection = 0;

  ###: MISC ====================================================================

  system.defaults.CustomSystemPreferences = {};
  system.defaults.CustomUserPreferences = {};

  system.defaults.screencapture.disable-shadow = true;
  # The filesystem path to which screencaptures should be written.
  system.defaults.screencapture.location = "~/media/screenshots";
  system.defaults.screencapture.type = "png";

  # The following settings are not configurable via nix-darwin
  my.hm.user.home.activation.macosDefaults = inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Finder - Set $HOME as the default location for new windows
    /usr/bin/defaults write com.apple.finder NewWindowTarget -string "PfDe"
    /usr/bin/defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME"

    # Finder - Show the $HOME/Library folder
    /usr/bin/chflags nohidden $HOME/Library

    # Finder - Show the /Volumes folder
    /usr/bin/chflags nohidden /Volumes

    # Finder - Show hidden files
    /usr/bin/defaults write com.apple.finder AppleShowAllFiles -bool true

    # Finder - Show path bar
    /usr/bin/defaults write com.apple.finder ShowPathbar -bool true

    # Finder - Show status bar
    /usr/bin/defaults write com.apple.finder ShowStatusBar -bool true

    # Finder - Use list view in all Finder windows
    /usr/bin/defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    # Finder - Disable the warning before emptying the Trash
    /usr/bin/defaults write com.apple.finder WarnOnEmptyTrash -bool false

    # Finder - Allow text selection in Quick Look
    /usr/bin/defaults write com.apple.finder QLEnableTextSelection -bool true

    # Dock - No bouncing icons
    /usr/bin/defaults write com.apple.dock no-bouncing -bool true

    # Bluetooth - Increase sound quality for headphones/headsets
    /usr/bin/defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

    # Dashboard - Disable Dashboard
    /usr/bin/defaults write com.apple.dashboard mcx-disabled -bool true

    # Printer - Automatically quit printer app once the print jobs complete
    /usr/bin/defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

    # Safari - Enable debug menu
    /usr/bin/defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    # Safari - Enable the Develop menu and the Web Inspector
    /usr/bin/defaults write com.apple.Safari IncludeDevelopMenu -bool true
    /usr/bin/defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    /usr/bin/defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

    # Safari - Add a context menu item for showing the Web Inspector in web views
    /usr/bin/defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

    # Safari - Disable sending search queries to Apple
    /usr/bin/defaults write com.apple.Safari UniversalSearchEnabled -bool false
    /usr/bin/defaults write com.apple.Safari SuppressSearchSuggestions -bool true

    # Safari - Press Tab to highlight each item on a web page
    /usr/bin/defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
    /usr/bin/defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

    # Safari - Show the full URL in the address bar (note: this still hides the scheme)
    /usr/bin/defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

    # Safari - Set home page to `about:blank` for faster loading
    /usr/bin/defaults write com.apple.Safari HomePage -string "about:blank"

    # Safari - Prevent Safari from opening ‘safe’ files automatically after downloading
    /usr/bin/defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

    # Safari - Allow hitting the Backspace key to go to the previous page in history
    /usr/bin/defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

    # Safari - Hide the bookmarks bar by default
    /usr/bin/defaults write com.apple.Safari ShowFavoritesBar -bool false

    # Safari - Hide Safari’s sidebar in Top Sites
    /usr/bin/defaults write com.apple.Safari ShowSidebarInTopSites -bool false

    # Safari - Disable thumbnail cache for History and Top Sites
    /usr/bin/defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

    # Safari - Make Safari’s search banners default to Contains instead of Starts With
    /usr/bin/defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

    # Safari - Remove useless icons from Safari’s bookmarks bar
    /usr/bin/defaults write com.apple.Safari ProxiesInBookmarksBar "()"

    # Safari - Enable continuous spellchecking
    /usr/bin/defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

    # Safari - Disable auto-correct
    /usr/bin/defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

    # Safari - Warn about fraudulent websites
    /usr/bin/defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

    # Safari - Disable Java
    /usr/bin/defaults write com.apple.Safari WebKitJavaEnabled -bool false
    /usr/bin/defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

    # Safari - Block pop-up windows
    /usr/bin/defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
    /usr/bin/defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

    # Safari - Disable auto-playing video
    /usr/bin/defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
    /usr/bin/defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
    /usr/bin/defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
    /usr/bin/defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

    # Safari Enable “Do Not Track”
    /usr/bin/defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

    # Safari - Update extensions automatically
    /usr/bin/defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

    # Safari - Set DuckDuckGo as the search engine
    /usr/bin/defaults write -g NSPreferredWebServices '{
      NSWebServicesProviderWebSearch = {
        NSDefaultDisplayName = DuckDuckGo;
        NSProviderIdentifier = "com.duckduckgo";
      };
    }'

    # Terminal - Only use UTF-8
    /usr/bin/defaults write com.apple.terminal StringEncodings -array 4

    # Terminal - Disable audible and visual bells
    #defaults write com.apple.terminal "Bell" -bool false
    #defaults write com.apple.terminal "VisualBell" -bool false

    # Terminal - Enable Secure Keyboard Entry
    # See: https://security.stackexchange.com/a/47786/8918
    /usr/bin/defaults write com.apple.terminal SecureKeyboardEntry -bool true

    # Terminal - Disable the annoying line marks
    /usr/bin/defaults write com.apple.Terminal ShowLineMarks -int 0

    # Time Machine - Prevent from prompting to use new hard drives as backup volume
    #defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    # Time Machine - Disable local Time Machine backups
    #hash tmutil &> /dev/null && sudo tmutil disable

    # Activity Monitor - Show the main window when launching
    /usr/bin/defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

    # Activity Monitor - Visualize CPU usage in the Dock icon
    /usr/bin/defaults write com.apple.ActivityMonitor IconType -int 5

    # Activity Monitor - Show all processes
    /usr/bin/defaults write com.apple.ActivityMonitor ShowCategory -int 0

    # Activity Monitor - Sort results by CPU usage
    /usr/bin/defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
    /usr/bin/defaults write com.apple.ActivityMonitor SortDirection -int 0

    # Handoff - Turn off handing off between devices and this host
    /usr/bin/defaults write com.apple.coreservices.useractivityd ActivityAdvertisingAllowed -bool no
    /usr/bin/defaults write com.apple.coreservices.useractivityd ActivityReceivingAllowed -bool no

    # TextEdit - Use plain text mode for new documents
    /usr/bin/defaults write com.apple.TextEdit RichText -int 0

    # TextEdit - Open and save files as UTF-8
    /usr/bin/defaults write com.apple.TextEdit PlainTextEncoding -int 4
    /usr/bin/defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

    # Disk Utility - Enable the debug menu
    /usr/bin/defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
    /usr/bin/defaults write com.apple.DiskUtility advanced-image-options -bool true

    # QuickTime Player - Auto-play videos when opened with QuickTime Player
    /usr/bin/defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

    # AirDrop - Use AirDrop over every interface
    /usr/bin/defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

    # Mac App Store - Enable the automatic update check
    /usr/bin/defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

    # Mac App Store - Download newly available updates in background
    /usr/bin/defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

    # Mac App Store - Check for software updates daily, not just once per week
    /usr/bin/defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

    # Mac App Store - Install System data files & security updates
    /usr/bin/defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

    # Mac App Store - Turn on app auto-update
    /usr/bin/defaults write com.apple.commerce AutoUpdate -bool true

    # Mac App Store - Allow to reboot machine on macOS updates
    /usr/bin/defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

    # Messages - Disable sound effects
    /usr/bin/defaults write com.apple.messageshelper.AlertsController PlaySoundsKey -bool false

    # Messages - Disable automatic emoji substitution (i.e. use plain text smileys)
    /usr/bin/defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

    # Messages - Disable smart quotes as it’s annoying for messages that contain code
    /usr/bin/defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

    # Messages - Disable continuous spell checking
    /usr/bin/defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

    # Photos - Prevent Photos from opening automatically when devices are plugged in
    /usr/bin/defaults write com.apple.ImageCapture disableHotPlug -bool true

    # Game Center - Disable Game Center.
    /usr/bin/defaults write com.apple.gamed Disabled -bool true
    /usr/bin/sudo /usr/bin/killall Finder
  '';
}
