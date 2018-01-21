//
//  MTTSignalHandlerManager.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/21.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "MTTSignalHandlerManager.h"
#import <libkern/OSAtomic.h>
#import <execinfo.h>
#import <stdatomic.h>
#import <UIKit/UIKit.h>
#import "MyTwitter-Swift.h"

// 未知异常错误
static NSString * const kUncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";

static NSString * const kUncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";

static NSString * const kUncaughtExceptionHandlerSignalAddressesKey = @"UncaughtExceptionHandlerSignalAddressesKey";

// 当前处理异常个数
volatile atomic_int kUncaughtExceptionCurrentCount = 0;

// 最多异常处理个数
volatile atomic_int kUncaughtExceptionMaximuCount = 10;

// 异常信号捕获处理函数
void SignalCatchHandler(int signal);

// 处理当前异常
void HandleCurrentException(NSException *exception);

@interface MTTSignalHandlerManager()

@property (nonatomic, assign) BOOL isQuit;

@end


@implementation MTTSignalHandlerManager

+ (MTTSignalHandlerManager *)signalHandlerManager
{
    static MTTSignalHandlerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MTTSignalHandlerManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init])
    {
        
        // 初始化工作
        
    }
    return self;
}

// 开始异常信号处理
- (void)startExceptionSignalHandler
{
    //注册异常
    NSSetUncaughtExceptionHandler(HandleCurrentException);
    
    //异常信号类型
    /***
     1) SIGHUP
     本信号在用户终端连接(正常或非正常)结束时发出, 通常是在终端的控制进程结束时, 通知同一session内的各个作业, 这时它们与控制终端不再关联。
     登录Linux时，系统会分配给登录用户一个终端(Session)。在这个终端运行的所有程序，包括前台进程组和后台进程组，一般都属于这个 Session。当用户退出Linux登录时，前台进程组和后台有对终端输出的进程将会收到SIGHUP信号。这个信号的默认操作为终止进程，因此前台进 程组和后台有终端输出的进程就会中止。不过可以捕获这个信号，比如wget能捕获SIGHUP信号，并忽略它，这样就算退出了Linux登录， wget也 能继续下载。
     此外，对于与终端脱离关系的守护进程，这个信号用于通知它重新读取配置文件。
     2) SIGINT
     程序终止(interrupt)信号, 在用户键入INTR字符(通常是Ctrl-C)时发出，用于通知前台进程组终止进程。
     3) SIGQUIT
     和SIGINT类似, 但由QUIT字符(通常是Ctrl-)来控制. 进程在因收到SIGQUIT退出时会产生core文件, 在这个意义上类似于一个程序错误信号。
     4) SIGILL
     执行了非法指令. 通常是因为可执行文件本身出现错误, 或者试图执行数据段. 堆栈溢出时也有可能产生这个信号。
     5) SIGTRAP
     由断点指令或其它trap指令产生. 由debugger使用。
     6) SIGABRT
     调用abort函数生成的信号。
     7) SIGBUS
     非法地址, 包括内存地址对齐(alignment)出错。比如访问一个四个字长的整数, 但其地址不是4的倍数。它与SIGSEGV的区别在于后者是由于对合法存储地址的非法访问触发的(如访问不属于自己存储空间或只读存储空间)。
     8) SIGFPE
     在发生致命的算术运算错误时发出. 不仅包括浮点运算错误, 还包括溢出及除数为0等其它所有的算术的错误。
     9) SIGKILL
     用来立即结束程序的运行. 本信号不能被阻塞、处理和忽略。如果管理员发现某个进程终止不了，可尝试发送这个信号。
     10) SIGUSR1
     留给用户使用
     11) SIGSEGV
     试图访问未分配给自己的内存, 或试图往没有写权限的内存地址写数据.
     12) SIGUSR2
     留给用户使用
     13) SIGPIPE
     管道破裂。这个信号通常在进程间通信产生，比如采用FIFO(管道)通信的两个进程，读管道没打开或者意外终止就往管道写，写进程会收到SIGPIPE信号。此外用Socket通信的两个进程，写进程在写Socket的时候，读进程已经终止。
     14) SIGALRM
     时钟定时信号, 计算的是实际的时间或时钟时间. alarm函数使用该信号.
     15) SIGTERM
     程序结束(terminate)信号, 与SIGKILL不同的是该信号可以被阻塞和处理。通常用来要求程序自己正常退出，shell命令kill缺省产生这个信号。如果进程终止不了，我们才会尝试SIGKILL。
     17) SIGCHLD
     子进程结束时, 父进程会收到这个信号。
     如果父进程没有处理这个信号，也没有等待(wait)子进程，子进程虽然终止，但是还会在内核进程表中占有表项，这时的子进程称为僵尸进程。这种情 况我们应该避免(父进程或者忽略SIGCHILD信号，或者捕捉它，或者wait它派生的子进程，或者父进程先终止，这时子进程的终止自动由init进程 来接管)。
     18) SIGCONT
     让一个停止(stopped)的进程继续执行. 本信号不能被阻塞. 可以用一个handler来让程序在由stopped状态变为继续执行时完成特定的工作. 例如, 重新显示提示符
     19) SIGSTOP
     停止(stopped)进程的执行. 注意它和terminate以及interrupt的区别:该进程还未结束, 只是暂停执行. 本信号不能被阻塞, 处理或忽略.
     20) SIGTSTP
     停止进程的运行, 但该信号可以被处理和忽略. 用户键入SUSP字符时(通常是Ctrl-Z)发出这个信号
     21) SIGTTIN
     当后台作业要从用户终端读数据时, 该作业中的所有进程会收到SIGTTIN信号. 缺省时这些进程会停止执行.
     22) SIGTTOU
     类似于SIGTTIN, 但在写终端(或修改终端模式)时收到.
     23) SIGURG
     有”紧急”数据或out-of-band数据到达socket时产生.
     24) SIGXCPU
     超过CPU时间资源限制. 这个限制可以由getrlimit/setrlimit来读取/改变。
     25) SIGXFSZ
     当进程企图扩大文件以至于超过文件大小资源限制。
     26) SIGVTALRM
     虚拟时钟信号. 类似于SIGALRM, 但是计算的是该进程占用的CPU时间.
     27) SIGPROF
     类似于SIGALRM/SIGVTALRM, 但包括该进程用的CPU时间以及系统调用的时间.
     28) SIGWINCH
     窗口大小改变时发出.
     29) SIGIO
     文件描述符准备就绪, 可以开始进行输入/输出操作.
     30) SIGPWR
     Power failure
     31) SIGSYS
     非法的系统调用。
     ***/
    
    //程序由于abort()函数调用发生的程序终止信号
    signal(SIGABRT, SignalCatchHandler);
    
    //程序由于非法指令产生导致的程序终止信号
    signal(SIGILL, SignalCatchHandler);
    
    //成语由于内存地址未对齐导致的程序终止信号
    signal(SIGBUS, SignalCatchHandler);
    
    //程序由于浮点数异常导致的程序终止信号
    signal(SIGFPE, SignalCatchHandler);
    
    //程序由于无效内存的引用导致的程序终止信号
    signal(SIGSEGV, SignalCatchHandler);
    
    //程序由于通过端口发送消息失败导致的程序中心信号
    signal(SIGPIPE, SignalCatchHandler);
    
    //监听系统方法 交换
    
}

