本仓库基于 [chenfanfang/AvoidCrash](https://github.com/chenfanfang/AvoidCrash)。原库已长期停止维护，这里按自己的工程需要做了修改。当前 `master` 即正在使用的版本，SPM 标签为 `1.0.0`。许可仍是 MIT，版权声明见 `LICENSE`。

## 安装

Swift Package Manager。在 Xcode 中添加：

```
https://github.com/firestory/AvoidCrash.git
```

版本选择 `1.0.0`。产品名 `AvoidCrash`。

## 使用

在 `application:didFinishLaunchingWithOptions:` 里尽早调用。`becomeEffective` 默认不处理 `unrecognized selector sent to instance`。需要处理这类崩溃时用 `makeAllEffective`，并配合 `setupNoneSelClassStringsArr:`。

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AvoidCrash makeAllEffective];

    NSArray *noneSelClassStrings = @[
        @"NSNull",
        @"NSNumber",
        @"NSString",
        @"NSDictionary",
        @"NSArray"
    ];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dealwithCrashMessage:)
                                                 name:AvoidCrashNotification
                                               object:nil];
    return YES;
}

- (void)dealwithCrashMessage:(NSNotification *)note {
    // 崩溃信息都在 userInfo 里
    NSLog(@"%@", note.userInfo);
}
```

也可以只打开某一类：

```objc
[NSArray avoidCrashExchangeMethod];
[NSMutableArray avoidCrashExchangeMethod];
```

不建议用类名前缀的方式处理 unrecognized selector。

## 目前拦截的方法

- unrecognized selector sent to instance
- `NSArray`：`arrayWithObjects:count:`、下标取值、`objectAtIndex:`、`objectsAtIndexes:`、`getObjects:range:`
- `NSMutableArray`：下标取值与赋值、`objectAtIndex:`、`removeObjectAtIndex:`、`insertObject:atIndex:`、`objectsAtIndexes:`、`getObjects:range:`
- `NSDictionary`：`dictionaryWithObjects:forKeys:count:`
- `NSMutableDictionary`：`setObject:forKey:`、`removeObjectForKey:`
- `NSString`：`characterAtIndex:`、`substringFromIndex:`、`substringToIndex:`、`substringWithRange:`、`stringByReplacingOccurrencesOfString:` 及其带 options 的版本、`stringByReplacingCharactersInRange:withString:`
- `NSMutableString`：`replaceCharactersInRange:withString:`、`insertString:atIndex:`、`deleteCharactersInRange:`，以及继承自 `NSString` 的对应方法
- KVC：`setValue:forKey:`、`setValue:forKeyPath:`、`setValue:forUndefinedKey:`、`setValuesForKeysWithDictionary:`
- `NSAttributedString` / `NSMutableAttributedString` 的 `initWithString:`、`initWithAttributedString:`、`initWithString:attributes:`

## 注意

`@try @catch` 拦住崩溃后，个别方法可能有少量内存泄漏。代码本身不会崩溃时，不存在这个问题。
