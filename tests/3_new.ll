; ModuleID = '3_simpl.ll'
source_filename = "3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [18 x i8] c"Final total = %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @sumAndDouble(i32 noundef %a, i32 noundef %b) #0 {
entry:
  %add = add nsw i32 %a, %b
  %mul = mul nsw i32 %add, 2
  ret i32 %mul
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 1, %entry ], [ %8, %for.inc ]
  %total.0 = phi i32 [ 0, %entry ], [ %add1, %for.inc ]
  %0 = phi i32 [ 1, %entry ], [ %11, %for.inc ]
  %1 = phi i32 [ 7, %entry ], [ %12, %for.inc ]
  %2 = phi i32 [ 2, %entry ], [ %13, %for.inc ]
  %3 = phi i32 [ 40, %entry ], [ %14, %for.inc ]
  %4 = phi i32 [ 15, %entry ], [ %15, %for.inc ]
  %5 = phi i32 [ 1, %entry ], [ %16, %for.inc ]
  %6 = phi i32 [ 4, %entry ], [ %17, %for.inc ]
  %7 = phi i32 [ 17, %entry ], [ %18, %for.inc ]
  %8 = phi i32 [ 2, %entry ], [ %19, %for.inc ]
  %cmp = icmp sle i32 %i.0, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %9 = add i32 %0, 1
  %add1 = add nsw i32 %total.0, %2
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %10 = add i32 %0, 1
  %11 = add i32 %0, 1
  %12 = add i32 %1, 2
  %13 = add i32 %2, 1
  %14 = add i32 %3, -6
  %15 = add i32 %4, 6
  %16 = add i32 %5, 4
  %17 = add i32 %6, 4
  %18 = add i32 %7, -3
  %19 = add i32 %8, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc6, %for.end
  %j.0 = phi i32 [ 20, %for.end ], [ %26, %for.inc6 ]
  %total.1 = phi i32 [ %total.0, %for.end ], [ %add5, %for.inc6 ]
  %20 = phi i32 [ 20, %for.end ], [ %29, %for.inc6 ]
  %21 = phi i32 [ 7, %for.end ], [ %30, %for.inc6 ]
  %22 = phi i32 [ 40, %for.end ], [ %31, %for.inc6 ]
  %23 = phi i32 [ 15, %for.end ], [ %32, %for.inc6 ]
  %24 = phi i32 [ 1, %for.end ], [ %33, %for.inc6 ]
  %25 = phi i32 [ 4, %for.end ], [ %34, %for.inc6 ]
  %26 = phi i32 [ 17, %for.end ], [ %35, %for.inc6 ]
  %cmp3 = icmp sgt i32 %j.0, 0
  br i1 %cmp3, label %for.body4, label %for.end7

for.body4:                                        ; preds = %for.cond2
  %27 = mul i32 %20, 2
  %add5 = add nsw i32 %total.1, %22
  br label %for.inc6

for.inc6:                                         ; preds = %for.body4
  %28 = sub i32 %20, 3
  %29 = add i32 %20, -3
  %30 = add i32 %21, 2
  %31 = add i32 %22, -6
  %32 = add i32 %23, 6
  %33 = add i32 %24, 4
  %34 = add i32 %25, 4
  %35 = add i32 %26, -3
  br label %for.cond2, !llvm.loop !8

for.end7:                                         ; preds = %for.cond2
  br label %for.cond8

for.cond8:                                        ; preds = %for.inc13, %for.end7
  %total.2 = phi i32 [ %total.1, %for.end7 ], [ %add12, %for.inc13 ]
  %k.0 = phi i32 [ 5, %for.end7 ], [ %37, %for.inc13 ]
  %36 = phi i32 [ 5, %for.end7 ], [ %43, %for.inc13 ]
  %37 = phi i32 [ 7, %for.end7 ], [ %44, %for.inc13 ]
  %38 = phi i32 [ 15, %for.end7 ], [ %45, %for.inc13 ]
  %39 = phi i32 [ 1, %for.end7 ], [ %46, %for.inc13 ]
  %40 = phi i32 [ 4, %for.end7 ], [ %47, %for.inc13 ]
  %cmp9 = icmp slt i32 %k.0, 15
  br i1 %cmp9, label %for.body10, label %for.end15

for.body10:                                       ; preds = %for.cond8
  %41 = mul i32 %36, 3
  %call = call i32 @sumAndDouble(i32 noundef %k.0, i32 noundef %38)
  %add12 = add nsw i32 %total.2, %call
  br label %for.inc13

for.inc13:                                        ; preds = %for.body10
  %42 = add i32 %36, 2
  %43 = add i32 %36, 2
  %44 = add i32 %37, 2
  %45 = add i32 %38, 6
  %46 = add i32 %39, 4
  %47 = add i32 %40, 4
  br label %for.cond8, !llvm.loop !9

for.end15:                                        ; preds = %for.cond8
  br label %for.cond16

for.cond16:                                       ; preds = %for.inc22, %for.end15
  %total.3 = phi i32 [ %total.2, %for.end15 ], [ %add21, %for.inc22 ]
  %x.0 = phi i32 [ 0, %for.end15 ], [ %50, %for.inc22 ]
  %48 = phi i32 [ 0, %for.end15 ], [ %53, %for.inc22 ]
  %49 = phi i32 [ 1, %for.end15 ], [ %54, %for.inc22 ]
  %50 = phi i32 [ 4, %for.end15 ], [ %55, %for.inc22 ]
  %cmp17 = icmp slt i32 %x.0, 20
  br i1 %cmp17, label %for.body18, label %for.end24

for.body18:                                       ; preds = %for.cond16
  %51 = add i32 %48, 1
  %mul20 = mul nsw i32 %49, 2
  %add21 = add nsw i32 %total.3, %mul20
  br label %for.inc22

for.inc22:                                        ; preds = %for.body18
  %52 = add i32 %48, 4
  %53 = add i32 %48, 4
  %54 = add i32 %49, 4
  %55 = add i32 %50, 4
  br label %for.cond16, !llvm.loop !10

for.end24:                                        ; preds = %for.cond16
  %call25 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %total.3)
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
