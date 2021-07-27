#!/usr/bin/env bash
#
# OSX
#
# The original idea (and a couple settings) were grabbed from:
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# Sets reasonable OS X defaults.
#

set -ex

echo -e "OSX"

echo -e "* Create symbolic link ssh"
ln -sf ~/Library/Mobile\ Documents/com~apple~CloudDocs/ssh ~/.ssh
ln -sf ~/Library/Mobile\ Documents/com~apple~CloudDocs/gnupg ~/.gnupg

os=`uname`
    if [[ $os == "Darwin" ]]; then
    # Ask for the administrator password upfront
    sudo -v

    ###############################################################################
    # General UI/UX                                                               #
    ###############################################################################

    echo -e "* Set computer name (as done via System Preferences → Sharing)"
    sudo scutil --set ComputerName "0x4B1D"
    sudo scutil --set HostName "0x4B1D"
    sudo scutil --set LocalHostName "0x4B1D"

    echo -e "* Disable Guest user"
    sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool NO

    echo -e "* Disable System UI Audio Sound Effects"
    defaults write com.apple.systemsound "com.apple.sound.uiaudio.enabled" -int 0

    echo -e "* Set Clock to 12 hours"
    defaults write com.apple.menuextra.clock "DateFormat" "h:mm"

    echo -e "* Menu bar: hide the Time Machine, Volume, User, and Bluetooth icons"
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

    echo -e "* Save to disk (not to iCloud) by default"
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

    echo -e "* Disable the “Are you sure you want to open this application?” dialog"
    defaults write com.apple.LaunchServices LSQuarantine -bool false

    echo -e "* Reveal IP address, hostname, OS version, etc. when clicking the clock # in the login window"
    sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

    echo -e "* Never go into computer sleep mode"
    sudo systemsetup -setcomputersleep Off > /dev/null

    ###############################################################################
    # Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
    ###############################################################################

    echo -e "* Set a really fast key repeat."
    defaults write NSGlobalDomain KeyRepeat -int 0

    echo -e "* Use scroll gesture with the Ctrl (^) modifier key to zoom"
    defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
    defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

    echo -e "* Disable press-and-hold for keys in favor of key repeat"
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    echo -e "* Set a blazingly fast keyboard repeat rate"
    defaults write NSGlobalDomain KeyRepeat -int 0

    echo -e "* Follow the keyboard focus while zoomed in"
    defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

    echo -e "* Set language and text formats"
    # Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
    # `Inches`, `en_GB` with `en_US`, and `true` with `false`.
    defaults write NSGlobalDomain AppleLanguages -array "en" "es"
    defaults write NSGlobalDomain AppleLocale -string "en_US@currency=MXN"
    defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
    defaults write NSGlobalDomain AppleMetricUnits -bool true

    echo -e "* Set the timezone"
    sudo systemsetup -settimezone "America/Mazatlan" > /dev/null

    echo -e "* Stop iTunes from responding to the keyboard media keys"
    launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

    ###############################################################################
    # Screen                                                                      #
    ###############################################################################

    echo -e "* Save screenshots to the desktop"
    defaults write com.apple.screencapture location -string "${HOME}/Desktop"

    echo -e "* Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
    defaults write com.apple.screencapture type -string "png"


    ###############################################################################
    # Finder                                                                      #
    ###############################################################################

    echo -e "* Finder: show status bar"
    defaults write com.apple.finder ShowStatusBar -bool true

    echo -e "* Finder: show path bar"
    defaults write com.apple.finder ShowPathbar -bool true

    echo -e "* When performing a search, search the current folder by default"
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    echo -e "* Disable the warning when changing a file extension"
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    echo -e "* Avoid creating .DS_Store files on network volumes"
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    echo -e "* Disable disk image verification"
    defaults write com.apple.frameworks.diskimages skip-verify -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

    echo -e "* Enable snap-to-grid for icons on the desktop and in other icon views"
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

    echo -e "* Increase grid spacing for icons on the desktop and in other icon views"
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

    echo -e "* Increase the size of icons on the desktop and in other icon views"
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

    echo -e "* Use AirDrop over every interface. srsly this should be a default."
    defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

    ###############################################################################
    # Dock, Dashboard, and hot corners                                            #
    ###############################################################################

    echo -e "* Enable highlight hover effect for the grid view of a stack (Dock)"
    defaults write com.apple.dock mouse-over-hilite-stack -bool true

    echo -e "* Set the icon size of Dock items to 36 pixels"
    defaults write com.apple.dock tilesize -int 36

    echo -e "* Change minimize/maximize window effect"
    defaults write com.apple.dock mineffect -string "scale"

    echo -e "* Minimize windows into their application’s icon"
    defaults write com.apple.dock minimize-to-application -bool true

    echo -e "* Enable spring loading for all Dock items"
    defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

    echo -e "* Show indicator lights for open applications in the Dock"
    defaults write com.apple.dock show-process-indicators -bool true

    echo -e "* Don’t animate opening applications from the Dock"
    defaults write com.apple.dock launchanim -bool false

    echo -e "* Don’t automatically rearrange Spaces based on most recent use"
    defaults write com.apple.dock mru-spaces -bool false

    echo -e "* Automatically hide and show the Dock"
    defaults write com.apple.dock autohide -bool true

    echo -e "* Make Dock icons of hidden applications translucent"
    defaults write com.apple.dock showhidden -bool true


    ###############################################################################
    # Time Machine                                                                #
    ###############################################################################

    echo -e "* Prevent Time Machine from prompting to use new hard drives as backup volume"
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    echo -e "* Disable local Time Machine backups"
    hash tmutil &> /dev/null && sudo tmutil disable

    ###############################################################################
    # Activity Monitor                                                            #
    ###############################################################################

    echo -e "* Show the main window when launching Activity Monitor"
    defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

    echo -e "* Visualize CPU usage in the Activity Monitor Dock icon"
    defaults write com.apple.ActivityMonitor IconType -int 5

    echo -e "* Show all processes in Activity Monitor"
    defaults write com.apple.ActivityMonitor ShowCategory -int 0

    echo -e "* Sort Activity Monitor results by CPU usage"
    defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
    defaults write com.apple.ActivityMonitor SortDirection -int 0

    echo -e "Done. Note that some of these changes require a logout/restart to take effect.\n"
else
    echo -e "OS not Supported\n"
fi
