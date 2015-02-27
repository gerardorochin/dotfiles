#!/usr/bin/env bash
#
# OSX
#
# The original idea (and a couple settings) were grabbed from:
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# Sets reasonable OS X defaults.
#

set -e

echo -e "OSX"

echo -e "Create symbolic link ssh"
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/ssh .ssh

os=`uname`
    if [[ $os == "Darwin" ]]; then
    # Ask for the administrator password upfront
    sudo -v

    ###############################################################################
    # General UI/UX                                                               #
    ###############################################################################

    # Set computer name (as done via System Preferences → Sharing)
    sudo scutil --set ComputerName "0x4B1D"
    sudo scutil --set HostName "0x4B1D"
    sudo scutil --set LocalHostName "0x4B1D"

    # Menu bar: hide the Time Machine, Volume, User, and Bluetooth icons
    for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
        defaults write "${domain}" dontAutoLoad -array \
            "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
            "/System/Library/CoreServices/Menu Extras/Volume.menu" \
            "/System/Library/CoreServices/Menu Extras/User.menu"
    done
    defaults write com.apple.systemuiserver menuExtras -array \
        "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
        "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
        "/System/Library/CoreServices/Menu Extras/Battery.menu" \
        "/System/Library/CoreServices/Menu Extras/Clock.menu"

    # Save to disk (not to iCloud) by default
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

    # Disable the “Are you sure you want to open this application?” dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false

    # Reveal IP address, hostname, OS version, etc. when clicking the clock
    # in the login window
    sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

    # Never go into computer sleep mode
    sudo systemsetup -setcomputersleep Off > /dev/null

    ###############################################################################
    # Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
    ###############################################################################

    # Set a really fast key repeat.
    defaults write NSGlobalDomain KeyRepeat -int 0

    # Use scroll gesture with the Ctrl (^) modifier key to zoom
    defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
    defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

    # Follow the keyboard focus while zoomed in
    defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

    # Set language and text formats
    # Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
    # `Inches`, `en_GB` with `en_US`, and `true` with `false`.
    defaults write NSGlobalDomain AppleLanguages -array "en" "es"
    defaults write NSGlobalDomain AppleLocale -string "en_US@currency=MXN"
    defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
    defaults write NSGlobalDomain AppleMetricUnits -bool true

    # Set the timezone; see `sudo systemsetup -listtimezones` for other values
    sudo systemsetup -settimezone "America/Mazatlan" > /dev/null

    # Stop iTunes from responding to the keyboard media keys
    launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

    ###############################################################################
    # Screen                                                                      #
    ###############################################################################

    # Save screenshots to the desktop
    defaults write com.apple.screencapture location -string "${HOME}/Desktop"

    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png"


    ###############################################################################
    # Finder                                                                      #
    ###############################################################################

    # Finder: show status bar
    defaults write com.apple.finder ShowStatusBar -bool true

    # Finder: show path bar
    defaults write com.apple.finder ShowPathbar -bool true

    # When performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Avoid creating .DS_Store files on network volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # Disable disk image verification
    defaults write com.apple.frameworks.diskimages skip-verify -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

    # Enable snap-to-grid for icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

    # Increase grid spacing for icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

    # Increase the size of icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

    # Use AirDrop over every interface. srsly this should be a default.
    defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

    ###############################################################################
    # Dock, Dashboard, and hot corners                                            #
    ###############################################################################

    # Enable highlight hover effect for the grid view of a stack (Dock)
    defaults write com.apple.dock mouse-over-hilite-stack -bool true

    # Set the icon size of Dock items to 36 pixels
    defaults write com.apple.dock tilesize -int 36

    # Change minimize/maximize window effect
    defaults write com.apple.dock mineffect -string "scale"

    # Minimize windows into their application’s icon
    defaults write com.apple.dock minimize-to-application -bool true

    # Enable spring loading for all Dock items
    defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

    # Show indicator lights for open applications in the Dock
    defaults write com.apple.dock show-process-indicators -bool true

    # Don’t animate opening applications from the Dock
    defaults write com.apple.dock launchanim -bool false

    # Don’t automatically rearrange Spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false

    # Automatically hide and show the Dock
    defaults write com.apple.dock autohide -bool true

    # Make Dock icons of hidden applications translucent
    defaults write com.apple.dock showhidden -bool true


    ###############################################################################
    # Time Machine                                                                #
    ###############################################################################

    # Prevent Time Machine from prompting to use new hard drives as backup volume
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    # Disable local Time Machine backups
    hash tmutil &> /dev/null && sudo tmutil disablelocal

    ###############################################################################
    # Activity Monitor                                                            #
    ###############################################################################

    # Show the main window when launching Activity Monitor
    defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

    # Visualize CPU usage in the Activity Monitor Dock icon
    defaults write com.apple.ActivityMonitor IconType -int 5

    # Show all processes in Activity Monitor
    defaults write com.apple.ActivityMonitor ShowCategory -int 0

    # Sort Activity Monitor results by CPU usage
    defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
    defaults write com.apple.ActivityMonitor SortDirection -int 0

    ###############################################################################
    # Kill affected applications                                                  #
    ###############################################################################

    for app in "Activity Monitor" \
        "Dock" "Finder" "SystemUIServer"; do 
        killall "${app}" > /dev/null 2>&1
    done

    echo -e "Done. Note that some of these changes require a logout/restart to take effect.\n"
else
    echo -e "OS not Supported\n"
fi
