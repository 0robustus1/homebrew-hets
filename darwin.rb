require 'formula'

class Darwin < Formula

  the_version = '1.4.4'
  homepage 'http://combination.cs.uiowa.edu/Darwin/'
  url "http://combination.cs.uiowa.edu/Darwin/files/darwin_v#{the_version}.tar.gz"
  version the_version
  sha1 '2ce89af874f903afae9f58b454f711fedb8a1606'

  depends_on 'ocaml'

  # The patch is needed for new OCaml versions. Darwin code is not maintained
  # anymore and it uses the removed function Array.create while Array.make is
  # its replacement.
  patch :DATA

  def install
    ENV['MAKEFLAGS'] = '-j1'
    system('python ./configure.py')

    inreplace 'Makefile' do |s|
      s.gsub! ' -w $(WARNING_FLAGS)', ''
    end

    system('make')

    bin.install('darwin')
  end

  def caveats
  end

end
__END__
diff --git a/src/context.ml b/src/context.ml
index 01f554b..5e3fd41 100644
--- a/src/context.ml
+++ b/src/context.ml
@@ -2307,7 +2307,7 @@ let print_multiplication_tables (context: context) (out: out_channel) (problem:
      Term.request_const (Symbol.create_fd_symbol symbol)
    in
    let subterms =
-     Array.create (arity + 2) symbol_term
+     Array.make (arity + 2) symbol_term
    in
    let print subterms result =
      let subterms' =
@@ -2336,7 +2336,7 @@ let print_multiplication_tables (context: context) (out: out_channel) (problem:
  (fun symbol ->
    Print.output_line out (Symbol.to_string symbol ^ ":");
    let subterms =
-     Array.create arity (Term.request_var (Var.create_parametric 0))
+     Array.make arity (Term.request_var (Var.create_parametric 0))
    in
    let print literal =
      Print.output_line out (Term.term_to_string literal.Term.atom)
diff --git a/src/problem_literals.ml b/src/problem_literals.ml
index 10c9871..46f37fd 100644
--- a/src/problem_literals.ml
+++ b/src/problem_literals.ml
@@ -243,7 +243,7 @@ let create (config: config) (bound: bound) (statistic : statistic) (state: state
     (*index = Index.create 8;*)
     index = Discrimination_tree.create_index false (new problem_literal_data);
     bindings = Bindings.create 128;
-    subsumed_clauses = Array.create 32 (-1);
+    subsumed_clauses = Array.make 32 (-1);
     cached_partial_context_unifiers = 0;
   }
