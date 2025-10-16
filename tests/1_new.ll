; ModuleID = '1_simpl.ll'
source_filename = "1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [22 x i8] c"Results: %d %d %d %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %10, %for.inc ]
  %sum1.0 = phi i32 [ 0, %entry ], [ %add1, %for.inc ]
  %0 = phi i32 [ 0, %entry ], [ %13, %for.inc ]
  %1 = phi i32 [ 0, %entry ], [ %14, %for.inc ]
  %2 = phi i32 [ 1, %entry ], [ %15, %for.inc ]
  %3 = phi i32 [ 1, %entry ], [ %16, %for.inc ]
  %4 = phi i32 [ 17, %entry ], [ %17, %for.inc ]
  %5 = phi i32 [ 0, %entry ], [ %18, %for.inc ]
  %6 = phi i32 [ 0, %entry ], [ %19, %for.inc ]
  %7 = phi i32 [ 0, %entry ], [ %20, %for.inc ]
  %8 = phi i32 [ 2, %entry ], [ %21, %for.inc ]
  %9 = phi i32 [ 18, %entry ], [ %22, %for.inc ]
  %10 = phi i32 [ 1, %entry ], [ %23, %for.inc ]
  %cmp = icmp slt i32 %i.0, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %11 = mul i32 %0, 4
  %add = add nsw i32 %1, 2
  %add1 = add nsw i32 %sum1.0, %add
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %12 = add i32 %0, 1
  %13 = add i32 %0, 1
  %14 = add i32 %1, 4
  %15 = add i32 %2, 1
  %16 = add i32 %3, 1
  %17 = add i32 %4, -2
  %18 = add i32 %5, 3
  %19 = add i32 %6, 2
  %20 = add i32 %7, 8
  %21 = add i32 %8, 2
  %22 = add i32 %9, -2
  %23 = add i32 %10, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc6, %for.end
  %j.0 = phi i32 [ 20, %for.end ], [ %32, %for.inc6 ]
  %sum2.0 = phi i32 [ 0, %for.end ], [ %add5, %for.inc6 ]
  %24 = phi i32 [ 20, %for.end ], [ %35, %for.inc6 ]
  %25 = phi i32 [ 1, %for.end ], [ %36, %for.inc6 ]
  %26 = phi i32 [ 1, %for.end ], [ %37, %for.inc6 ]
  %27 = phi i32 [ 17, %for.end ], [ %38, %for.inc6 ]
  %28 = phi i32 [ 0, %for.end ], [ %39, %for.inc6 ]
  %29 = phi i32 [ 0, %for.end ], [ %40, %for.inc6 ]
  %30 = phi i32 [ 0, %for.end ], [ %41, %for.inc6 ]
  %31 = phi i32 [ 2, %for.end ], [ %42, %for.inc6 ]
  %32 = phi i32 [ 18, %for.end ], [ %43, %for.inc6 ]
  %cmp3 = icmp sgt i32 %j.0, 0
  br i1 %cmp3, label %for.body4, label %for.end8

for.body4:                                        ; preds = %for.cond2
  %33 = sub i32 %24, 3
  %add5 = add nsw i32 %sum2.0, %27
  br label %for.inc6

for.inc6:                                         ; preds = %for.body4
  %34 = sub i32 %24, 2
  %35 = add i32 %24, -2
  %36 = add i32 %25, 1
  %37 = add i32 %26, 1
  %38 = add i32 %27, -2
  %39 = add i32 %28, 3
  %40 = add i32 %29, 2
  %41 = add i32 %30, 8
  %42 = add i32 %31, 2
  %43 = add i32 %32, -2
  br label %for.cond2, !llvm.loop !8

