open Data_structures
open Arithmetics 
open Ode_print_sig 




let stdprint = 
  {
  print_string = print_string ;
  print_int = print_int ;
  print_newline = print_newline ;
  print_float = print_float ;
  chan = [stdout] 
  } 
    


let all_fields x  = [x.dump;x.matlab;x.mathematica;x.latex;x.matlab_aux;x.data;x.kappa;x.txt;x.matlab_jacobian;x.matlab_size]

      
module CSet = Set.Make (struct type t = out_channel let compare = compare end)


(************************)
(* PRINTING PRIMITIVES  *)
(************************)
    
let string_of_intermediar_var var rule = 
("r"^var^"v"^rule)




let print_intermediar_var print var rule  =
  let _ = 
    match print.matlab with 
      None -> () 
    | Some matlab -> (matlab.print_string "r";
		       matlab.print_string var;
		       matlab.print_string "v";
		       matlab.print_string rule;
		       matlab.print_string "")
  in
  let _ = 
    match print.matlab_aux with 
      None -> () 
    | Some matlab -> (matlab.print_string "r";
		       matlab.print_string var;
		       matlab.print_string "v";
		       matlab.print_string rule;
		       matlab.print_string "")
  in
  let _ = 
    match print.mathematica with 
      None -> ()
    | Some mathematica -> 
	(mathematica.print_string "r";
	 mathematica.print_string var;
         mathematica.print_string "v";
         mathematica.print_string rule) in 
  let _ = 
    match print.latex with 
      None -> ()
    | Some latex -> 
	(latex.print_string "\\oderv";
	 latex.print_string "{";
	 latex.print_string var;
	 latex.print_string "}{";
	 latex.print_string rule;
	 latex.print_string "}")
  in 
  ()
	 
	 
let pprint_float  print f = 
  let g x = 
    match x with 
      None -> () 
    | Some a -> a.print_float f in
  List.iter g (all_fields print)

let pprint_string  print f = 
  let g x = 
    match x with 
      None -> () 
    | Some a -> a.print_string f in
  List.iter g (all_fields print)

let pprint_newline  print  = 
  let g x = 
    match x with 
      None -> () 
    | Some a -> (a.print_newline ();List.iter flush a.chan)
  in
  List.iter g (all_fields print)

let pprint_int  print f = 
  let g x = 
    match x with 
      None -> () 
    | Some a -> a.print_int f in
  List.iter g (all_fields print)


let pprint_bool print f = 
  pprint_string print (if f then "True" else "False")


let pprint_var print k i =
  let _ = 
    match print.matlab 
    with 
      None -> ()
    | Some a -> a.print_string k;a.print_string "(";a.print_string i;a.print_string ")"
  in
  let _ = 
    match print.matlab_aux 
    with 
      None -> ()
    | Some a -> a.print_string k;a.print_string "(";a.print_string i;a.print_string ")"
  in 
  let _ = 
    match print.matlab_jacobian 
    with 
      None -> ()
    | Some a -> a.print_string k;a.print_string "(";a.print_string i;a.print_string ")"
  in 
  let _ = 
    match print.mathematica 
    with 
      None -> () 
    | Some a -> a.print_string k;a.print_string i
  in
  let _ = 
    match print.dump
    with 
      None -> ()
    | Some a -> a.print_string k;a.print_string "(";a.print_string i;a.print_string ")"
  in
  let _ = 
    match print.latex
    with 
      None -> ()
    | Some a -> 
	begin
	  a.print_string "\\odevar{";
	  a.print_string k;
	  a.print_string "}{";
	  a.print_string i;
	  a.print_string "}"
	end in 
  ()

let pprint_lvar print k i =
  let _ = 
    match print.mathematica 
    with 
      None -> () 
    | Some a -> a.print_string k;a.print_string i
  in
  let _ = 
    match print.dump
    with 
      None -> () 
    | Some a -> a.print_string k;a.print_string i
  in
  let _ = 
    match print.latex
    with 
      None -> ()
    | Some a -> 
	begin
	  a.print_string "\\odediff{";
	  a.print_string k;
	  a.print_string "}{";
	  a.print_string i;
	  a.print_string "}"
	end
  in 
  ()


