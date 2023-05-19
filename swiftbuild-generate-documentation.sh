swift build -Xswiftc "-sdk" -Xswiftc "`xcrun --sdk iphonesimulator --show-sdk-path`" -Xswiftc "-target" -Xswiftc "x86_64-apple-ios13.0-simulator"
swift package --allow-writing-to-directory ./docs \
generate-documentation --target KyuGenericExtensions \
--disable-indexing \
--include-extended-types \
--transform-for-static-hosting \
--hosting-base-path KyuGenericExtensions \
--output-path ./docs
