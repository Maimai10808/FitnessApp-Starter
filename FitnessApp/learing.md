# learing

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

当然！下面我用你当前的 WorkoutDelegate 和两个控制器（WorkoutViewController 和 WorkoutResultsViewController）的实际代码来系统讲一遍 protocol（协议）+ delegate（代理）机制的用法和原理：

⸻

🧠 一句话总结

protocol + delegate 是 iOS中控制器/视图之间“反向传值”和“通知回调” 的首选方法。

⸻

✅ 你的例子中起作用的是：

protocol WorkoutDelegate: AnyObject {
    func dismissWorkout()
}

这句的意思是：
    •    定义了一个协议，叫做 WorkoutDelegate
    •    要求遵守这个协议的对象必须实现一个方法 dismissWorkout()
    •    AnyObject 表示：只能由类来遵守（不是 struct）

⸻

🧱 协议用在哪里？

1️⃣ WorkoutResultsViewController 定义了一个 弱引用的代理属性：

weak var workoutDelegate: WorkoutDelegate?

为什么用 weak？避免内存泄漏（避免循环引用）。

⸻

2️⃣ 在 WorkoutViewController 中实现了这个协议：

extension WorkoutViewController: WorkoutDelegate {
    func dismissWorkout() {
        dismiss(animated: true)
    }
}

也就是说，我（WorkoutViewController）是你的代理人，我知道怎么“结束锻炼”这个操作。

⸻

3️⃣ 建立代理关系（谁是“代表”）：

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "WorkoutResultsSegue" {
        let destinationVC = segue.destination as! WorkoutResultsViewController
        destinationVC.workoutDelegate = self  // ✅ 告诉结果页：“我就是你爸爸，有事找我！”
    }
}


⸻

4️⃣ 子页面中使用代理“通知父页面”：

@IBAction func submitButtonTapped(_ sender: Any) {
    dismiss(animated: true) {
        self.workoutDelegate?.dismissWorkout()
    }
}

意思是：

“我这个结果页面要关闭了，顺便叫一下 WorkoutDelegate 的 dismissWorkout() 方法。”

而你传入的 delegate = self 是 WorkoutViewController，所以就是它执行的 dismiss(animated:)。

⸻

🎯 所以，protocol + delegate 机制有什么作用？

✅ 把 页面B的动作，回调通知给页面A（甚至还能带参数）。

⸻

🧩 整体结构图解（通俗）：

WorkoutResultsViewController（子页面） -------(通知)-------> WorkoutViewController（父页面）

        持有一个 workoutDelegate
                       ↑
             实现了 WorkoutDelegate 协议


⸻

✅ 总结记忆法

步骤    关键词    解释
1    protocol    定义回调内容
2    delegate 属性    子控制器声明谁来“处理”这件事
3    = self    父控制器声明：我来当代表
4    delegate?.xxx()    子控制器调用回调方法
5    extension xxx: 协议名    父控制器实现协议方法


⸻
我们用“老师叫学生举手回答问题”这个生活化场景，类比讲解 iOS 中的 protocol + delegate 机制，让你真正理解：

⸻

🧠 类比角色设定：

场景角色    对应 iOS 概念    说明
老师    子控制器（如：WorkoutResultsViewController）    发起动作的人，想让别人干点事
学生    父控制器（如：WorkoutViewController）    接受通知，负责实际执行动作的人
举手回答问题的规则    protocol 协议    明确学生应该怎么回应老师
举手并回答    delegate?.方法()    老师发通知给学生，让学生“举手”


⸻

🧱 一步一步类比说明

🧩 第一步：老师定规则：谁想回答，必须先举手（定义 protocol）

protocol WorkoutDelegate: AnyObject {
    func dismissWorkout()
}

类比：

老师说：“如果我点你名，你必须先举手再回答，这就是规则。”

⸻

🧩 第二步：学生告诉老师：“我知道规则，我会照做”（实现协议）

extension WorkoutViewController: WorkoutDelegate {
    func dismissWorkout() {
        dismiss(animated: true)
    }
}

类比：

学生说：“老师，我已经学会怎么举手并回答了。”

⸻

🧩 第三步：上课前，老师记住哪个学生会举手（设置 delegate）

destinationVC.workoutDelegate = self

类比：

老师点名：“今天你坐在第一排，你来当我的答题代表。”
老师把这个学生记在小本本上（delegate 属性）。

⸻

🧩 第四步：老师发起动作：“某某，举手回答！”（调用 delegate 方法）

workoutDelegate?.dismissWorkout()

类比：

老师说：“好了，现在你来回答这个问题。”

⸻

🧩 第五步：学生举手并回答（执行实际方法）

func dismissWorkout() {
    dismiss(animated: true)
}

类比：

学生听到老师叫名，立刻站起来、举手、回答问题。

⸻

🧠 总结口诀记忆：

“老师发问，学生举手”
protocol 是规则，delegate 是老师随时可以点的学生
被点名的是谁？谁实现了协议，谁就能举手回应！

⸻

