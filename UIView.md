# 概述

- `UIView` 表示屏幕上的一块矩形区域，负责渲染区域的内容，并且响应该区域内发生的触摸事件。它在 iOS App 中占有绝对重要的地位，因为 iOS 中几乎所有可视化控件都是 `UIView` 的子类。
- `UIView` 可以负责以下几种任务：
  - 布局和子视图管理
  - 绘制和动画
  - 事件处理

# 布局和显示

## Update Cycle

- Update cycle（drawing cycle）是当应用完成了所有事件处理代码后控制流回到主 RunLoop 时的那个时间点。正是在这个时间点上系统开始更新布局、显示和设置约束。

  ![](https://tva1.sinaimg.cn/large/0081Kckwgy1gks5z03kehj30u00uxagk.jpg)

- 如果在处理事件的代码中请求修改了一个 view，那么系统就会把这个 view 标记为需要重画（redraw）。在接下来的 Update cycle 中，系统就会执行这些 view 上的更改。但是由于在处理事件和对应 view 重画间存在着一个间隔，RunLoop 中的某时刻的 view 更新可能不是实时的。如果代码中的某些计算依赖于当下的 view 内容或者是布局，那么就有在过时 view 信息上操作的风险。

- 用户交互和布局更新间的延迟几乎不会被用户察觉到。iOS 应用一般以 60 fps 的速度展示动画，每个更新周期只需要 1/60 秒。这个更新的过程很快，所以用户在和应用交互时感觉不到 UI 中的更新延迟。

## 布局

- **一个视图的布局指的是它在屏幕上的的大小和位置。**

- **setNeedsLayout**

  - **标记为需要重新布局，但是布局视图的方法 `layoutSubviews` 需要等到下一个绘制周期执行，并非调用该方法立即执行。**

- **layoutIfNeeded**

  - **立即布局被标记需要重新布局的视图**。
  - 使用接收消息的视图作为根视图，开始遍历子视图树，如果存在被标记的视图，则立即调用 `layoutSubviews`。
  - 当使用 Auto Layout 且通过修改 constraint 进行动画时：在 animation block 之前可调用 `layoutIfNeeded` 以确保在动画开始之前更新所有的布局；在 animation block 中设置新 constrait 后需要再次调用 `layoutIfNeeded` 来动画到新的状态。

- **layoutSubviews**

  - 作用：自动布局达不到效果时才有必要重写，可以对子视图的 `frame` 进行布局。

    - 需要调用 `[super layoutSubviews]`。
    - 使用 Auto Layou 对子视图进行重新布局时，使子视图的 constraints 失效的代码必须在调用  `[super layoutSubviews]` 之前执行。

  - 不要直接调用这个方法（开销很大，因为它会在每个子视图上起作用并且调用它们的这一方法），由系统调用：

    - 调用 `setNeedsLayout` 时，触发 `layoutSubviews`；

    - 调用 `layoutIfNeeded` 时如果存在被标记的视图，立即触发 `layoutSubviews`；

    - `init` + `setFrame:` 或 `initWithFrame:` 后再被 `addSubview`；

      > 根据是否挡住状态栏决定（当状态栏显示时 `frame.origin.y >= 20` 即不被挡住）： 
      >
      > - `size == 0` 且未挡住：不触发任何方法；
      >
      > - `size != 0` 且未挡住：触发 `layoutSubviews`；
      >
      > - `size == 0` 且挡住：触发 `setNeedsLayout -> layoutSubviews`；
      >
      > - `size != 0` 且挡住：触发 `setNeedsLayout -> layoutSubviews -> layoutSubviews`；
      >
      > 总结：初始化时挡住状态栏，则触发一次 `setNeedsLayout -> layoutSubviews`，设置后的 `size != 0`，则触发一次 `layoutSubviews`。

    - 修改 frame；

      > 修改前的 `size == 0` 且未挡住，设置后：
      > - `size == 0` 且未挡住：不触发任何方法；
      > - `size != 0` 且未挡住：触发 `layoutSubviews`；
      > - `size == 0` 且挡住：触发 `setNeedsLayout -> layoutSubviews`；
      > - `size != 0` 且挡住：触发 `setNeedsLayout -> layoutSubviews`；
      >
      > 修改前的 `size != 0` 且未挡住，设置后：
      > - `size == 0` 且未挡住：触发 `layoutSubviews`；
      > - `size != 0` 且未挡住：触发 `layoutSubviews`；
      > - `size == 0` 且挡住：触发 `setNeedsLayout -> layoutSubviews`；
      > - `size != 0` 且挡住：触发 `setNeedsLayout -> layoutSubviews`；
      >
      > 修改前的 `size == 0` 且挡住，设置后：
      > - `size == 0` 且未挡住：触发 `setNeedsLayout -> layoutSubviews`；
      > - `size != 0` 且未挡住：触发 `setNeedsLayout -> layoutSubviews`；
      > - `size == 0` 且挡住：触发 `setNeedsLayout -> layoutSubviews`；
      > - `.size != 0` 且挡住：触发 `setNeedsLayout -> layoutSubviews`；
      >
      > 修改前的 `size != 0` 且挡住，设置后：
      > - `size == 0` 且未挡住：触发 `setNeedsLayout -> layoutSubviews`；
      > - `size != 0` 且未挡住：触发 `setNeedsLayout -> layoutSubviews`；
      > - `size == 0` 且挡住：触发 `setNeedsLayout -> layoutSubviews`；
      > - `.size != 0` 且挡住：触发 `setNeedsLayout -> layoutSubviews`；

    - 添加或移除子视图，触发 `layoutSubviews`；

    - 旋转屏幕，触发 `setNeedsLayout -> layoutSubviews`；

    - 滚动一个 `UIScrollView` 引发 `UIView` 的重新布局，触发 `layoutSubviews`；

## 绘制

- **一个视图的绘制包含了颜色、文本、图片和 Core Graphics 绘制等视图属性。**

- **setNeedsDisplay**

  - **标记为需要重新绘制，但是绘制视图的方法 `drawRect: ` 需要等到下一个绘制周期执行，并非调用该方法立即执行。**
  - 系统触发：`[UIView initWithFrame:]` ，`[UIView(Hierarchy) _setBackgroundColor:]` 等方法执行后。
  - **主动调用本方法：自定义一个视图子类并重写了 `drawRect:` 方法，需要触发 `drawRect:` 方法以重新绘制内容**。

- **drawRect:**

    - 作用：重写以实现自定义的绘制内容。

      - 如果子类直接继承自 `UIView`，则不需要调用 super 方法；如果子类继承自其他 View 类，则需要调用 super 方法。
      - `UIImageView` 不能重写本方法用于实现自定义绘图。

    - 不要直接调用这个方法（对内存的消耗比较大），由系统调用：

      - `setNeedsDisplay` 或 `setNeedsDisplayInRect:` 方法异步触发，但视图的 size 不能为0。
      - 视图的 `contentMode` 属性值为 `UIViewContentModeRedraw`，更改视图的 size 时触发。
      - 调用 `sizeThatFits` 后，视图的 size 发生改变时会触发。

    - 重写示例：

      - 使用 `UIBezierPath`

      ```objective-c
      - (void)drawRect:(CGRect)rect {
          UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
          UIColor *fillColor = [UIColor blueColor];
          [fillColor set];
          [path fill];
      }
      ```
      - 使用 `contextRef`

      ```objective-c
      - (void)drawRect:(CGRect)rect {
        	// 获取绘制视图的contextRef，在其他方法中获取的contextRef都是不生效的
          CGContextRef context = UIGraphicsGetCurrentContext();
          CGContextSetFillColor(context, CGColorGetComponents(_fillColor.CGColor));
          CGContextFillRect(context, rect);
      }
      ```

- `CALayer` 的几个相关方法：
  - `setNeedsDisplay` 标记 Layer 需要绘制；
  - `displayIfNeeded` 立即对标记 Layer 进行绘制；
  - 绘制时依次检测 `display`、delegate 的 `displayLayer:`、`drawInContext:`、delegate 的`drawLayer:inContext:`，其中任何一个方法实现了，就认为已经为 Layer 提供了内容，进行绘制。
  - 和 View 的方法的关系：
    - 重写 View 的 `drawRect:` 后， `setNeedsDisplay` 方法会调用 Layer 的 `setNeedsDisplay` 方法；
    - 重写 View 的 `drawRect:` 后，View 的 `drawRect:` 方法是由 Layer 的 delegate 的 `drawLayer:inContext:` 调用的；若检测方法不是系统实现时（重写或实现），View 的 `drawRect:` 方法不会被触发。
    - 因此，当使用检测方法进行绘制时，必须要重写一个空方法 `drawRect:`。

- 内存暴增：一旦实现了 `CALayerDelegate` 协议中的 `drawLayer:inContext:` 方法或者 `UIView` 中的 `drawRect:` 方法（其实就是前者的包装方法），图层就创建了一个绘制上下文，这个上下文需要的内存为：图层宽 x 图层高x 4字节。

## Auto Layout

- Auto Layout 通过约束来描述视图间的关系，能够动态地根据外部和内部的变化来修改布局：

    - 外部因素：屏幕旋转、iPad 分屏、不同尺寸的屏幕等；
    - 内部因素：文本或图片内容变化、支持多语言等。
- **Auto Layout 本质就是一个表示视图关系的线性方程解析**。基于Auto Layout的布局，不在需要像 frame 时代一样，关注视图尺寸、位置的常数，转而关注视图之间关系，描述一个表示视图间布局关系的约束集合，并解析出最终数值。

- `UIView` 的属性 `translatesAutoresizingMaskIntoConstraints` 表示可以把 frame ，bouds，center 方式布局的视图自动转化为约束形式。若使用 Auto Layout 方式布局时，需要将其设置为 NO。

### 布局约束

  - 布局约束 `NSLayoutConstraint` 指定视图的几何特征，要么直接指定视图的位置和尺寸，要么将其与其它视图进行关联来确定位置和尺寸；

    ![](https://tva1.sinaimg.cn/large/0081Kckwgy1gks44i2legj30tc0ci74v.jpg)

    ```objective-c
    /**
    item1 ：要约束的控件
    attr1 ：约束的类型（做怎样的约束）
    relation ：与参照控件之间的关系
    item2 ：参照的控件
    attr2 ：约束的类型（做怎样的约束）
    multiplier ：乘数
    constant ：常量
    */
    + (instancetype)constraintWithItem:(id)item1
                             attribute:(NSLayoutAttribute)attr1
                             relatedBy:(NSLayoutRelation)relation
                                toItem:(nullable id)item1
                             attribute:(NSLayoutAttribute)attr2
                            multiplier:(CGFloat)multiplier
                              constant:(CGFloat)constant
    ```

- 添加约束：在创建约束之后，需要将其添加到作用的 view 上。 目标 view 需要遵循以下规则：

    - 以固定值设置视图尺寸时，添加到视图之上；
    - 对于两个同层级视图之间的约束关系，应该添加到它们的父视图之上；
    - 对于两个不同层级视图之间的约束关系，应该添加到它们最近的共同父视图上；
    - 对于有层次关系的两个视图之间的约束关系，添加到层次较高的父视图上。

    ```objective-c
    // 约束添加函数
    - (void)addConstraint:(NSLayoutConstraint *)constraint;
    - (void)addConstraints:(NSArray<__kindof NSLayoutConstraint *> *)constraints;
    ```

- 激活约束：在 ios 8 之后，可以不用通过约束添加函数使约束生效，可以直接设置约束的 `active` 属性设置为 YES，使其生效。即：

    - 设置属性 `active = YES` 或 `[NSLayoutConstraint activateConstraints:]` 会让该约束的 view 调用 `addConstraint:`。
    - 设置属性 `active = NO` 或  `[NSLayoutConstraint deactivateConstraints:]` 会让该约束的 view 调用 `removeConstraint:`；


- 约束动画：通过修改约束来设置动画效果时，必须在修改后执行 `layoutIfNeeded` 才能显示动画效果。

    ```objective-c
    [UIView animateWithDuration:1 animations:^{
    	  // 1.使之前的约束失效
        top1.active = NO;
        NSLayoutConstraint *top2 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:400];
        // 2.使新设置的约束生效
        top2.active = YES;
                
        // 3.使立即重新布局
        [self.view layoutIfNeeded];
    }];
    ```

### 优先级

- 约束还有 1 ~ 1000 的优先级，优先级为1000的约束为必须满足，优先级为 1 ~ 999 的约束为可选约束，数字越大其优先级越高，其满足的可能性越高。

- 自动布局系统在满足了所有优先级为 1000 的约束后，会按照优先级从高到低的顺序满足可选约束。

- 默认情况下，所有约束优先级都是 1000，即必须满足。

  ```objective-c
  static const UILayoutPriority UILayoutPriorityRequired = 1000; 
  static const UILayoutPriority UILayoutPriorityDefaultHigh = 750; 
  static const UILayoutPriority UILayoutPriorityDefaultLow = 250;
  static const UILayoutPriority UILayoutPriorityFittingSizeLevel = 50; 
  ```

### 内容大小约束

- 一般情况下，视图的布局约束包括位置和尺寸两个因素。但拥有内在内容大小的视图，只需要设置位置约束即可，Auto Layout会根据视图的自然尺寸，自动设置尺寸约束，这就是内在内容尺寸 **Intrinsic Content Size**，它描述的是视图内容（文字、图片等）在不压缩不拉伸情况下展示出来的自然尺寸。

  > `UIView `没有 IntrinsicContentSize；
  >
  > `UISlider` 在 iOS 下 IntrinsicContentSize 只定义了 width；
  >
  > `UILabel`、`UIButton`的 IntrinsicContentSize 同时存在 width、height；
  >
  > `UIImageView` 的 IntrinsicContentSize是动态变化的，当没有设置 image 没有 IntrinsicContentSize（-1，-1），当设置了 image，则 IntrinsicContentSize 就是设置的 image 对应的 Size;
  >
  > `UITextView` 的 IntrinsicContentSize 也是动态变化的，它相对复杂，与内容、是否可滚动、约束相关。

- 每个视图都有内容压缩阻力优先级 **Content Compression Resistance Priority** 和内容吸附性优先级 **Content Hugging Priority**。但只有当视图定义了内部内容尺寸后（默认为 -1,-1），这两种优先级才会起作用。

  - 当内部尺寸发生变化后，需要调用 `invalidateIntrinsicContentSize` 方法通知系统。
  - 如果内部尺寸只有一个维度是固定值，则可设置另外一个未知维度值为  `UIViewNoIntrinsicMetric` 。

  ```objective-c
  // 重写此函数，设置内部尺寸
  - (CGSize)intrinsicContentSize {
      return CGSizeMake(100, 100);
  }
  ```

- **压缩阻力**是指视图阻止其大小被压缩到小于其内部内容尺寸的优先级，即视图反压缩的优先级（默认750）。-

  - 优先级越大，视图就越不容易被压小。
  - 当自动布局系统为所有视图布局时，遇到约束要求该视图的尺寸需要小于其内部内容尺寸会用到。

- **内容吸附**是指视图阻止其大小被拉伸到大于其内部内容尺寸的优先级，即视图反拉伸的优先级（默认250）。

  - 优先级越大，视图就越不容易被拉大。
  - 当自动布局系统为所有视图布局时，遇到约束要求该视图的尺寸需要大于其内部内容尺寸会用到。

### 约束更新

- **setNeedsUpdateConstraints**
  - **标记为需要重新更新约束，但是更新约束的方法 `updateConstraints` 需要等到下一个绘制周期执行，并非调用该方法立即执行。**
- **updateConstraintsIfNeeded**
  - **立即更新被标记需要更新约束的视图**。

- **updateConstraints**
  - 作用：重写本方法以实现约束的更新。
    - 需要在最后调用 `[super updateConstraints]`。
  - 不要直接调用这个方法 ，由系统调用。

# 动画

- `UIView` 动画实质上是对 Core Animation 的封装，提供简洁的动画接口。

- `UIView` 动画可以设置的动画属性有：
  - 坐标尺寸属性：`frame`、`bounds`、`center`
  - 显示属性：` backgroundColor `、`alpha `、`hidden`
  - 形态属性：`transform`、`contentStretch`

# 触摸传递和响应

1. APP 进程的 mach port 接受到 SpringBoard 进程传递来的触摸事件，主线程的 RunLoop 被唤醒，触发了 source1 回调。
2. source1 回调又触发了一个 source0 回调，将接收到的 IOHIDEvent 对象封装成 `UIEvent` 对象，此时 APP 将**正式开始对于触摸事件的响应**。
3. **source0 回调内部将触摸事件添加到 UIApplication 对象的事件队列中。事件出队后，UIApplication 开始一个寻找第一响应者的过程，这个过程又称 Hit-Testing 传递链**。
4. **寻找到最佳响应者（第一响应者）后，事件开始在响应链中的进行传递及响应，即响应链**。
5. 触摸事件要么被某个响应对象捕获后释放，要么没能找到能够响应的对象而最终释放。至此，这个触摸事件的使命终结。RunLoop 若没有其他事件需要处理，也将重归于眠，等待新的事件到来后唤醒。

## Hit-Testing

- **Hit-Testing（命中测试）用于寻找事件的最佳响应者，即选择一个 hit-test（命中测试视图），优先将事件传递给它供其响应。**

  ![](https://tva1.sinaimg.cn/large/0081Kckwgy1gkt2ul3hq4j30yy0gpjt6.jpg)

- 寻找流程：

  - 采用深度优先的反序访问迭代算法（先访问根节点然后从高到低访问低节点），以向 `UIWindow`（视图层次结构的根视图）发送 `hitTest:withEvent:` 消息开始。
    - `hitTest:withEvent:` 方法返回视图对象，返回值不为 nil 时表示该视图可以响应该事件。
  - 触摸点在视图范围内才有机会成为命中测试视图，即 `pointInside:withEvent:` 方法返回 YES。
  - 以下三种情况的视图不能成为命中测试视图：
    - 不允许交互：`userInteractionEnabled = NO`；
    - 隐藏：`hidden = YES`；
    - 透明度：`alpha < 0.01`。

  - 假设视图 A 满足以上条件，若其
    - 无子视图：A 为命中测试视图；
    - 有子视图：按加入顺序，从后往前遍历所有子视图，若
      - 所有子视图都不满足条件：A 为命中测试视图；
      - 子视图 A1 满足条件：对 A1 继续执行本判断。

  ```objective-c
  - (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
      return CGRectContainsPoint(self.bounds, point);
  }
  
  - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
      // 1.判断自己能否接收触摸事件
      if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
          return nil;
      }
      // 2.判断触摸点在不在自己范围内
      if ([self pointInside:point withEvent:event]) {
          // 3.从后往前遍历自己的子控件，看是否有子控件更适合响应此事件
          for (UIView *subView in [self.subviews reverseObjectEnumerator]) {
              CGPoint childPoint = [self convertPoint:point toView:subView];
              UIView *fitView = [subView hitTest:childPoint withEvent:event];
              if (fitView) {
                  // 找到合适的子视图
                  return fitView;
              }
          }
          // 没有找到比自己更合适的view
          return self;
      }
      return nil;
  }
  ```

## 响应

  - Hit-Tesing 寻找的命中测试视图称为**最佳响应者（第一响应者），但它不等于最终响应者**。之所以称之为“最佳”，是因为其具备响应事件的最高优先权。最佳响应者首先接收到事件，然后便拥有了对事件的绝对控制权：即它可以选择独吞这个事件，也可以将这个事件往下传递给其他响应者，这个由响应者构成的链就称之为**响应链**。

- 每个响应者都是一个 `UIResponder` 对象，即所有派生自 `UIResponder` 的对象，本身都具备响应事件的能力。包括 `UIView`、`UIViewController`、`UIApplication`、`AppDelegate`。

- 响应者之所以能响应事件，因为 `UIResponder` 对象提供了4个处理触摸事件的方法：

  ```objective-c
  // 手指触碰屏幕，触摸开始
  - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
  // 手指在屏幕上移动
  - (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
  // 手指离开屏幕，触摸结束
  - (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
  // 触摸结束前，某个系统事件中断了触摸，例如电话呼入
  - (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
  ```

- **响应者对于事件的操作方式**：响应者对于事件的拦截以及传递都是通过 `touchesBegan:withEvent:` 方法控制的：

  - 不拦截：默认操作，事件会自动沿着默认的响应链往下传递；
  - 拦截，不再往下分发事件：重写此方法并做自身处理，不调用 `[nextResponder touchesBegan:withEvent:]`；
  - 拦截，继续往下分发事件：重写此方法并做自身处理，调用 `[nextResponder touchesBegan:withEvent:]`；

- **响应链中的事件传递规则**：每一个响应者对象（`UIResponder` 对象）都有一个 `nextResponder` 方法，用于获取响应链中当前对象的下一个响应者。因此，一旦事件的最佳响应者确定了，这个事件所处的响应链就确定了。对于响应者对象，默认的 `nextResponder` 实现如下：

  - `UIView`：若视图是控制器的根视图，则其下一响应者为控制器对象；否则，其下一响应者为父视图；
  - `UIViewController`：若控制器的视图是 `window` 的根视图，则其下一响应者为窗口对象；若控制器是从别的控制器 present 出来的，则其下一响应者为 presenting view controller；
  - `UIWindow`：其下一响应者为 `UIApplication` 对象；
  - `UIApplication`：若当前应用的 app delegate 是一个 `UIResponder` 对象，且不是 `UIView`、`UIViewController` 或 app 本身，则其下一响应者为 app delegate。

  ![](https://tva1.sinaimg.cn/large/0081Kckwgy1gkt4qazu3tj30jg0bsdfs.jpg)

### 手势识别器与触摸

- **手势识别器比响应链具有更高的事件响应优先级**：事件首先传递给手势识别器，再传给响应者。一旦有手势识别器成功识别了手势，就会取消响应者（第一响应者）对事件的响应。

  ```objective-c
  [UITapGestureRecognizer touchesBegan:withEvent:]
  [UIView touchesBegan:withEvent:]
  [UITapGestureRecognizer touchesEnded:withEvent:]
  actionTap //手势响应函数
  [UIView touchesCancelled:withEvent:]
  ```

  > 手势识别器通过 `touchesBegan:withEvent:` 等方法来响应事件，但它并不是 `UIResponder` 的子类，相关的方法声明在 `UIGestureRecognizerSubclass.h` 中。

- 手势识别器的三个相关属性：

  - `cancelsTouchesInView`：手势识别器成功识别了手势之后，是否会取消响应者对事件的响应，只有识别失败才不会取消。默认为 YES，会取消，即触发 `[UIView touchesCancelled:withEvent:]`；
  - `delaysTouchesBegan`：手势识别器成功识别了手势之后，是否会拦截响应者对事件的响应，只有识别失败才不会拦截。默认为 NO，不会拦截，即触发 `[UIView touchesBegan:withEvent:]`；
  - `delaysTouchesEnded`：手势识别器识别失败后，是否会延迟0.15ms后再发送 `touchesEnded:withEvent:]`。默认为 YES，会延迟。

  ```objective-c
  //测试用例
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
  // 当tap次数少于2时，则手势识别失败
  tap.numberOfTapsRequired = 2;
  //tap.cancelsTouchesInView = NO;
  //tap.delaysTouchesBegan = YES;
  //tap.delaysTouchesEnded = YES;
  ```

### UIControl 

- `UIControl` 继承于 `UIView`，即也是 `UIResponse` 的子类。但其具有自己特殊的触摸跟踪方式：

  ```objective-c
  - (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event;
  // 滑动手势
  - (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event;
  - (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event;
  - (void)cancelTrackingWithEvent:(nullable UIEvent *)event;
  ```

- `UIControl` 子类包括 `UIButton`、`UITextField`、`UISlider`、`UIDatePicker`、`UIPageControl`、`UISegmentedControl` 等。

- `UIControl` 触摸跟踪方式注重根据触摸状态修改属性，如自定义高亮模式等，而通用处理触摸事件注重于事件处理。

  ```objective-c
  - (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
  		// 触摸开始，设置蓝色高亮
      [super setBackgroundColor:[UIColor blueColor]];
      return [super beginTrackingWithTouch:touch withEvent:event];
  }
  - (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
  		// 触摸结束，恢复红色
      [super setBackgroundColor:[UIColor redColor]];
      [super endTrackingWithTouch:touch withEvent:event];
  }
  ```

  