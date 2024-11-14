#!/bin/bash

cross_compile := arm-rockchip830-linux-uclibcgnueabihf-

# Chip
-march=armv7-a
-mcpu=cortex-a7
-mfpu=neno
-mfloat-abi=hard

# Language
-std=c17 # C standard

# Micro
-D_GNU_SOURCE # GNU扩展
-D_REENTRANT # 可重入版本
-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 # 使其32位支持处理大于2G的文件

# Compile
-pipe # 编译过程使用管道代替临时文件
-Wall -Wextra -Werror # 程序代码
-fstack-protector-strong
-fno-strict-aliasing # 允许不同类型指定同一内存位置
-fsigned-char # 默认带符号

# Debug
-g -rdynamic -funwind-tables -fasynchronous-unwind-tables # for dlopen
# default debug
ifeq ($(version), release)
-DNDEBUG -O3
else
-ggdb -Og
endif

# Link
-shared -fPIC # 待定
-fdata-sections -ffunction-sections -Wl,--gc-sections # 导出每个函数作session并做裁剪