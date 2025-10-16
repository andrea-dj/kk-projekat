; ModuleID = '3.c'
source_filename = "3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [18 x i8] c"Final total = %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @sumAndDouble(i32 noundef %a, i32 noundef %b) #0 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, ptr %a.addr, align 4
  store i32 %b, ptr %b.addr, align 4
  %0 = load i32, ptr %a.addr, align 4
  %1 = load i32, ptr %b.addr, align 4
  %add = add nsw i32 %0, %1
  %mul = mul nsw i32 %add, 2
  ret i32 %mul
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %n = alloca i32, align 4
  %total = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %m = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 10, ptr %n, align 4
  store i32 0, ptr %total, align 4
  store i32 1, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %1 = load i32, ptr %n, align 4
  %cmp = icmp sle i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, ptr %i, align 4
  %add = add nsw i32 %2, 1
  %3 = load i32, ptr %total, align 4
  %add1 = add nsw i32 %3, %add
  store i32 %add1, ptr %total, align 4
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
  br i1 %cmp3, label %for.body4, label %for.end7

for.body4:                                        ; preds = %for.cond2
  %6 = load i32, ptr %j, align 4
  %mul = mul nsw i32 %6, 2
  %7 = load i32, ptr %total, align 4
  %add5 = add nsw i32 %7, %mul
  store i32 %add5, ptr %total, align 4
  br label %for.inc6

for.inc6:                                         ; preds = %for.body4
  %8 = load i32, ptr %j, align 4
  %sub = sub nsw i32 %8, 3
  store i32 %sub, ptr %j, align 4
  br label %for.cond2, !llvm.loop !8

for.end7:                                         ; preds = %for.cond2
  store i32 5, ptr %k, align 4
  br label %for.cond8

for.cond8:                                        ; preds = %for.inc13, %for.end7
  %9 = load i32, ptr %k, align 4
  %cmp9 = icmp slt i32 %9, 15
  br i1 %cmp9, label %for.body10, label %for.end15

for.body10:                                       ; preds = %for.cond8
  %10 = load i32, ptr %k, align 4
  %mul11 = mul nsw i32 %10, 3
  store i32 %mul11, ptr %m, align 4
  %11 = load i32, ptr %k, align 4
  %12 = load i32, ptr %m, align 4
  %call = call i32 @sumAndDouble(i32 noundef %11, i32 noundef %12)
  %13 = load i32, ptr %total, align 4
  %add12 = add nsw i32 %13, %call
  store i32 %add12, ptr %total, align 4
  br label %for.inc13

for.inc13:                                        ; preds = %for.body10
  %14 = load i32, ptr %k, align 4
  %add14 = add nsw i32 %14, 2
  store i32 %add14, ptr %k, align 4
  br label %for.cond8, !llvm.loop !9

for.end15:                                        ; preds = %for.cond8
  store i32 0, ptr %x, align 4
  br label %for.cond16

for.cond16:                                       ; preds = %for.inc22, %for.end15
  %15 = load i32, ptr %x, align 4
  %cmp17 = icmp slt i32 %15, 20
  br i1 %cmp17, label %for.body18, label %for.end24

for.body18:                                       ; preds = %for.cond16
  %16 = load i32, ptr %x, align 4
  %add19 = add nsw i32 %16, 1
  store i32 %add19, ptr %y, align 4
  %17 = load i32, ptr %y, align 4
  %mul20 = mul nsw i32 %17, 2
  store i32 %mul20, ptr %z, align 4
  %18 = load i32, ptr %z, align 4
  %19 = load i32, ptr %total, align 4
  %add21 = add nsw i32 %19, %18
  store i32 %add21, ptr %total, align 4
  br label %for.inc22

for.inc22:                                        ; preds = %for.body18
  %20 = load i32, ptr %x, align 4
  %add23 = add nsw i32 %20, 4
  store i32 %add23, ptr %x, align 4
  br label %for.cond16, !llvm.loop !10

for.end24:                                        ; preds = %for.cond16
  %21 = load i32, ptr %total, align 4
  %call25 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %21)
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