let pprint_derivate print i = 
  let _ = 
    match print.matlab  with 
      None -> ()
    | Some a -> a.print_string "d" in
  let _ = 
    match print.matlab_aux  with 
      None -> ()
    | Some a -> a.print_string "d" in
  let _ = pprint_lvar print "y" (string_of_int i) in
  let _ = 
    match print.mathematica with 
      None -> ()
    | Some a -> a.print_string "'[t]" 
  in 
  () 

let pprint_ty print = 
 let _ = 
   match print.mathematica with 
     None -> ()
  | Some a -> a.print_string "[t]"
 in 
 let _ = 
   match print.matlab with 
     None -> ()
   | Some a -> a.print_string "(y)"
 in 
 let _ = 
   match print.matlab_aux with 
     None -> ()
   | Some a -> a.print_string "(y)"
 in  
 let _ = 
   match print.dump with 
     None -> ()
   | Some a -> a.print_string "(y)"
 in 
 ()

   

let pprint_t print = 
 let _ = 
   match print.mathematica with 
     None -> ()
  | Some a -> a.print_string "[t]"
 in () 


let pprint_zero print = 
  match print.mathematica with 
    None -> ()
  | Some a -> a.print_string "[0]" 

let pprint_initvar print k = 
  let _ = pprint_var print "y" (string_of_int k) in
  let _ = pprint_zero print in ()
    
let pprint_equal print = 
  let _ = 
    match print.mathematica with 
      Some print -> print.print_string "=="
    | None -> ()
  in 
  let _ = 
    match print.latex with 
      Some print -> print.print_string "\\odeequal"
    | None -> ()
  in 
  ()
    
 
let pprint_assign print = 
  let _ = 
    match print.mathematica with 
      Some print -> print.print_string "="
    | None -> ()
  in pprint_string print "=" 

let remove_latex print = {print with latex = None} 
let keep_latex print = {print with matlab = None ; matlab_aux=None;matlab_jacobian = None ; mathematica = None ;matlab_size = None} 
let keep_aux print = {print with latex=None;matlab=None;mathematica=None;matlab_jacobian = None;matlab_size = None} 
let keep_jac print = {print with latex=None;matlab=None;mathematica=None;matlab_aux=None;matlab_size = None }
let keep_size print = {print with latex=None;matlab=None;mathematica=None;matlab_aux=None;matlab_jacobian=None}

let pprint_eq_separator print = 
  let print' = remove_latex print in 
  let _ = pprint_string print' "," in 
  let _ = 
    match print.latex with 
      None -> ()
    | Some a -> a.print_string "}"
  in ()

let pprint_as_separator print = 
  let print' = remove_latex print in 
  let _ = pprint_string print' ";" in 
  let _ = 
    match print.latex with 
      None -> ()
    | Some a -> a.print_string "\\odeassep"
  in ()

let pprint_vart print = 
  let _ =
    match print.mathematica 
    with 
      Some a -> a.print_string "[t_]"
    | None -> ()
  in () 

let pprint_abstract print x = 
  let _ = 
    match print.matlab with 
    | None -> ()
    | Some a -> a.print_string ("@("^x^")")
  in 
  let _ = 
    match print.matlab_aux with 
    | None -> ()
    | Some a -> a.print_string ("@("^x^")")
  in  () 

let pprint_assign print =
  let _ = 
    match print.mathematica with 
      None -> ()
    | Some a -> a.print_string ":="
  in let _ = 
    match print.matlab with 
      None -> ()
    | Some a -> a.print_string "="
  in
  let _ = 
    match print.matlab_aux with 
	None -> ()
      | Some a -> a.print_string "="
  in
  let _ = 
    match print.latex with 
	None -> ()
      | Some a -> a.print_string "\\odeequal"
  in 
  () 

let pprint_commandsep print = 
  let _ = 
    match print.mathematica with 
      None -> ()
    | Some a -> a.print_string  ";"
  in 
  let _ = 
    match print.matlab with 
      None -> ()
    | Some a -> a.print_string ";"
  in 
  let _ = 
    match print.matlab_aux with 
	None -> ()
      | Some a -> a.print_string ";"
  in   () 
	 
	 