#pragma mark 处理异常
- (void)handleException:(NSException *)exception
{
    //将异常写入日志系统
    
    //异常提示
    [self handlerAlertWithMessage:@""];
    
    //用户选择了继续运行 程序继续处理事件 开启运行循环
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    //用户选择继续运行程序
    while (self.isQuit == false)
    {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            
            //切换runLoop监听事件的mode
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
            
        }
    }
    
    //用户选择退出 终止循环 程序崩溃
    CFRelease(allModes);
    
    //终止异常捕获处理
    NSSetUncaughtExceptionHandler(NULL);
    
    //终止捕获的信号的类型
    
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqualToString:kUncaughtExceptionHandlerSignalExceptionName])
    {
        kill(getpid(), [[[exception userInfo]objectForKey:kUncaughtExceptionHandlerSignalKey]intValue]);
    } else
    {
        [exception raise];
    }
    
}

// 获取函数调用栈信息列表
+ (NSArray *)backTrace
{
    //指针列表
    /**
     //backtrace用来获取当前线程的调用堆栈，获取的信息存放在这里的callstack中
     //128用来指定当前的buffer中可以保存多少个void*元素
     */
    void *callStack[128];
    
    //返回值是实际获取的指针个数
    int frames = backtrace(callStack, 128);
    
    //backtrace_symbols将从backtrace函数获取的信息转化为一个字符串数组
    //返回一个指向字符串数组的指针
    //每个字符串包含了一个相对于callstack中对应元素的可打印信息，包括函数名、偏移地址、实际返回地址
    char **strs = backtrace_symbols(callStack, frames);
    NSMutableArray *backTrack = [NSMutableArray arrayWithCapacity:frames];
    
    for (int i = 0; i < frames; i++) {
        [backTrack addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backTrack;
}

#pragma mark 异常提示
- (void)handlerAlertWithMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"程序遇到异常即将退出,是否退出?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *quitAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.isQuit = true;
    }];
    
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.isQuit = false;
    }];
    
    [alertController addAction:quitAction];
    [alertController addAction:continueAction];
    
    [[[MTTSingletonManager sharedInstance]getRootViewController] presentViewController:alertController animated:true completion:^{
        
    }];
}

