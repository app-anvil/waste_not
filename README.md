# Waste NOT! - Your food waste reduction companion 
  
[![GitHub Release](https://img.shields.io/github/v/release/app-anvil/waste_not)](https://github.com/app-anvil/a2f_sdk/releases)
[![License](https://img.shields.io/github/license/app-anvil/waste_not)](https://opensource.org/licenses/MIT)
[![GitHub Issues](https://img.shields.io/github/issues/app-anvil/waste_not.svg)](https://github.com/app-anvil/waste_not/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/app-anvil/waste_not.svg)](https://github.com/app-anvil/waste_not/pulls)

A food waste reduction app that helps users track their food inventory and expiration dates.

## Table of Contents

- [Useful links](#useful-links)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)

## Useful links

- [Wiki](wiki)

## Installation

Instructions on how to install and run the project.

## Usage

Instructions on how to use the project.

## Contributing

Closed.

## Structure

### App

- `app`: Contains the main application code.

### Congig fastlane
Inside the `app/ios/fastlane` folder create these `env` files: 
- `.env.default`
- `.env.development`
- `.env.staging`
- `.env.production`

The content of the `.env.default` must be
```
APPLE_ID=the username of the app store connect account
TEAM_ID=
ITC_TEAM_ID=
APPSTORE_KEY_ID=find it in the app store connect keys section 
APPSTORE_ISSUER_ID=find it in the app store connect keys section 
P8_FILE_PATH=
```
The get the `ITC_TEAM_ID`:
1. Login to App Store Connect (https://appstoreconnect.apple.com/)
2. Get output (JSON) from (https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/user/detail)
3. You can now get your iTunes Connect ids from the associatedAccounts array with the different contentProvider objects - the entry named contentProviderId reflects the iTunes Connect id, lookup for the name value to pick the correct one

Source: https://github.com/fastlane/fastlane/issues/4301#issuecomment-253461017

Other env files must be included only the `APP_ID` (the identifier of the app e.g com.anvil.waste.dev)

Use the Makefile to deploy the apps.

```
make publish-ios
make FASTLANE_LANE=stg FASTLANE_ENV=staging publish-ios
make FASTLANE_LANE=prod FASTLANE_ENV=production publish-ios
```

N.B. `make` must be used at the root of the project

### Apple App Certificates
To get the all our certificates and provisioning profiles needed to build and sign our applications. They are encrypted using OpenSSL via a passphrase.

Navigate to your project folder and run
```
fastlane match appstore
```
```
fastlane match development
```

See: https://docs.fastlane.tools/actions/match/

The fastlane guide: https://medium.com/@muhammedqazi/mastering-fastlane-the-ultimate-guide-to-effortless-android-and-ios-deployments-with-github-e0878c3f9529