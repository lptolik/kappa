# 18 "parsing/linenum.mll"
 
let filename = ref ""
let linenum = ref 0
let linebeg = ref 0

let parse_sharp_line s =
  try
    (* Update the line number and file name *)
    let l1 = ref 0 in
    while let c = s.[!l1] in c < '0' || c > '9' do incr l1 done;
    let l2 = ref (!l1 + 1) in
    while let c = s.[!l2] in c >= '0' && c <= '9' do incr l2 done;
    linenum := int_of_string(String.sub s !l1 (!l2 - !l1));
    let f1 = ref (!l2 + 1) in
    while !f1 < String.length s && s.[!f1] <> '"' do incr f1 done;
    let f2 = ref (!f1 + 1) in 
    while !f2 < String.length s && s.[!f2] <> '"' do incr f2 done;
    if !f1 < String.length s then
      filename := String.sub s (!f1 + 1) (!f2 - !f1 - 1)
  with Failure _ | Invalid_argument _ ->
    Misc.fatal_error "Linenum.parse_sharp_line"

# 25 "parsing/linenum.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\253\255\001\000\254\255\002\000\007\000\017\000\004\000\
    \255\255\008\000\009\000\066\000";
  Lexing.lex_backtrk = 
   "\255\255\255\255\001\000\255\255\255\255\255\255\255\255\000\000\
    \255\255\255\255\255\255\255\255";
  Lexing.lex_default = 
   "\004\000\000\000\255\255\000\000\004\000\004\000\009\000\255\255\
    \000\000\009\000\010\000\009\000";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\003\000\003\000\003\000\002\000\008\000\002\000\
    \005\000\003\000\008\000\008\000\002\000\007\000\007\000\000\000\
    \000\000\000\000\011\000\008\000\000\000\000\000\007\000\000\000\
    \000\000\000\000\000\000\005\000\000\000\000\000\000\000\005\000\
    \000\000\000\000\000\000\009\000\000\000\000\000\000\000\000\000\
    \000\000\011\000\000\000\010\000\000\000\000\000\000\000\006\000\
    \006\000\006\000\006\000\006\000\006\000\006\000\006\000\006\000\
    \006\000\006\000\006\000\006\000\006\000\006\000\006\000\006\000\
    \006\000\006\000\006\000\011\000\008\000\000\000\000\000\007\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\011\000\000\000\010\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \001\000\000\000\001\000\000\000\000\000\000\000\000\000\001\000\
    \001\000\001\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\001\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\001\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\000\000\002\000\004\000\000\000\007\000\004\000\
    \005\000\005\000\009\000\010\000\005\000\009\000\010\000\255\255\
    \255\255\255\255\006\000\006\000\255\255\255\255\006\000\255\255\
    \255\255\255\255\255\255\000\000\255\255\255\255\255\255\005\000\
    \255\255\255\255\255\255\010\000\255\255\255\255\255\255\255\255\
    \255\255\006\000\255\255\006\000\255\255\255\255\255\255\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\006\000\006\000\006\000\006\000\006\000\006\000\006\000\
    \006\000\006\000\006\000\011\000\011\000\255\255\255\255\011\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\011\000\255\255\011\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\004\000\255\255\255\255\255\255\255\255\005\000\
    \009\000\010\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\006\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\011\000";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec skip_line lexbuf =
    __ocaml_lex_skip_line_rec lexbuf 0
and __ocaml_lex_skip_line_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 46 "parsing/linenum.mll"
      ( parse_sharp_line(Lexing.lexeme lexbuf);
        linebeg := Lexing.lexeme_start lexbuf;
        Lexing.lexeme_end lexbuf )
# 143 "parsing/linenum.ml"

  | 1 ->
# 51 "parsing/linenum.mll"
      ( incr linenum;
        linebeg := Lexing.lexeme_start lexbuf;
        Lexing.lexeme_end lexbuf )
# 150 "parsing/linenum.ml"

  | 2 ->
# 55 "parsing/linenum.mll"
      ( incr linenum;
        linebeg := Lexing.lexeme_start lexbuf;
        raise End_of_file )
# 157 "parsing/linenum.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_skip_line_rec lexbuf __ocaml_lex_state

;;

# 59 "parsing/linenum.mll"
 

let for_position file loc =
  let ic = open_in_bin file in
  let lb = Lexing.from_channel ic in
  filename := file;
  linenum := 1;
  linebeg := 0;
  begin try
    while skip_line lb <= loc do () done
  with End_of_file -> ()
  end;
  close_in ic;
  (!filename, !linenum - 1, !linebeg)


# 180 "parsing/linenum.ml"
