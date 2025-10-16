; ModuleID = '2_simpl.ll'
source_filename = "2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"sum = %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 1, %entry ], [ %2, %for.inc ]
  %sum.0 = phi i32 [ 0, %entry ], [ %6, %for.inc ]
  %0 = phi i32 [ 1, %entry ], [ %8, %for.inc ]
  %1 = phi i32 [ 1, %entry ], [ %9, %for.inc ]
  %2 = phi i32 [ 2, %entry ], [ %10, %for.inc ]
  %3 = phi i32 [ 0, %entry ], [ %11, %for.inc ]
  %4 = phi i32 [ 3, %entry ], [ %12, %for.inc ]
  %5 = phi i32 [ 2, %entry ], [ %13, %for.inc ]
  %cmp = icmp sle i32 %i.0, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = add i32 %sum.0, %0
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %7 = add i32 %0, 1
  %8 = add i32 %0, 1
  %9 = add i32 %1, 1
  %10 = add i32 %2, 1
  %11 = add i32 %3, 2
  %12 = add i32 %4, 3
  %13 = add i32 %5, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc6, %for.end
  %sum.1 = phi i32 [ %sum.0, %for.end ], [ %add5, %for.inc6 ]
  %j.0 = phi i32 [ 0, %for.end ], [ %15, %for.inc6 ]
  %14 = phi i32 [ 0, %for.end ], [ %21, %for.inc6 ]
  %15 = phi i32 [ 1, %for.end ], [ %22, %for.inc6 ]
  %16 = phi i32 [ 0, %for.end ], [ %23, %for.inc6 ]
  %17 = phi i32 [ 3, %for.end ], [ %24, %for.inc6 ]
  %18 = phi i32 [ 2, %for.end ], [ %25, %for.inc6 ]
  %cmp2 = icmp slt i32 %j.0, 10
  br i1 %cmp2, label %for.body3, label %for.end8

for.body3:                                        ; preds = %for.cond1
  %19 = mul i32 2, %14
  %add4 = add nsw i32 %16, 1
  %add5 = add nsw i32 %sum.1, %add4
  br label %for.inc6

for.inc6:                                         ; preds = %for.body3
  %20 = add i32 %14, 1
  %21 = add i32 %14, 1
  %22 = add i32 %15, 1
  %23 = add i32 %16, 2
  %24 = add i32 %17, 3
  %25 = add i32 %18, 1
  br label %for.cond1, !llvm.loop !8

for.end8:                                         ; preds = %for.cond1
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc17, %for.end8
  %sum.2 = phi i32 [ %sum.1, %for.end8 ], [ %add16, %for.inc17 ]
  %a.0 = phi i32 [ 1, %for.end8 ], [ %28, %for.inc17 ]
  %26 = phi i32 [ 1, %for.end8 ], [ %32, %for.inc17 ]
  %27 = phi i32 [ 3, %for.end8 ], [ %33, %for.inc17 ]
  %28 = phi i32 [ 2, %for.end8 ], [ %34, %for.inc17 ]
  %cmp10 = icmp sle i32 %a.0, 10
  br i1 %cmp10, label %for.body11, label %for.end19

for.body11:                                       ; preds = %for.cond9
  %29 = mul i32 3, %26
  %add13 = add nsw i32 %27, 2
  %mul14 = mul nsw i32 %add13, 2
  %30 = add i32 %mul14, %26
  %add16 = add nsw i32 %sum.2, %30
  br label %for.inc17

for.inc17:                                        ; preds = %for.body11
  %31 = add i32 %26, 1
  %32 = add i32 %26, 1
  %33 = add i32 %27, 3
  %34 = add i32 %28, 1
  br label %for.cond9, !llvm.loop !9

for.end19:                                        ; preds = %for.cond9
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %sum.2)
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