for.end8:                                         ; preds = %for.cond2
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc23, %for.end8
  %m.0 = phi i32 [ 0, %for.end8 ], [ %45, %for.inc23 ]
  %sum3.0 = phi i32 [ 0, %for.end8 ], [ %sum3.1, %for.inc23 ]
  %44 = phi i32 [ 0, %for.end8 ], [ %67, %for.inc23 ]
  %45 = phi i32 [ 1, %for.end8 ], [ %68, %for.inc23 ]
  %46 = phi i32 [ 0, %for.end8 ], [ %69, %for.inc23 ]
  %47 = phi i32 [ 0, %for.end8 ], [ %70, %for.inc23 ]
  %48 = phi i32 [ 2, %for.end8 ], [ %71, %for.inc23 ]
  %cmp10 = icmp slt i32 %m.0, 5
  br i1 %cmp10, label %for.body11, label %for.end25

for.body11:                                       ; preds = %for.cond9
  br label %for.cond12

for.cond12:                                       ; preds = %for.inc20, %for.body11
  %n.0 = phi i32 [ 0, %for.body11 ], [ %51, %for.inc20 ]
  %sum3.1 = phi i32 [ %sum3.0, %for.body11 ], [ %add19, %for.inc20 ]
  %49 = phi i32 [ 0, %for.body11 ], [ %59, %for.inc20 ]
  %50 = phi i32 [ 1, %for.body11 ], [ %60, %for.inc20 ]
  %51 = phi i32 [ 1, %for.body11 ], [ %61, %for.inc20 ]
  %52 = phi i32 [ 0, %for.body11 ], [ %62, %for.inc20 ]
  %53 = phi i32 [ 0, %for.body11 ], [ %63, %for.inc20 ]
  %54 = phi i32 [ 0, %for.body11 ], [ %64, %for.inc20 ]
  %55 = phi i32 [ 2, %for.body11 ], [ %65, %for.inc20 ]
  %cmp13 = icmp slt i32 %n.0, 5
  br i1 %cmp13, label %for.body14, label %for.end22

for.body14:                                       ; preds = %for.cond12
  %56 = mul i32 %44, 2
  %57 = mul i32 %49, 3
  %add17 = add nsw i32 %46, %52
  %add18 = add nsw i32 %add17, 1
  %add19 = add nsw i32 %sum3.1, %add18
  br label %for.inc20

for.inc20:                                        ; preds = %for.body14
  %58 = add i32 %49, 1
  %59 = add i32 %49, 1
  %60 = add i32 %50, 1
  %61 = add i32 %51, 1
  %62 = add i32 %52, 3
  %63 = add i32 %53, 2
  %64 = add i32 %54, 8
  %65 = add i32 %55, 2
  br label %for.cond12, !llvm.loop !9

for.end22:                                        ; preds = %for.cond12
  br label %for.inc23

for.inc23:                                        ; preds = %for.end22
  %66 = add i32 %44, 1
  %67 = add i32 %44, 1
  %68 = add i32 %45, 1
  %69 = add i32 %46, 2
  %70 = add i32 %47, 8
  %71 = add i32 %48, 2
  br label %for.cond9, !llvm.loop !10

for.end25:                                        ; preds = %for.cond9
  br label %for.cond28

for.cond28:                                       ; preds = %for.inc36, %for.end25
  %sum4.0 = phi i32 [ 0, %for.end25 ], [ %add35, %for.inc36 ]
  %i27.0 = phi i32 [ 0, %for.end25 ], [ %74, %for.inc36 ]
  %72 = phi i32 [ 0, %for.end25 ], [ %77, %for.inc36 ]
  %73 = phi i32 [ 0, %for.end25 ], [ %78, %for.inc36 ]
  %74 = phi i32 [ 2, %for.end25 ], [ %79, %for.inc36 ]
  %cmp29 = icmp slt i32 %i27.0, 10
  br i1 %cmp29, label %for.body30, label %for.end38

for.body30:                                       ; preds = %for.cond28
  %75 = mul i32 %72, 4
  %mul33 = mul nsw i32 2, 2
  %add34 = add nsw i32 %73, %mul33
  %add35 = add nsw i32 %sum4.0, %add34
  br label %for.inc36

for.inc36:                                        ; preds = %for.body30
  %76 = add i32 %72, 2
  %77 = add i32 %72, 2
  %78 = add i32 %73, 8
  %79 = add i32 %74, 2
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
