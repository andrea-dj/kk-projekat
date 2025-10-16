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
  %b4 = alloca i32, align 4
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
  store i32 %mul, ptr %a, align 4
  %2 = load i32, ptr %i, align 4
  %div = sdiv i32 %2, 8
  store i32 %div, ptr %b, align 4
  %3 = load i32, ptr %a, align 4
  %4 = load i32, ptr %sum1, align 4
  %add = add nsw i32 %4, %3
  store i32 %add, ptr %sum1, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %5 = load i32, ptr %i, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  store i32 5, ptr %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc7, %for.end
  %6 = load i32, ptr %j, align 4
  %cmp2 = icmp slt i32 %6, 10
  br i1 %cmp2, label %for.body3, label %for.end9

for.body3:                                        ; preds = %for.cond1
  %7 = load i32, ptr %j, align 4
  %mul5 = mul nsw i32 %7, 3
  store i32 %mul5, ptr %b4, align 4
  %8 = load i32, ptr %b4, align 4
  %9 = load i32, ptr %sum2, align 4
  %add6 = add nsw i32 %9, %8
  store i32 %add6, ptr %sum2, align 4
  br label %for.inc7

for.inc7:                                         ; preds = %for.body3
  %10 = load i32, ptr %j, align 4
  %inc8 = add nsw i32 %10, 1
  store i32 %inc8, ptr %j, align 4
  br label %for.cond1, !llvm.loop !8

for.end9:                                         ; preds = %for.cond1
  store i32 0, ptr %m, align 4
  br label %for.cond10

for.cond10:                                       ; preds = %for.inc24, %for.end9
  %11 = load i32, ptr %m, align 4
  %cmp11 = icmp slt i32 %11, 5
  br i1 %cmp11, label %for.body12, label %for.end26

for.body12:                                       ; preds = %for.cond10
  store i32 0, ptr %n, align 4
  br label %for.cond13

for.cond13:                                       ; preds = %for.inc21, %for.body12
  %12 = load i32, ptr %n, align 4
  %cmp14 = icmp slt i32 %12, 5
  br i1 %cmp14, label %for.body15, label %for.end23

for.body15:                                       ; preds = %for.cond13
  %13 = load i32, ptr %m, align 4
  %mul16 = mul nsw i32 %13, 2
  %14 = load i32, ptr %n, align 4
  %mul17 = mul nsw i32 %14, 3
  %add18 = add nsw i32 %mul16, %mul17
  %add19 = add nsw i32 %add18, 1
  store i32 %add19, ptr %t, align 4
  %15 = load i32, ptr %t, align 4
  %16 = load i32, ptr %sum3, align 4
  %add20 = add nsw i32 %16, %15
  store i32 %add20, ptr %sum3, align 4
  br label %for.inc21

for.inc21:                                        ; preds = %for.body15
  %17 = load i32, ptr %n, align 4
  %inc22 = add nsw i32 %17, 1
  store i32 %inc22, ptr %n, align 4
  br label %for.cond13, !llvm.loop !9

for.end23:                                        ; preds = %for.cond13
  br label %for.inc24

for.inc24:                                        ; preds = %for.end23
  %18 = load i32, ptr %m, align 4
  %add25 = add nsw i32 %18, 2
  store i32 %add25, ptr %m, align 4
  br label %for.cond10, !llvm.loop !10

for.end26:                                        ; preds = %for.cond10
  %19 = load i32, ptr %sum1, align 4
  %20 = load i32, ptr %sum2, align 4
  %21 = load i32, ptr %sum3, align 4
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %19, i32 noundef %20, i32 noundef %21)
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
