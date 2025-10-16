; ModuleID = '1.c'
source_filename = "1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [19 x i8] c"Results: %d %d %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %sum1 = alloca i32, align 4
  %sum2 = alloca i32, align 4
  %sum3 = alloca i32, align 4
  %x = alloca i32, align 4
  %i = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %j = alloca i32, align 4
  %b6 = alloca i32, align 4
  %m = alloca i32, align 4
  %n = alloca i32, align 4
  %t = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 0, ptr %sum1, align 4
  store i32 0, ptr %sum2, align 4
  store i32 0, ptr %sum3, align 4
  store i32 5, ptr %x, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, ptr %i, align 4
  %mul = mul nsw i32 %1, 4
  %add = add nsw i32 %mul, 2
  store i32 %add, ptr %a, align 4
  %2 = load i32, ptr %i, align 4
  %div = sdiv i32 %2, 4
  store i32 %div, ptr %b, align 4
  %3 = load i32, ptr %a, align 4
  %4 = load i32, ptr %b, align 4
  %add1 = add nsw i32 %3, %4
  %5 = load i32, ptr %sum1, align 4
  %add2 = add nsw i32 %5, %add1
  store i32 %add2, ptr %sum1, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %6 = load i32, ptr %i, align 4
  %inc = add nsw i32 %6, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  store i32 20, ptr %j, align 4
  br label %for.cond3

for.cond3:                                        ; preds = %for.inc8, %for.end
  %7 = load i32, ptr %j, align 4
  %cmp4 = icmp sgt i32 %7, 0
  br i1 %cmp4, label %for.body5, label %for.end10

for.body5:                                        ; preds = %for.cond3
  %8 = load i32, ptr %j, align 4
  %sub = sub nsw i32 %8, 3
  store i32 %sub, ptr %b6, align 4
  %9 = load i32, ptr %b6, align 4
  %10 = load i32, ptr %sum2, align 4
  %add7 = add nsw i32 %10, %9
  store i32 %add7, ptr %sum2, align 4
  br label %for.inc8

for.inc8:                                         ; preds = %for.body5
  %11 = load i32, ptr %j, align 4
  %sub9 = sub nsw i32 %11, 2
  store i32 %sub9, ptr %j, align 4
  br label %for.cond3, !llvm.loop !8

for.end10:                                        ; preds = %for.cond3
  store i32 0, ptr %m, align 4
  br label %for.cond11

for.cond11:                                       ; preds = %for.inc25, %for.end10
  %12 = load i32, ptr %m, align 4
  %cmp12 = icmp slt i32 %12, 5
  br i1 %cmp12, label %for.body13, label %for.end27

for.body13:                                       ; preds = %for.cond11
  store i32 0, ptr %n, align 4
  br label %for.cond14

for.cond14:                                       ; preds = %for.inc22, %for.body13
  %13 = load i32, ptr %n, align 4
  %cmp15 = icmp slt i32 %13, 5
  br i1 %cmp15, label %for.body16, label %for.end24

for.body16:                                       ; preds = %for.cond14
  %14 = load i32, ptr %m, align 4
  %mul17 = mul nsw i32 %14, 2
  %15 = load i32, ptr %n, align 4
  %mul18 = mul nsw i32 %15, 3
  %add19 = add nsw i32 %mul17, %mul18
  %add20 = add nsw i32 %add19, 1
  store i32 %add20, ptr %t, align 4
  %16 = load i32, ptr %t, align 4
  %17 = load i32, ptr %sum3, align 4
  %add21 = add nsw i32 %17, %16
  store i32 %add21, ptr %sum3, align 4
  br label %for.inc22

for.inc22:                                        ; preds = %for.body16
  %18 = load i32, ptr %n, align 4
  %inc23 = add nsw i32 %18, 1
  store i32 %inc23, ptr %n, align 4
  br label %for.cond14, !llvm.loop !9

for.end24:                                        ; preds = %for.cond14
  br label %for.inc25

for.inc25:                                        ; preds = %for.end24
  %19 = load i32, ptr %m, align 4
  %inc26 = add nsw i32 %19, 1
  store i32 %inc26, ptr %m, align 4
  br label %for.cond11, !llvm.loop !10

for.end27:                                        ; preds = %for.cond11
  %20 = load i32, ptr %sum1, align 4
  %21 = load i32, ptr %sum2, align 4
  %22 = load i32, ptr %sum3, align 4
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %20, i32 noundef %21, i32 noundef %22)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.0"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
