;;;============================================================================

;;; File: "_codegen#.scm"

;;; Copyright (c) 2010-2012 by Marc Feeley, All Rights Reserved.

;;;============================================================================

(namespace ("_codegen#"

codegen-implement

make-codegen-context
codegen-context-listing-format
codegen-context-listing-format-set!
codegen-context-arch
codegen-context-arch-set!
codegen-context-fixup-list
codegen-context-fixup-list-set!

))

;;;============================================================================

(define-macro (codegen-implement)
  `(begin))

;;;============================================================================
