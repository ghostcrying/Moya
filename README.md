<p align="center">
  <img height="160" src="web/logo_github.png" />
</p>

# Moya 1.0.0

[![CircleCI](https://img.shields.io/circleci/project/github/Moya/Moya/master.svg)](https://circleci.com/gh/Moya/Moya/tree/master)
[![codecov.io](https://codecov.io/github/Moya/Moya/coverage.svg?branch=master)](https://codecov.io/github/Moya/Moya?branch=master)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Accio supported](https://img.shields.io/badge/Accio-supported-0A7CF5.svg?style=flat)](https://github.com/JamitLabs/Accio)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/Moya.svg)](https://cocoapods.org/pods/Moya)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)



你是个聪明的开发者。你可能使用 [Alamofire](https://github.com/Alamofire/Alamofire) 来抽象对 `URLSession` 的访问，以及所有那些你并不关心的糟糕细节。但是接下来，就像许多聪明开发者一样，你编写专有的网络抽象层，它们可能被称作 "APIManager" 或 "NetworkModel"，它们的下场总是很惨。

在 iOS app 中，专有网络层非常常见，但它们有以下缺点：

- 编写新项目很困难（「我从哪儿开始呢？」）
- 维护现有的项目很困难（「天啊，这一团糟……」）
- 编写单元测试很困难（「我该怎么做呢？」）

所以 Moya 的基本思想是，提供一些网络抽象层，它们经过充分地封装，并直接调用 Alamofire。它们应该足够简单，可以很轻松地应对常见任务，也应该足够全面，应对复杂任务也同样容易。

> 如果你使用 Alamofire 来抽象 `URLSession`, 那为什么不使用某些方式来进一步抽象 URLs 和 parameters 等等的本质呢？

Moya 的一些特色功能：

- 编译时检查正确的 API 端点访问。

- 允许你使用枚举关联值定义不同端点的明确用法。

- 将 test stub 视为一等公民，所以单元测试超级简单。

  

## 安装

### Swift Package Manager

> 注意: 以下的说明都未使用 Xcode 内嵌的 UI 版 **Swift PM**. 使用 **Swift PM** 的最简单的方式是找到 Project Setting -> Swift Packages 并将 Moya 添加在其中

要使用苹果的 Swift Package Manager 集成，将以下内容作为依赖添加到你的 `Package.swift`：

```swift
.package(url: "https://github.com/ghostcrying/Moya.git", .upToNextMajor(from: "1.0.0"))
```

然后指定 `"Moya"` 为你想要使用 Moya 的 Target 的依赖。如果你想要使用响应式扩展，将 `"ReactiveMoya"` 和 `"RxMoya"` 也也作为依赖加入进来。这里是一个 `PackageDescription` 实例：

```swift
// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MyPackage",
    products: [
        .library(
            name: "MyPackage",
            targets: ["MyPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ghostcrying/Moya.git", .upToNextMajor(from: "11.0.0"))
    ],
    targets: [
        .target(
            name: "MyPackage",
            dependencies: ["ReactiveMoya"])
    ]
)
```

### CocoaPods

在你的 Podfile 文件中添加 Moya：

```rb
pod 'Moya', '~> 1.0.0'
```

然后运行 `pod install`。

在任何你想使用 Moya 的文件中，使用 `import Moya` 导入框架。

### Carthage

Carthage 用户可以指向这个仓库并使用他们喜欢的生成框架，`Moya`，`RxMoya` 或者 `ReactiveMoya`。

在你的 Cartfile 中添加下面的代码：

```
github "Moya/Moya" ~> 1.0.0
```

然后运行 `carthage update --use-xcframeworks`。

## 用法

使用 Moya 相当简单。你可以用下边的方式访问一个 API：

```swift
provider = MoyaProvider<GitHub>()
provider.request(.zen) { result in
    switch result {
    case let .success(moyaResponse):
        let data = moyaResponse.data
        let statusCode = moyaResponse.statusCode
        // do something with the response data or statusCode
    case let .failure(error):
        // this means there was a network failure - either the request
        // wasn't sent (connectivity), or no response was received (server
        // timed out).  If the server responds with a 4xx or 5xx error, that
        // will be sent as a ".success"-ful response.
    }
}
```

这个一个基本示例。很多 API 请求都需要参数。Moya 将参数编码到 enum 中来访问端点，如下所示：

```swift
provider = MoyaProvider<GitHub>()
provider.request(.userProfile("ashfurrow")) { result in
    // do something with the result
}
```

URLs 不再有书写错误。不再会缺失参数值。也不再有混乱的参数编码。

更多示例可以查看 [documentation](https://github.com/Moya/Moya/blob/master/docs_CN/Examples)。
