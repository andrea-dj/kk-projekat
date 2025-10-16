; ModuleID = '1_simpl.ll'
source_filename = "1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [19 x i8] c"Results: %d %d %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %sum1.0 = phi i32 [ 0, %entry ], [ %add, %for.inc ]
  %cmp = icmp slt i32 %i.0, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %shl_by_pow24 = shl i32 %i.0, 2
  %ashr_by_pow2 = ashr i32 %i.0, 3
  %add = add nsw i32 %sum1.0, %shl_by_pow24
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc7, %for.end
  %j.0 = phi i32 [ 5, %for.end ], [ %inc8, %for.inc7 ]
  %sum2.0 = phi i32 [ 0, %for.end ], [ %add6, %for.inc7 ]
  %cmp2 = icmp slt i32 %j.0, 10
  br i1 %cmp2, label %for.body3, label %for.end9

for.body3:                                        ; preds = %for.cond1
  %add_for_mul2 = add i32 %j.0, %j.0
  %add_for_mul3 = add i32 %add_for_mul2, %j.0
  %add6 = add nsw i32 %sum2.0, %add_for_mul3
  br label %for.inc7

for.inc7:                                         ; preds = %for.body3
  %inc8 = add nsw i32 %j.0, 1
  br label %for.cond1, !llvm.loop !8

for.end9:                                         ; preds = %for.cond1
  br label %for.cond10

for.cond10:                                       ; preds = %for.inc24, %for.end9
  %m.0 = phi i32 [ 0, %for.end9 ], [ %add25, %for.inc24 ]
  %sum3.0 = phi i32 [ 0, %for.end9 ], [ %sum3.1, %for.inc24 ]
  %cmp11 = icmp slt i32 %m.0, 5
  br i1 %cmp11, label %for.body12, label %for.end26

for.body12:                                       ; preds = %for.cond10
  br label %for.cond13

for.cond13:                                       ; preds = %for.inc21, %for.body12
  %sum3.1 = phi i32 [ %sum3.0, %for.body12 ], [ %add20, %for.inc21 ]
  %n.0 = phi i32 [ 0, %for.body12 ], [ %inc22, %for.inc21 ]
  %cmp14 = icmp slt i32 %n.0, 5
  br i1 %cmp14, label %for.body15, label %for.end23

for.body15:                                       ; preds = %for.cond13
  %shl_by_pow2 = shl i32 %m.0, 1
  %add_for_mul = add i32 %n.0, %n.0
  %add_for_mul1 = add i32 %add_for_mul, %n.0
  %add18 = add nsw i32 %shl_by_pow2, %add_for_mul1
  %add19 = add nsw i32 %add18, 1
  %add20 = add nsw i32 %sum3.1, %add19
  br label %for.inc21

for.inc21:                                        ; preds = %for.body15
  %inc22 = add nsw i32 %n.0, 1
  br label %for.cond13, !llvm.loop !9

for.end23:                                        ; preds = %for.cond13
  br label %for.inc24

for.inc24:                                        ; preds = %for.end23
  %add25 = add nsw i32 %m.0, 2
  br label %for.cond10, !llvm.loop !10

for.end26:                                        ; preds = %for.cond10
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %sum1.0, i32 noundef %sum2.0, i32 noundef %sum3.0)
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
