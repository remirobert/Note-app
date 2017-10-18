platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

TARGET_APP                  = 'App'
TARGET_APP_TEST             = 'AppTests'
TARGET_DOMAIN               = 'Domain'
TARGET_DOMAIN_TESTS         = 'DomainTests'
TARGET_WIREFRAME            = 'Wireframe'
TARGET_WIREFRAME_TESTS      = 'WireframeTests'
TARGET_REALMPLATFORM        = 'RealmPlatform'
TARGET_REALMPLATFORM_TESTS  = 'RealmPlatformTests'

def shared_pods
    pod 'RealmSwift'
    pod 'SnapKit'
    pod 'IQKeyboardManagerSwift'
    pod 'Texture'
    pod 'ImagePicker'
end

def shared_tests_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'FBSnapshotTestCase'
end

target TARGET_APP do
    shared_pods
end

target TARGET_APP_TEST do
    shared_pods
    shared_tests_pods
end

target TARGET_DOMAIN do
    shared_pods
end

target TARGET_DOMAIN_TESTS do
    shared_pods
    shared_tests_pods
end

target TARGET_WIREFRAME do
    shared_pods
end

target TARGET_WIREFRAME_TESTS do
    shared_pods
    shared_tests_pods
end

target TARGET_REALMPLATFORM do
    shared_pods
end

target TARGET_REALMPLATFORM_TESTS do
    shared_pods
    shared_tests_pods
end
