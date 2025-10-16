; ModuleID = '1.ll'
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
  %sum1.0 = phi i32 [ 0, %entry ], [ %add2, %for.inc ]
  %cmp = icmp slt i32 %i.0, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul = mul nsw i32 %i.0, 4
  %add = add nsw i32 %mul, 2
  %div = sdiv i32 %i.0, 4
  %add1 = add nsw i32 %add, %div
  %add2 = add nsw i32 %sum1.0, %add1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  br label %for.cond3

for.cond3:                                        ; preds = %for.inc8, %for.end
  %j.0 = phi i32 [ 20, %for.end ], [ %sub9, %for.inc8 ]
  %sum2.0 = phi i32 [ 0, %for.end ], [ %add7, %for.inc8 ]
  %cmp4 = icmp sgt i32 %j.0, 0
  br i1 %cmp4, label %for.body5, label %for.end10

for.body5:                                        ; preds = %for.cond3
  %sub = sub nsw i32 %j.0, 3
  %add7 = add nsw i32 %sum2.0, %sub
  br label %for.inc8

for.inc8:                                         ; preds = %for.body5
  %sub9 = sub nsw i32 %j.0, 2
  br label %for.cond3, !llvm.loop !8

for.end10:                                        ; preds = %for.cond3
  br label %for.cond11

for.cond11:                                       ; preds = %for.inc25, %for.end10
  %m.0 = phi i32 [ 0, %for.end10 ], [ %inc26, %for.inc25 ]
  %sum3.0 = phi i32 [ 0, %for.end10 ], [ %sum3.1, %for.inc25 ]
  %cmp12 = icmp slt i32 %m.0, 5
  br i1 %cmp12, label %for.body13, label %for.end27

for.body13:                                       ; preds = %for.cond11
  br label %for.cond14

for.cond14:                                       ; preds = %for.inc22, %for.body13
  %sum3.1 = phi i32 [ %sum3.0, %for.body13 ], [ %add21, %for.inc22 ]
  %n.0 = phi i32 [ 0, %for.body13 ], [ %inc23, %for.inc22 ]
  %cmp15 = icmp slt i32 %n.0, 5
  br i1 %cmp15, label %for.body16, label %for.end24

for.body16:                                       ; preds = %for.cond14
  %mul17 = mul nsw i32 %m.0, 2
  %mul18 = mul nsw i32 %n.0, 3
  %add19 = add nsw i32 %mul17, %mul18
  %add20 = add nsw i32 %add19, 1
  %add21 = add nsw i32 %sum3.1, %add20
  br label %for.inc22

for.inc22:                                        ; preds = %for.body16
  %inc23 = add nsw i32 %n.0, 1
  br label %for.cond14, !llvm.loop !9

for.end24:                                        ; preds = %for.cond14
  br label %for.inc25

for.inc25:                                        ; preds = %for.end24
  %inc26 = add nsw i32 %m.0, 1
  br label %for.cond11, !llvm.loop !10

for.end27:                                        ; preds = %for.cond11
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