let pprint_ODE_head print file file_jac file_size = 
  let print_latex = keep_latex print in 
  let print = remove_latex print in 
  let print_main = {print with matlab_aux = None ; matlab_jacobian = None ; matlab_size = None  } in
  let print_aux = keep_aux print in
  let print_jac = keep_jac print in  
  let print_size = keep_size print in 
  let _ = pprint_string print_main "% THINGS THAT ARE KNOWN FROM KAPPA FILE AND COMPLX OPTIONS;\n" in 
  let _ = pprint_string print_main "% \n" in 
  let _ = pprint_string print_main "% init - the initial abundances of each fragment " in
  let _ = pprint_string print_main "% tinit - the initial simulation time (likely 0)" in 
  let _ = pprint_string print_main "% tfinal - the final simulation time " in 
  let _ = pprint_string print_main "% num_t_point - the number of time points to return " in 
  let _ = pprint_string print_main "\n" in 
  let _ = pprint_string print_main "tinit" in 
  let _ = pprint_assign print_main in 
  let _ = pprint_float print_main (!Config_complx.ode_init_time) in
  let _ = pprint_commandsep print_main in
  let _ = pprint_newline print_main  in 
  let _ = pprint_string print_main  "tend" in 
  let _ = pprint_assign print_main in 
  let _ = pprint_float print_main (!Config_complx.ode_final_time) in
  let _ = pprint_commandsep print_main in
  let _ = pprint_newline print_main in 
  let print = remove_latex print_main in 
  let size = Tools.cut file_size^"()" in 
  let _ = pprint_string print_main  "num_t_point" in 
  let _ = pprint_assign print_main  in 
  let _ = pprint_int print_main (!Config_complx.ode_points) in
  let _ = pprint_commandsep print_main in
  let _ = pprint_newline print_main in 
  let _ = pprint_newline print_main in
  let _ = pprint_string print_main ("init = sparse(@"^size^",1)") in 
  let _ = pprint_commandsep print_main in 
  let _ = pprint_newline print_main in 
  let _ = pprint_newline print_main in    
  let _ = pprint_string print_aux ("function dydt="^(Tools.cut file)^"(t,y)\n\n\n") in 
  let _ = pprint_string print_jac ("function Jac="^(Tools.cut file_jac)^"(t,y)\n\nJac = sparse(@"^size^",@"^size^");\n\n") in 
  let _ = pprint_string print_latex "\\odebeforeequs\n" in 
  let _ = pprint_string print_size "function Size=" in
  let _ = pprint_string print_size size in
  let _ = pprint_newline print_size in 
  let _ = pprint_newline print_size in 
  let _ = pprint_string print_size "Size = " in 
 ()

let pprint_ODE_head' print = 
  let _ = 
     match print.mathematica 
     with 
       None -> ()
     | Some a -> 
	 let _ = a.print_string "s=NDSolve[{" in
	 () in 
  let _ = 
    match print.matlab 
    with 
      None -> ()
    | Some a -> 
	let _ = a.print_string "options = odeset('OutputSel',[1]);" in
	() 
  in 
  let _ = 
    match print.matlab_aux 
    with 
	None -> () 
      | Some a -> 
	  let _ = a.print_string "\n\n\ndydt = ["
	  in () 
  in
    () 



let pprint_ODE_middle0 print = ()
(*  let _ = 
    match print.matlab with 
      None -> ()
    | Some a -> a.print_string "\n init = [\n"
  in () *)


let pprint_ODE_middle1 print = 
  let _ = 
    match print.mathematica with 
      None -> ()
    | Some a -> a.print_string "},\n{" 
  in ()


