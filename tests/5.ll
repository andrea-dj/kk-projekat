; ModuleID = '5.c'
source_filename = "5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [16 x i8] c"Final sum = %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %sum = alloca i32, align 4
  %base = alloca i32, align 4
  %scale = alloca i32, align 4
  %i = alloca i32, align 4
  %inner_sum = alloca i32, align 4
  %j = alloca i32, align 4
  %prod1 = alloca i32, align 4
  %prod2 = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 0, ptr %sum, align 4
  store i32 3, ptr %base, align 4
  store i32 2, ptr %scale, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc8, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 4
  br i1 %cmp, label %for.body, label %for.end10

for.body:                                         ; preds = %for.cond
  store i32 0, ptr %inner_sum, align 4
  store i32 0, ptr %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, ptr %j, align 4
  %cmp2 = icmp slt i32 %1, 6
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, ptr %j, align 4
  %mul = mul nsw i32 %2, 4
  store i32 %mul, ptr %prod1, align 4
  %3 = load i32, ptr %j, align 4
  %4 = load i32, ptr %base, align 4
  %mul4 = mul nsw i32 %3, %4
  store i32 %mul4, ptr %prod2, align 4
  %5 = load i32, ptr %prod1, align 4
  %6 = load i32, ptr %prod2, align 4
  %add = add nsw i32 %5, %6
  %7 = load i32, ptr %inner_sum, align 4
  %add5 = add nsw i32 %7, %add
  store i32 %add5, ptr %inner_sum, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %8 = load i32, ptr %j, align 4
  %inc = add nsw i32 %8, 1
  store i32 %inc, ptr %j, align 4
  br label %for.cond1, !llvm.loop !6

for.end:                                          ; preds = %for.cond1
  %9 = load i32, ptr %inner_sum, align 4
  %10 = load i32, ptr %scale, align 4
  %mul6 = mul nsw i32 %9, %10
  %11 = load i32, ptr %sum, align 4
  %add7 = add nsw i32 %11, %mul6
  store i32 %add7, ptr %sum, align 4
  br label %for.inc8

for.inc8:                                         ; preds = %for.end
  %12 = load i32, ptr %i, align 4
  %inc9 = add nsw i32 %12, 1
  store i32 %inc9, ptr %i, align 4
  br label %for.cond, !llvm.loop !8

for.end10:                                        ; preds = %for.cond
  %13 = load i32, ptr %sum, align 4
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %13)
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
