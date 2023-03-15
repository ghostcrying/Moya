<p align="center">
  <img height="160" src="web/logo_github.png" />
</p>


# Fork Moya

Origin link: https://github.com/Moya/Moya.git

Moya纯净版本代码, 去除Rx, Combine相关使用



## Installation

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
pod 'Moya', :git => 'https://github.com/ghostcrying/Moya.git', :tag => '1.0.0'
```

然后运行 `pod install`。

在任何你想使用 Moya 的文件中，使用 `import Moya` 导入框架。

### Carthage

Carthage 用户可以指向这个仓库并使用他们喜欢的生成框架，`Moya`

在你的 Cartfile 中添加下面的代码：

```
github "ghostcrying/Moya" ~> 1.0.0
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
