Pod::Spec.new do |s|

  s.name        = "Heimdall"
  s.version     = "1.1.0"
  s.summary     = "Heimdall is a wrapper around the Security framework for simple encryption/decryption operations."
  s.license     = { :type => "MIT", :file => "LICENSE" }

  s.description = <<-DESC
                   Heimdall acts as a gatekeeper between UI and the underlying Security frameworks, offering
                   tools for encryption/decryption, as well as signing/verifying.

                   Heimdall supports both using a RSA public-private key-pair, as well as just a public key,
                   which allows for multiple parties to verify and encrypt messages for sending.
                   DESC

  s.homepage    = "https://github.com/henrinormak/Heimdall"

  s.author              = { "Henri Normak" => "henri.normak@gmail.com" }
  s.social_media_url    = "http://twitter.com/henrinormak"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/dworkvn/Heimdall.git", :branch => 'fix/missing-common-ctypto' }

  s.preserve_paths  = "CommonCrypto/*","Frameworks"
  s.source_files    = "Heimdall/*"
  s.requires_arc    = true

  s.xcconfig        = { "SWIFT_INCLUDE_PATHS" => "${PODS_ROOT}/Heimdall/Frameworks/$(PLATFORM_NAME)",
  "FRAMEWORK_SEARCH_PATHS" => "${PODS_ROOT}/Heimdall/Frameworks/$(PLATFORM_NAME)"
}

s.prepare_command = <<-CMD
  touch prepare_command.txt
  echo 'Running prepare_command'
  pwd
  echo Running GenerateCommonCryptoModule
  # This was needed to ensure the correct Swift interpreter was 
  # used in Xcode 8. Leaving it here, commented out, in case similar 
  # issues occur when migrating to Swift 4.0.
  #TC="--toolchain com.apple.dt.toolchain.Swift_2_3"
  SWIFT="xcrun $TC swift"
  $SWIFT ./GenerateCommonCryptoModule.swift macosx .
  $SWIFT ./GenerateCommonCryptoModule.swift iphonesimulator .
  $SWIFT ./GenerateCommonCryptoModule.swift iphoneos .
  $SWIFT ./GenerateCommonCryptoModule.swift appletvsimulator .
  $SWIFT ./GenerateCommonCryptoModule.swift appletvos .
  $SWIFT ./GenerateCommonCryptoModule.swift watchsimulator .
  $SWIFT ./GenerateCommonCryptoModule.swift watchos .
CMD

end