let pprint_ODE_middle2 print aux_file jac_file = 
  let _ = 
    match print.mathematica with 
      None -> () 
    | Some a -> a.print_string "},{t,tinit,tend}]\nPlot[Evaluate[{" in
  let _ = 
    match print.matlab with 
      None -> ()
    | Some a -> 
	begin
	  let _ = 
	    a.print_string ("\n\n\noptions = odeset('RelTol', 1e-3,\n                 'AbsTol', 1e-3,\n                'MaxStep', tend,\n                  'Jacobian', @"^(Tools.cut jac_file)^");\n\n")
	  in
          let _ =
	    a.print_string ("soln = ode2r(@"^(Tools.cut aux_file)^",[tinit tend],init,options);\n\nt = linspace(tinit, tend, num_t_point+1);\ny = interp1(soln.x, soln.y, t, 'pchip');") in 
	    ()

	end
  in 
    ()

let pprint_ODE_foot print = 
  let _ = 
    match print.mathematica with 
    None -> ()
  | Some a -> a.print_string "}/.s],{t,tinit,tend},PlotRange->All]\n" in
  let _ = 
    match print.latex with 
      None -> ()
    | Some a -> a.print_string "\\odeafterequs" in ()


let forbidden_char x = 
  match x with 
    '%' | '_' -> true 
  | _ -> false
  
let print_comment print s = 
  let _ = 
    match print.mathematica with 
      None -> ()
    | Some a -> a.print_string ("\n(*"^s^"*)") 
  in let _ = 
    match print.matlab with 
      None -> ()
    | Some a -> a.print_string ("\n %"^s^"\n")
  in 
  let _ = 
    match print.matlab_aux with 
      None -> ()
    | Some a -> a.print_string ("\n %"^s^"\n")
  in 
  let _ = 
    match print.latex with 
      None -> ()
    | Some a ->
	String.iter 
	  (fun x -> 
	    if forbidden_char x then 
	      a.print_string ("\\"^(String.make 1 x))
	    else
	      a.print_string (String.make 1 x))
	  s
  in () 

let pprint_y print =
  let _ = 
    match print.matlab with 
      None -> ()
    | Some a -> a.print_string "(y)"
  in
  let _ = 
    match print.matlab_aux  with 
	None -> ()
      | Some a -> a.print_string "(y)"
  in 
  let _ = 
    match print.dump with 
	None -> ()
      | Some a -> a.print_string "(y)"
  in ()
       

let channel_set print set = 
  let f x set = 
    match x with None -> set
    | Some x ->
	List.fold_left
	  (fun set a -> CSet.add a set)
	  set x.chan
  in
  List.fold_left
    (fun set a -> f a set)
    set 
    (all_fields print)


let rec print_expr  print bool bool2  x = 
  match x with
     Constf f -> pprint_float print f
   | Letter s -> pprint_string print  s 
   | Const i ->  pprint_int print i 
   | Vari (v,r) -> (print_intermediar_var print r (string_of_int v);(if bool then pprint_ty print else if bool2 then pprint_zero print else ())) 
   | Vark i ->   pprint_var print "k" i 
   | Var i ->  (pprint_var print "y" (string_of_int i);(if bool then pprint_t print else if bool2 then pprint_zero print else ()))
   | Vardi (i,r,j) -> 
       begin 
	 pprint_string print "d";
	 pprint_string print (string_of_int i);
	 pprint_string print "_d";
	 pprint_string print (string_of_int j);
	 pprint_string print "r";
	 pprint_string print r
       end
   | Shortcut (s,a) -> (print_intermediar_var print s a;(if bool then pprint_t print else if bool2 then pprint_zero print else ())) 
   | Div (a,b) -> 
       begin
	print_atom print bool  bool2 a;
	pprint_string print  "/";
	print_atom print bool bool2  b
       end
	 
  | Mult (a,b) -> 
      begin
	print_atom print bool bool2  a;
        pprint_string print "*";
	print_atom print bool bool2 b
      end 
  | Plus (a,b) -> 
      begin
	(match a with 
	   Plus _ -> print_expr 
	|  _ -> print_atom ) print bool bool2 a;
	pprint_string print "+";
	(match b with 
	  Plus _ -> print_expr 
	|  _ -> print_atom)  print  bool bool2  b
      end
  | Eps -> pprint_string print "e"
and print_atom print  bool bool2 x = 
  if is_atomic x 
  then print_expr print  bool  bool2 x 
  else 
    begin
      pprint_string print  "(";
      print_expr print bool bool2 x;
      pprint_string print  ")"
    end