@end


/**
 异常信号捕获处理

 @param signal 异常信号
 */
void SignalCatchHandler(int signal)
{
    atomic_int exceptionCurrentCount = atomic_fetch_add(&kUncaughtExceptionCurrentCount, 1);
    
    // 超过最大异常处理数量10 直接返回
    if (exceptionCurrentCount > kUncaughtExceptionMaximuCount) return;
    
    //拼接异常信号基本信息
    NSString *description = nil;
    switch (signal)
    {
        case SIGABRT:
            description = [NSString stringWithFormat:@"Signal SIGABRT was raised!\n"];
            break;
        case SIGILL:
            description = [NSString stringWithFormat:@"Signal SIGILL was raised!\n"];
            break;
        case SIGBUS:
            description = [NSString stringWithFormat:@"Signal SIGBUS was raised!\n"];
            break;
        case SIGFPE:
            description = [NSString stringWithFormat:@"Signal SIGFPE was raised!\n"];
            break;
        case SIGSEGV:
            description = [NSString stringWithFormat:@"Signal SIGSEGV was raised!\n"];
            break;
        case SIGPIPE:
            description = [NSString stringWithFormat:@"Signal SIGPIPE was raised!\n"];
            break;
            
        default:
            description = [NSString stringWithFormat:@"Signal %d was raised!\n",signal];
            break;
    }
    
    //获取函数调用栈信息
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    NSArray *callStack = [MTTSignalHandlerManager backTrace];
    
    [userInfo setObject:callStack forKey:kUncaughtExceptionHandlerSignalAddressesKey];
    [userInfo setObject:[NSNumber numberWithInteger:signal] forKey:kUncaughtExceptionHandlerSignalKey];
    
    //初始化异常对调
    NSException *exp = [NSException exceptionWithName:@"SignalException" reason:description userInfo:userInfo];
    
    //处理异常消息
    [[MTTSignalHandlerManager signalHandlerManager]performSelectorOnMainThread:@selector(handleException:) withObject:exp waitUntilDone:true];
    
}


void HandleCurrentException(NSException *exception)
{
    atomic_int exceptionCurrentCount = atomic_fetch_add(&kUncaughtExceptionCurrentCount, 1);
    
    if (exceptionCurrentCount > kUncaughtExceptionMaximuCount) return;
    
    // 获取函数调用栈信息
    NSArray *callStack = [exception callStackSymbols];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callStack forKey:kUncaughtExceptionHandlerSignalAddressesKey];
    [[MTTSignalHandlerManager signalHandlerManager] performSelectorOnMainThread:@selector(handleException:) withObject:[NSException exceptionWithName:[exception name] reason:[exception reason] userInfo:userInfo] waitUntilDone:true];
}
