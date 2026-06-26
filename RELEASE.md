# Release Process

## Steps to publish a new version of dcb-library-ios

### 1. Update version number

Edit `Sources/dcb-library-ios/Utils/PackageInfo.swift` and bump the version:

```swift
struct PackageInfo {
    static let version = "1.0.1" // update this
}
```

### 2. Commit your changes

```bash
git add -A
git commit -m "Release v1.0.1"
```

### 3. Tag the release

```bash
git tag 1.0.1
```

### 4. Push to remote

```bash
git push origin main
git push origin 1.0.1
```

### 5. Create GitHub Release

#### Option A: Using GitHub CLI

```bash
gh release create 1.0.1 --title "v1.0.1" --notes "Release notes here" --repo spense-fintech/dcb-library-ios
```

> First time? Run `gh auth login` to authenticate.

#### Option B: Using GitHub UI

1. Go to https://github.com/spense-fintech/dcb-library-ios/releases
2. Click **"Draft a new release"**
3. Choose the tag (e.g. `1.0.1`)
4. Set title: `v1.0.1`
5. Add release notes describing what changed
6. Click **"Publish release"**

This will auto-generate Source code (zip) and Source code (tar.gz) assets.

---

## Consuming the library (Swift Package Manager)

Add to your Xcode project:

```
https://github.com/spense-fintech/dcb-library-ios.git
```

Version rule: **Up to Next Major** from the latest tag.