let print_expr_no_latex = print_expr 

let rec print_expr  print bool bool2  x = 
   match x with
     Constf f -> 
       let _ = pprint_string print "{" in 
       let _ = pprint_float print f in 
       let _ = pprint_string print "}" in 
       ()
   | Letter s -> pprint_string print  s 
   | Const i ->  
       let _ = pprint_string print "{" in 
       let _ = pprint_int print i in 
       let _ = pprint_string print "}" in 
       ()

   | Vardi (i,r,j) -> 
       begin 
	 pprint_string print "d";
	 pprint_string print (string_of_int i);
	 pprint_string print "_d";
	 pprint_string print (string_of_int j);
	 pprint_string print "r";
	 pprint_string print r
       end
   | Vari (v,r) -> (print_intermediar_var print r (string_of_int v);(if bool then pprint_ty print else if bool2 then pprint_zero print else ())) 
   | Vark i ->   pprint_var print "k" i 
   | Var i ->  (pprint_var print "y" (string_of_int i);(if bool then pprint_t print else if bool2 then pprint_zero print else ()))
   | Shortcut (s,a) -> (print_intermediar_var print s a;(if bool then pprint_t print else if bool2 then pprint_zero print else ())) 
   | Div (a,b) -> 
       begin
	pprint_string print "\\odefrac{";
	 print_atom print bool  bool2 a;
	pprint_string print  "}{";
	print_atom print bool bool2  b;
	 pprint_string print "}"
       end
	
   | Mult(Constf -1.,a) 
   | Mult(a,Constf -1.) 
   | Mult(Const -1,a) 
   | Mult(a,Const -1) -> 
       begin 
	 pprint_string print "\\odeuniminus";
	 print_expr print bool bool2 a 
       end
   | Mult (a,b) -> 
       begin
	(match a with 
	   Mult _ -> print_expr 
	|  _ -> print_atom ) print bool bool2 a;
	pprint_string print "\\odetime";
	(match b with 
	  Mult _ -> print_expr 
	|  _ -> print_atom)  print  bool bool2  b
      end
  | Plus (a,b) -> 
      begin
	(match a with 
	   Plus _ -> print_expr 
	|  _ -> print_atom ) print bool bool2 a;
	pprint_string print " \\odeplus ";
	(match b with 
	  Plus _ -> print_expr 
	|  _ -> print_atom)  print  bool bool2  b
      end
  | Eps -> pprint_string print "\\varepsilon"
and print_atom print  bool bool2 x = 
  if is_atomic x 
  then print_expr print  bool  bool2 x 
  else 
    begin
      pprint_string print  "(";
      print_expr print bool bool2 x;
      pprint_string print  ")"
    end

