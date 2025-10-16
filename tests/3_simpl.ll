; ModuleID = '3.ll'
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
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %for.inc ]
  %total.0 = phi i32 [ 0, %entry ], [ %add1, %for.inc ]
  %cmp = icmp sle i32 %i.0, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %add = add nsw i32 %i.0, 1
  %add1 = add nsw i32 %total.0, %add
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc6, %for.end
  %j.0 = phi i32 [ 20, %for.end ], [ %sub, %for.inc6 ]
  %total.1 = phi i32 [ %total.0, %for.end ], [ %add5, %for.inc6 ]
  %cmp3 = icmp sgt i32 %j.0, 0
  br i1 %cmp3, label %for.body4, label %for.end7

for.body4:                                        ; preds = %for.cond2
  %mul = mul nsw i32 %j.0, 2
  %add5 = add nsw i32 %total.1, %mul
  br label %for.inc6

for.inc6:                                         ; preds = %for.body4
  %sub = sub nsw i32 %j.0, 3
  br label %for.cond2, !llvm.loop !8

for.end7:                                         ; preds = %for.cond2
  br label %for.cond8

for.cond8:                                        ; preds = %for.inc13, %for.end7
  %total.2 = phi i32 [ %total.1, %for.end7 ], [ %add12, %for.inc13 ]
  %k.0 = phi i32 [ 5, %for.end7 ], [ %add14, %for.inc13 ]
  %cmp9 = icmp slt i32 %k.0, 15
  br i1 %cmp9, label %for.body10, label %for.end15

for.body10:                                       ; preds = %for.cond8
  %mul11 = mul nsw i32 %k.0, 3
  %call = call i32 @sumAndDouble(i32 noundef %k.0, i32 noundef %mul11)
  %add12 = add nsw i32 %total.2, %call
  br label %for.inc13

for.inc13:                                        ; preds = %for.body10
  %add14 = add nsw i32 %k.0, 2
  br label %for.cond8, !llvm.loop !9

for.end15:                                        ; preds = %for.cond8
  br label %for.cond16

for.cond16:                                       ; preds = %for.inc22, %for.end15
  %total.3 = phi i32 [ %total.2, %for.end15 ], [ %add21, %for.inc22 ]
  %x.0 = phi i32 [ 0, %for.end15 ], [ %add23, %for.inc22 ]
  %cmp17 = icmp slt i32 %x.0, 20
  br i1 %cmp17, label %for.body18, label %for.end24

for.body18:                                       ; preds = %for.cond16
  %add19 = add nsw i32 %x.0, 1
  %mul20 = mul nsw i32 %add19, 2
  %add21 = add nsw i32 %total.3, %mul20
  br label %for.inc22

for.inc22:                                        ; preds = %for.body18
  %add23 = add nsw i32 %x.0, 4
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
