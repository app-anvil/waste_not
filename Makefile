SHELL=/bin/bash

.SHELLFLAGS = -ec
.ONESHELL:

# Color escape sequences
R := $(shell tput setaf 1) # red
G := $(shell tput setaf 2) # green
Y := $(shell tput setaf 3) # yellow
C := $(shell tput setaf 6) # cyan
r := $(shell tput sgr0) # reset the color to default

# Formatting functions
ok = @printf '$(G)✔ $(1)$(r)\n'
err = @printf '$(R)✕ $(1)$(r)\n'
h = @printf '$(C)>>> $(1)$(r)\n'
warn = @printf '$(Y)❕ $(1)$(r)\n'

FASTLANE_LANE := "dev"
FASTLANE_ENV := "development"

.PHONY: format # Fix and reformat lib folder.
format:
	@fvm dart fix ./app/lib --apply
	@fvm dart format ./app/lib

.PHONY: publish-ios # Executes the whole workflow to publish the app to the iOS App Store.
publish-ios: format
	$(call h,Publishing iOS app on the Apple App Store...)
	@cd app/ios
	@pod install
	@bundle install
	@bundle exec fastlane $(FASTLANE_LANE) --env $(FASTLANE_ENV)
	$(call ok,iOS app published on the App Store)