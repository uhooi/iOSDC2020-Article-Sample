# 変数

PRODUCT_NAME := UhooiPicBook
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace
SCHEME_NAME := ${PRODUCT_NAME}
UI_TESTS_TARGET_NAME := ${PRODUCT_NAME}UITests

TEST_SDK := iphonesimulator
TEST_CONFIGURATION := Debug
TEST_PLATFORM := iOS Simulator
TEST_DEVICE ?= iPhone 11 Pro Max
TEST_OS ?= 13.6
TEST_DESTINATION := 'platform=${TEST_PLATFORM},name=${TEST_DEVICE},OS=${TEST_OS}'

.DEFAULT_GOAL := help

# 処理

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-26s%s\n", $$1 $$3, $$2}'

.PHONY: setup
setup: # 開発環境の構築
	$(MAKE) install-bundler
	$(MAKE) install-mint
	$(MAKE) install-carthage
	$(MAKE) generate-xcodeproj
	$(MAKE) open

.PHONY: install-bundler
install-bundler: # Bundlerで管理しているライブラリのインストール
	bundle config path vendor/bundle
	bundle install --jobs 4 --retry 3

.PHONY: install-mint
install-mint: # Mintで管理しているライブラリのインストール
	mint bootstrap

.PHONY: install-cocoapods
install-cocoapods: # CocoaPodsで管理しているライブラリのインストールとワークスペースの生成
	bundle exec pod install

.PHONY: install-carthage
install-carthage: # Carthageで管理しているライブラリのインストール
	mint run carthage carthage bootstrap --platform iOS --cache-builds

.PHONY: generate-xcodeproj
generate-xcodeproj: # プロジェクトの生成
	mint run xcodegen xcodegen generate
	$(MAKE) install-cocoapods # プロジェクトの生成後にワークスペースを生成する

.PHONY: open
open: # ワークスペースをXcodeで開く
	open ./${WORKSPACE_NAME}

.PHONY: build-debug
build-debug: # デバッグビルド
	set -o pipefail \
&& xcodebuild \
-sdk ${TEST_SDK} \
-configuration ${TEST_CONFIGURATION} \
-workspace ${WORKSPACE_NAME} \
-scheme ${SCHEME_NAME} \
build \
| bundle exec xcpretty

.PHONY: test
test: # 単体テスト
	set -o pipefail \
&& xcodebuild \
-sdk ${TEST_SDK} \
-configuration ${TEST_CONFIGURATION} \
-workspace ${WORKSPACE_NAME} \
-scheme ${SCHEME_NAME} \
-destination ${TEST_DESTINATION} \
-skip-testing:${UI_TESTS_TARGET_NAME} \
clean test \
| bundle exec xcpretty --report html
