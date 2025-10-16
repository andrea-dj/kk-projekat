; ModuleID = '1.ll'
source_filename = "1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [22 x i8] c"Results: %d %d %d %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %sum1.0 = phi i32 [ 0, %entry ], [ %add1, %for.inc ]
  %cmp = icmp slt i32 %i.0, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul = mul nsw i32 %i.0, 4
  %add = add nsw i32 %mul, 2
  %add1 = add nsw i32 %sum1.0, %add
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc6, %for.end
  %j.0 = phi i32 [ 20, %for.end ], [ %sub7, %for.inc6 ]
  %sum2.0 = phi i32 [ 0, %for.end ], [ %add5, %for.inc6 ]
  %cmp3 = icmp sgt i32 %j.0, 0
  br i1 %cmp3, label %for.body4, label %for.end8

for.body4:                                        ; preds = %for.cond2
  %sub = sub nsw i32 %j.0, 3
  %add5 = add nsw i32 %sum2.0, %sub
  br label %for.inc6

for.inc6:                                         ; preds = %for.body4
  %sub7 = sub nsw i32 %j.0, 2
  br label %for.cond2, !llvm.loop !8

for.end8:                                         ; preds = %for.cond2
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc23, %for.end8
  %m.0 = phi i32 [ 0, %for.end8 ], [ %inc24, %for.inc23 ]
  %sum3.0 = phi i32 [ 0, %for.end8 ], [ %sum3.1, %for.inc23 ]
  %cmp10 = icmp slt i32 %m.0, 5
  br i1 %cmp10, label %for.body11, label %for.end25

for.body11:                                       ; preds = %for.cond9
  br label %for.cond12

for.cond12:                                       ; preds = %for.inc20, %for.body11
  %n.0 = phi i32 [ 0, %for.body11 ], [ %inc21, %for.inc20 ]
  %sum3.1 = phi i32 [ %sum3.0, %for.body11 ], [ %add19, %for.inc20 ]
  %cmp13 = icmp slt i32 %n.0, 5
  br i1 %cmp13, label %for.body14, label %for.end22

for.body14:                                       ; preds = %for.cond12
  %mul15 = mul nsw i32 %m.0, 2
  %mul16 = mul nsw i32 %n.0, 3
  %add17 = add nsw i32 %mul15, %mul16
  %add18 = add nsw i32 %add17, 1
  %add19 = add nsw i32 %sum3.1, %add18
  br label %for.inc20

for.inc20:                                        ; preds = %for.body14
  %inc21 = add nsw i32 %n.0, 1
  br label %for.cond12, !llvm.loop !9

for.end22:                                        ; preds = %for.cond12
  br label %for.inc23

for.inc23:                                        ; preds = %for.end22
  %inc24 = add nsw i32 %m.0, 1
  br label %for.cond9, !llvm.loop !10

for.end25:                                        ; preds = %for.cond9
  br label %for.cond28

for.cond28:                                       ; preds = %for.inc36, %for.end25
  %sum4.0 = phi i32 [ 0, %for.end25 ], [ %add35, %for.inc36 ]
  %i27.0 = phi i32 [ 0, %for.end25 ], [ %add37, %for.inc36 ]
  %cmp29 = icmp slt i32 %i27.0, 10
  br i1 %cmp29, label %for.body30, label %for.end38

for.body30:                                       ; preds = %for.cond28
  %mul32 = mul nsw i32 %i27.0, 4
  %mul33 = mul nsw i32 2, 2
  %add34 = add nsw i32 %mul32, %mul33
  %add35 = add nsw i32 %sum4.0, %add34
  br label %for.inc36

for.inc36:                                        ; preds = %for.body30
  %add37 = add nsw i32 %i27.0, 2
  br label %for.cond28, !llvm.loop !11

for.end38:                                        ; preds = %for.cond28
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %sum1.0, i32 noundef %sum2.0, i32 noundef %sum3.0, i32 noundef %sum4.0)
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
