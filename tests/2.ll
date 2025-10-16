; ModuleID = '2.c'
source_filename = "2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"sum = %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %n = alloca i32, align 4
  %sum = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 10, ptr %n, align 4
  store i32 0, ptr %sum, align 4
  store i32 1, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %1 = load i32, ptr %n, align 4
  %cmp = icmp sle i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, ptr %i, align 4
  %3 = load i32, ptr %sum, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, ptr %sum, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %4 = load i32, ptr %i, align 4
  %inc = add nsw i32 %4, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  store i32 0, ptr %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc6, %for.end
  %5 = load i32, ptr %j, align 4
  %6 = load i32, ptr %n, align 4
  %cmp2 = icmp slt i32 %5, %6
  br i1 %cmp2, label %for.body3, label %for.end8

for.body3:                                        ; preds = %for.cond1
  %7 = load i32, ptr %j, align 4
  %mul = mul nsw i32 2, %7
  %add4 = add nsw i32 %mul, 1
  store i32 %add4, ptr %k, align 4
  %8 = load i32, ptr %k, align 4
  %9 = load i32, ptr %sum, align 4
  %add5 = add nsw i32 %9, %8
  store i32 %add5, ptr %sum, align 4
  br label %for.inc6

for.inc6:                                         ; preds = %for.body3
  %10 = load i32, ptr %j, align 4
  %inc7 = add nsw i32 %10, 1
  store i32 %inc7, ptr %j, align 4
  br label %for.cond1, !llvm.loop !8

for.end8:                                         ; preds = %for.cond1
  store i32 1, ptr %a, align 4
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc17, %for.end8
  %11 = load i32, ptr %a, align 4
  %12 = load i32, ptr %n, align 4
  %cmp10 = icmp sle i32 %11, %12
  br i1 %cmp10, label %for.body11, label %for.end19

for.body11:                                       ; preds = %for.cond9
  %13 = load i32, ptr %a, align 4
  %mul12 = mul nsw i32 3, %13
  %add13 = add nsw i32 %mul12, 2
  store i32 %add13, ptr %b, align 4
  %14 = load i32, ptr %b, align 4
  %mul14 = mul nsw i32 %14, 2
  %15 = load i32, ptr %a, align 4
  %add15 = add nsw i32 %mul14, %15
  store i32 %add15, ptr %c, align 4
  %16 = load i32, ptr %c, align 4
  %17 = load i32, ptr %sum, align 4
  %add16 = add nsw i32 %17, %16
  store i32 %add16, ptr %sum, align 4
  br label %for.inc17

for.inc17:                                        ; preds = %for.body11
  %18 = load i32, ptr %a, align 4
  %inc18 = add nsw i32 %18, 1
  store i32 %inc18, ptr %a, align 4
  br label %for.cond9, !llvm.loop !9

for.end19:                                        ; preds = %for.cond9
  %19 = load i32, ptr %sum, align 4
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %19)
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