let print_expr print bool bool2 x = 
  let print' = remove_latex print in 
  let print_latex = keep_latex print in 
  let _ = print_expr_no_latex print' bool bool2 x in
  let _ = 
    match print.latex
    with 
      None -> ()
    | Some a -> print_expr print_latex  bool bool2 x 
  in ()
  

 let dump_prod (prod,jac) init obs (init_t,final,step) print_ODE_mathematica print_ODE_matlab print_ODE_matlab_aux print_ODE_matlab_jac print_ODE_matlab_size output_data file_aux file_jac  size  = 
    let print_ODE = print_ODE_mathematica in 
    let print_latex = keep_latex print_ODE_mathematica in 
    let print_ODE_wo_latex = remove_latex print_ODE_mathematica in 
    let _ = pprint_ODE_head' print_ODE in
    let _ = pprint_string print_latex "\\odesystem{" in 
    let bool  = 
      Arraymap.fold 
	(fun k b bool ->
	  let _ = if bool then pprint_eq_separator print_ODE in 
	  let _ = pprint_newline print_ODE in 
          let _ = pprint_string print_latex "\\odeequ{" in 
	  let _ = pprint_derivate print_ODE k in
	  let _ = pprint_equal print_ODE in 
	  let _ = List.fold_left 
	      (fun bool (a,b) ->
		let _ = 
		  if bool then 
		    let _ = pprint_string print_latex " " in 
		    let _ = pprint_string print_ODE "+" in 
		    let _ = pprint_string print_latex " " in 
		    ()
		  else 
		    () in
		print_expr print_ODE true false (simplify_expr (Mult(Const a,b)));
			  true) 
	      false b in 
	  true)
	prod  false in

    let bool  = 
      Arraymap.fold 
	(fun k b bool -> 
	  let _ = if bool then pprint_eq_separator print_ODE in 
	  let _ = pprint_newline print_ODE in 
	  let _ = pprint_string print_latex "\\odeequ{" in 
	  let _ = pprint_initvar print_ODE k in
	  let _ = if k=0 then (print_string "BUG";Printf.fprintf stdout "BUG\n") in 
	   
	  let _ = pprint_equal print_ODE in
	  let _ = print_expr print_ODE true false  (simplify_expr b) in
	  let _ = 
	    try let _ = Arraymap.find  k prod in ()  
	    with Not_found -> 
	      let _ = if bool then pprint_eq_separator print_ODE in 
	      let _ = pprint_newline print_ODE in 
	      let _ = pprint_string print_latex "\\odeequ{" in 
	      let _ = pprint_derivate print_ODE k in
	      let _ = pprint_equal print_ODE in 
	      let _ = print_expr print_ODE true false  (Const 0) in () in  
	  true)
	init bool  in 
	  let _ = 
	    if bool then pprint_string print_latex "}"
	  in 
	  let _ = pprint_ODE_middle1 print_ODE_wo_latex in
	  let print_ODE = print_ODE_wo_latex in 
	  let _ = 
	    List.fold_left
	      (fun bool c -> 
		let _ = if bool then pprint_eq_separator print_ODE in
		let _ = pprint_newline print_ODE in 
		let _ = print_expr print_ODE false false   (simplify_expr c) in
		true)
	      false 
	      obs in
	  let _ = pprint_string print_latex "}" in 
	  let _ = pprint_ODE_middle2 print_ODE file_jac file_aux in 
    let _ = 
      List.fold_left
	(fun bool c -> 
	  let _ = if bool then pprint_eq_separator print_ODE in 
	  let _ = pprint_newline print_ODE  in 
	  let _ = print_expr print_ODE true false  (simplify_expr c) in
	  true)
	false 
	obs in  
    let _ = pprint_ODE_foot print_ODE in 
    let _ = 
     match step 
     with None -> ()
     | Some a -> 
	 let _ = pprint_string print_ODE "A:={" in 
	 let rec aux (k:float) = 
	   if k>final then ()
           else 
	     let _ = if k>init_t then pprint_string print_ODE "," in 
	     let t = Float_pretty_printing.string_of_float k in 
	     let _ = pprint_string print_ODE "{" in
	     let _ = pprint_string print_ODE t in 
	     let _ = 
	       List.iter 
		 (fun c -> 
		   let _ = pprint_string print_ODE "," in 
		   let _ = print_expr print_ODE false false   (simplify_expr c) in
		   let _ = pprint_string print_ODE "[" in 
		   let _ = pprint_string print_ODE t in 
		   let _ = pprint_string print_ODE "]" in 
		   ())
		 obs in
	     let _ = pprint_string print_ODE "}" in
	     aux (k+.a) in 
	 let _ = aux (min final init_t) in 
	 let _ = pprint_string print_ODE "}/.s;\n" in 
	 let _ = pprint_string print_ODE "Export[\"" in 
	 let _ = pprint_string print_ODE output_data in 
	 let _ = pprint_string print_ODE "\",A,\"Table\"]\n" in 
	 ( )
    in 
    let print_ODE = print_ODE_matlab in 
    let _ = pprint_ODE_middle0 print_ODE  in 
    let _  = 
      Arraymap.iter 
	(fun k b  -> 
	   let _ = if k=0 then (print_string "BUG";Printf.fprintf stdout "BUG\n") in 
	   let expr = simplify_expr b in 
	   if equal_zero expr then () 
	   else 
	     let _ = pprint_string print_ODE "init(" in 
	     let _ = pprint_string print_ODE (string_of_int k) in 
	     let _ = pprint_string print_ODE ")= " in 
	     let _ = print_expr print_ODE true true  expr in 
	     let _ = pprint_string print_ODE ";"  in 
	     let _ = pprint_newline print_ODE in 
	  ())
	init   in
    let _ = pprint_ODE_middle1 print_ODE in
    let _ = pprint_ODE_middle2 print_ODE file_aux file_jac in 
  
    let print_ODE = print_ODE_matlab_aux in 
    let _ = pprint_ODE_head' print_ODE in 
    let _   = 
      Arraymap.fold
	(fun k b bool ->
	  let _ = if bool then pprint_eq_separator print_ODE in 
	  let _ = pprint_newline print_ODE in 
	  let _ = pprint_equal print_ODE in 
	  let _ = List.fold_left 
	      (fun bool (a,b) ->
		let _ = 
		  if bool then pprint_string print_ODE "+"
		  else 
		    () in
		print_expr print_ODE false false  (simplify_expr (Mult(Const a,b)));
			  true) 
	      false b in 
	  true)
	prod  false in

    let _ = pprint_string print_ODE "];\n" in 
    let _ = pprint_ODE_foot print_ODE in 
    let print_ODE = print_ODE_matlab_jac in 
    let _ = pprint_string print_ODE "\n\n" in 
    let _   = 
      Int2Map.iter 
	(fun (i,j) b  ->
	   let _ = pprint_string print_ODE "Jac(" in 
	   let _ = pprint_string print_ODE (string_of_int i) in 
	   let _ = pprint_string print_ODE "," in 
	   let _ = pprint_string print_ODE (string_of_int j) in 
	   let _ = pprint_string print_ODE ") =  " in 
	   let _ = List.fold_left 
	     (fun bool (b) ->
		let _ = 
		  if bool then pprint_string print_ODE "+"
		  else 
		    () in
		  print_expr print_ODE false false  (simplify_expr b);		  true) 
	      false b in 
	   let _ = if not bool then print_expr print_ODE false false (Const 0)
	   in 
	   let _ = pprint_string print_ODE ";" in 
	   let _ = pprint_newline print_ODE in ())

	jac   in

    let _ = pprint_ODE_foot print_ODE in 
    let print_ODE = print_ODE_matlab_size in  
    let _ = pprint_string print_ODE (string_of_int size) in 
    let _ = pprint_string print_ODE ";" in 
    ()

 let pprint_obs print print_sb n expr pb = 
    let _ = 
      match print.dump with 
	None -> ()
      |	Some print -> 
	  print.print_string  ("Y("^(string_of_int n)^"):=");
    in 
     let _ = 
      match print.txt with 
	None -> ()
      |	Some print -> 
	  print.print_string  ("Y("^(string_of_int n)^"):=");
     in 
     let _ = 
       match print.kappa  with 
	 None -> ()
       |	Some print -> 
	   print.print_string "%obs:";
     in 
     let _ = 
       match print.data with 
	 None -> ()
       | Some print -> 
	   print.print_string "[";
     in 
     let _ = print_sb expr in 
     let _ = 
       match print.dump with 
	 None -> ()
       |	Some print -> print.print_newline ()
     in 
     let _ = 
       match print.txt with 
	 None -> ()
       |	Some print -> 
	   print.print_newline () 
     in 
     let _ = 
       match print.kappa  with 
	 None -> ()
       |	Some print -> 
	   print.print_newline () 
     in 
     let _ = 
       match print.data with 
	 None -> ()
       | Some print -> 
	   begin 
	     print.print_string "]";
	     print.print_string " " 
	   end
     in 
     ( ) 


let print_diff print_ODE i j flag expr = 
  match print_ODE.matlab_jacobian with None -> () 
    | Some print -> 
	let var = "d"^(string_of_int i)^"_d"^(string_of_int j)^"r"^flag in 
	let _ = print.print_string var in 
	let _ = print.print_string "=" in 
	let print_ODE = {print_ODE with matlab = None ; mathematica = None ; latex = None ; matlab_aux = None} in 
	let _ = print_expr print_ODE true true  expr in 
	let _ = print.print_string ";\n" in 
	  () 

