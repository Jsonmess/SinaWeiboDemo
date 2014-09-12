/*
 公共类
*/
//如果宏存在结果等式，切记一定要加括号
//1.判断是否是iPhone5等4.0英寸屏幕设备
#define iPhone5_and_later ([UIScreen mainScreen].bounds.size.height==568)

//2.日志输出宏定义   用于在程序发布时候，自动过滤NSLog输出
#ifdef DEBUG
//调试状态
#define Debuglog(...) NSLog(__VA_ARGS__)
#else
//发布状态
#define Debuglog(...)
#endif