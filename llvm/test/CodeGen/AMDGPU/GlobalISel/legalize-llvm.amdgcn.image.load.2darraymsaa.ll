; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=tahiti -stop-after=legalizer -o - %s | FileCheck -check-prefix=GFX6 %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1010 -stop-after=legalizer -o - %s | FileCheck -check-prefix=GFX10NSA %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1100 -stop-after=legalizer -o - %s | FileCheck -check-prefix=GFX10NSA %s

define amdgpu_ps <4 x float> @load_2darraymsaa(<8 x i32> inreg %rsrc, i32 %s, i32 %t, i32 %slice, i32 %fragid) {
  ; GFX6-LABEL: name: load_2darraymsaa
  ; GFX6: bb.1 (%ir-block.0):
  ; GFX6:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX6:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX6:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX6:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX6:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX6:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX6:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX6:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX6:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX6:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX6:   [[COPY8:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX6:   [[COPY9:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX6:   [[COPY10:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX6:   [[COPY11:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX6:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32)
  ; GFX6:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.load.2darraymsaa), 15, [[BUILD_VECTOR1]](<4 x s32>), $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), 0, 0, 0 :: (dereferenceable load (<4 x s32>) from custom "ImageResource")
  ; GFX6:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX6:   $vgpr0 = COPY [[UV]](s32)
  ; GFX6:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX6:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX6:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX6:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  ; GFX10NSA-LABEL: name: load_2darraymsaa
  ; GFX10NSA: bb.1 (%ir-block.0):
  ; GFX10NSA:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX10NSA:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX10NSA:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX10NSA:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX10NSA:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX10NSA:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX10NSA:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX10NSA:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX10NSA:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX10NSA:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX10NSA:   [[COPY8:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX10NSA:   [[COPY9:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX10NSA:   [[COPY10:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX10NSA:   [[COPY11:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX10NSA:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<4 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.load.2darraymsaa), 15, [[COPY8]](s32), [[COPY9]](s32), [[COPY10]](s32), [[COPY11]](s32), [[BUILD_VECTOR]](<8 x s32>), 0, 0, 0 :: (dereferenceable load (<4 x s32>) from custom "ImageResource")
  ; GFX10NSA:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<4 x s32>)
  ; GFX10NSA:   $vgpr0 = COPY [[UV]](s32)
  ; GFX10NSA:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX10NSA:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX10NSA:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX10NSA:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  %v = call <4 x float> @llvm.amdgcn.image.load.2darraymsaa.v4f32.i32(i32 15, i32 %s, i32 %t, i32 %slice, i32 %fragid, <8 x i32> %rsrc, i32 0, i32 0)
  ret <4 x float> %v
}

define amdgpu_ps <4 x float> @load_2darraymsaa_tfe(<8 x i32> inreg %rsrc, i32 addrspace(1)* inreg %out, i32 %s, i32 %t, i32 %slice, i32 %fragid) {
  ; GFX6-LABEL: name: load_2darraymsaa_tfe
  ; GFX6: bb.1 (%ir-block.0):
  ; GFX6:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX6:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX6:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX6:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX6:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX6:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX6:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX6:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX6:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX6:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX6:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX6:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX6:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY8]](s32), [[COPY9]](s32)
  ; GFX6:   [[COPY10:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX6:   [[COPY11:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX6:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX6:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX6:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s32>) = G_BUILD_VECTOR [[COPY10]](s32), [[COPY11]](s32), [[COPY12]](s32), [[COPY13]](s32)
  ; GFX6:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<5 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.load.2darraymsaa), 15, [[BUILD_VECTOR1]](<4 x s32>), $noreg, $noreg, $noreg, [[BUILD_VECTOR]](<8 x s32>), 1, 0, 0 :: (dereferenceable load (<4 x s32>) from custom "ImageResource")
  ; GFX6:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32), [[UV4:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<5 x s32>)
  ; GFX6:   G_STORE [[UV4]](s32), [[MV]](p1) :: (store (s32) into %ir.out, addrspace 1)
  ; GFX6:   $vgpr0 = COPY [[UV]](s32)
  ; GFX6:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX6:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX6:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX6:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  ; GFX10NSA-LABEL: name: load_2darraymsaa_tfe
  ; GFX10NSA: bb.1 (%ir-block.0):
  ; GFX10NSA:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9, $sgpr10, $sgpr11, $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX10NSA:   [[COPY:%[0-9]+]]:_(s32) = COPY $sgpr2
  ; GFX10NSA:   [[COPY1:%[0-9]+]]:_(s32) = COPY $sgpr3
  ; GFX10NSA:   [[COPY2:%[0-9]+]]:_(s32) = COPY $sgpr4
  ; GFX10NSA:   [[COPY3:%[0-9]+]]:_(s32) = COPY $sgpr5
  ; GFX10NSA:   [[COPY4:%[0-9]+]]:_(s32) = COPY $sgpr6
  ; GFX10NSA:   [[COPY5:%[0-9]+]]:_(s32) = COPY $sgpr7
  ; GFX10NSA:   [[COPY6:%[0-9]+]]:_(s32) = COPY $sgpr8
  ; GFX10NSA:   [[COPY7:%[0-9]+]]:_(s32) = COPY $sgpr9
  ; GFX10NSA:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32), [[COPY4]](s32), [[COPY5]](s32), [[COPY6]](s32), [[COPY7]](s32)
  ; GFX10NSA:   [[COPY8:%[0-9]+]]:_(s32) = COPY $sgpr10
  ; GFX10NSA:   [[COPY9:%[0-9]+]]:_(s32) = COPY $sgpr11
  ; GFX10NSA:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY8]](s32), [[COPY9]](s32)
  ; GFX10NSA:   [[COPY10:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; GFX10NSA:   [[COPY11:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; GFX10NSA:   [[COPY12:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; GFX10NSA:   [[COPY13:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; GFX10NSA:   [[AMDGPU_INTRIN_IMAGE_LOAD:%[0-9]+]]:_(<5 x s32>) = G_AMDGPU_INTRIN_IMAGE_LOAD intrinsic(@llvm.amdgcn.image.load.2darraymsaa), 15, [[COPY10]](s32), [[COPY11]](s32), [[COPY12]](s32), [[COPY13]](s32), [[BUILD_VECTOR]](<8 x s32>), 1, 0, 0 :: (dereferenceable load (<4 x s32>) from custom "ImageResource")
  ; GFX10NSA:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32), [[UV4:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[AMDGPU_INTRIN_IMAGE_LOAD]](<5 x s32>)
  ; GFX10NSA:   G_STORE [[UV4]](s32), [[MV]](p1) :: (store (s32) into %ir.out, addrspace 1)
  ; GFX10NSA:   $vgpr0 = COPY [[UV]](s32)
  ; GFX10NSA:   $vgpr1 = COPY [[UV1]](s32)
  ; GFX10NSA:   $vgpr2 = COPY [[UV2]](s32)
  ; GFX10NSA:   $vgpr3 = COPY [[UV3]](s32)
  ; GFX10NSA:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  %v = call { <4 x float>, i32 } @llvm.amdgcn.image.load.2darraymsaa.sl_v4f32i32s.i32(i32 15, i32 %s, i32 %t, i32 %slice, i32 %fragid, <8 x i32> %rsrc, i32 1, i32 0)
  %v.vec = extractvalue { <4 x float>, i32 } %v, 0
  %v.err = extractvalue { <4 x float>, i32 } %v, 1
  store i32 %v.err, i32 addrspace(1)* %out, align 4
  ret <4 x float> %v.vec
}

declare <4 x float> @llvm.amdgcn.image.load.2darraymsaa.v4f32.i32(i32 immarg, i32, i32, i32, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare { <4 x float>, i32 } @llvm.amdgcn.image.load.2darraymsaa.sl_v4f32i32s.i32(i32 immarg, i32, i32, i32, i32, <8 x i32>, i32 immarg, i32 immarg) #0

attributes #0 = { nounwind readonly }
