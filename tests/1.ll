; ModuleID = '1.c'
source_filename = "1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [22 x i8] c"Results: %d %d %d %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %sum1 = alloca i32, align 4
  %sum2 = alloca i32, align 4
  %sum3 = alloca i32, align 4
  %sum4 = alloca i32, align 4
  %x = alloca i32, align 4
  %i = alloca i32, align 4
  %a = alloca i32, align 4
  %j = alloca i32, align 4
  %b = alloca i32, align 4
  %m = alloca i32, align 4
  %n = alloca i32, align 4
  %t = alloca i32, align 4
  %m26 = alloca i32, align 4
  %p = alloca i32, align 4
  %i27 = alloca i32, align 4
  %a31 = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 0, ptr %sum1, align 4
  store i32 0, ptr %sum2, align 4
  store i32 0, ptr %sum3, align 4
  store i32 0, ptr %sum4, align 4
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
  %2 = load i32, ptr %a, align 4
  %3 = load i32, ptr %sum1, align 4
  %add1 = add nsw i32 %3, %2
  store i32 %add1, ptr %sum1, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %4 = load i32, ptr %i, align 4
  %inc = add nsw i32 %4, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  store i32 20, ptr %j, align 4
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc6, %for.end
  %5 = load i32, ptr %j, align 4
  %cmp3 = icmp sgt i32 %5, 0
  br i1 %cmp3, label %for.body4, label %for.end8

for.body4:                                        ; preds = %for.cond2
  %6 = load i32, ptr %j, align 4
  %sub = sub nsw i32 %6, 3
  store i32 %sub, ptr %b, align 4
  %7 = load i32, ptr %b, align 4
  %8 = load i32, ptr %sum2, align 4
  %add5 = add nsw i32 %8, %7
  store i32 %add5, ptr %sum2, align 4
  br label %for.inc6

for.inc6:                                         ; preds = %for.body4
  %9 = load i32, ptr %j, align 4
  %sub7 = sub nsw i32 %9, 2
  store i32 %sub7, ptr %j, align 4
  br label %for.cond2, !llvm.loop !8

for.end8:                                         ; preds = %for.cond2
  store i32 0, ptr %m, align 4
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc23, %for.end8
  %10 = load i32, ptr %m, align 4
  %cmp10 = icmp slt i32 %10, 5
  br i1 %cmp10, label %for.body11, label %for.end25

for.body11:                                       ; preds = %for.cond9
  store i32 0, ptr %n, align 4
  br label %for.cond12

for.cond12:                                       ; preds = %for.inc20, %for.body11
  %11 = load i32, ptr %n, align 4
  %cmp13 = icmp slt i32 %11, 5
  br i1 %cmp13, label %for.body14, label %for.end22

for.body14:                                       ; preds = %for.cond12
  %12 = load i32, ptr %m, align 4
  %mul15 = mul nsw i32 %12, 2
  %13 = load i32, ptr %n, align 4
  %mul16 = mul nsw i32 %13, 3
  %add17 = add nsw i32 %mul15, %mul16
  %add18 = add nsw i32 %add17, 1
  store i32 %add18, ptr %t, align 4
  %14 = load i32, ptr %t, align 4
  %15 = load i32, ptr %sum3, align 4
  %add19 = add nsw i32 %15, %14
  store i32 %add19, ptr %sum3, align 4
  br label %for.inc20

for.inc20:                                        ; preds = %for.body14
  %16 = load i32, ptr %n, align 4
  %inc21 = add nsw i32 %16, 1
  store i32 %inc21, ptr %n, align 4
  br label %for.cond12, !llvm.loop !9

for.end22:                                        ; preds = %for.cond12
  br label %for.inc23

for.inc23:                                        ; preds = %for.end22
  %17 = load i32, ptr %m, align 4
  %inc24 = add nsw i32 %17, 1
  store i32 %inc24, ptr %m, align 4
  br label %for.cond9, !llvm.loop !10

for.end25:                                        ; preds = %for.cond9
  store i32 2, ptr %m26, align 4
  store i32 3, ptr %p, align 4
  store i32 0, ptr %i27, align 4
  br label %for.cond28

for.cond28:                                       ; preds = %for.inc36, %for.end25
  %18 = load i32, ptr %i27, align 4
  %cmp29 = icmp slt i32 %18, 10
  br i1 %cmp29, label %for.body30, label %for.end38

for.body30:                                       ; preds = %for.cond28
  %19 = load i32, ptr %i27, align 4
  %mul32 = mul nsw i32 %19, 4
  %20 = load i32, ptr %p, align 4
  %mul33 = mul nsw i32 %20, 2
  %add34 = add nsw i32 %mul32, %mul33
  store i32 %add34, ptr %a31, align 4
  %21 = load i32, ptr %a31, align 4
  %22 = load i32, ptr %sum4, align 4
  %add35 = add nsw i32 %22, %21
  store i32 %add35, ptr %sum4, align 4
  br label %for.inc36

for.inc36:                                        ; preds = %for.body30
  %23 = load i32, ptr %m26, align 4
  %24 = load i32, ptr %i27, align 4
  %add37 = add nsw i32 %24, %23
  store i32 %add37, ptr %i27, align 4
  br label %for.cond28, !llvm.loop !11

for.end38:                                        ; preds = %for.cond28
  %25 = load i32, ptr %sum1, align 4
  %26 = load i32, ptr %sum2, align 4
  %27 = load i32, ptr %sum3, align 4
  %28 = load i32, ptr %sum4, align 4
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %25, i32 noundef %26, i32 noundef %27, i32 noundef %28)
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
!11 = distinct !{!11, !7}
