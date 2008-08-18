(* # generated by ./configure -host x86_64-apple-darwin *)
let prefix = "/usr/local";;
let bindir = prefix^"/bin";;
let libdir = prefix^"/lib/ocaml";;
let stublibdir = libdir^"/stublibs";;
let mandir = prefix^"/man";;
let manext = "1";;
let ranlib = "ranlib";;
let ranlibcmd = "ranlib";;
let sharpbangscripts = true;;
let bng_arch = "amd64";;
let bng_asm_level = "1";;
let pthread_link = "-cclib -lpthread";;
let x11_includes = "-I/usr/X11R6/include";;
let x11_link = "-L/usr/X11R6/lib -lX11";;
let dbm_includes = "";;
let dbm_link = "";;
let tk_defs = "";;
let tk_link = "";;
let bytecc = "gcc -arch x86_64";;
let bytecccompopts = " -fno-defer-pop -no-cpp-precomp -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT";;
let bytecclinkopts = "";;
let bytecclibs = " -lm  -lcurses -lpthread";;
let byteccrpath = "";;
let exe = "";;
let supports_shared_libraries = true;;
let sharedcccompopts = "";;
let mksharedlibrpath = "";;
(* SYSLIB=-l"^1^" *)
let syslib x = "-l"^x;;

(* MKEXE="^bytecc^" -o "^1^" "^2^" *)
let mkexe out files opts = Printf.sprintf "%s -o %s %s %s" bytecc out opts files;;

(* ### How to build a DLL *)
(* MKDLL=gcc -arch x86_64 -bundle -flat_namespace -undefined suppress -o "^1^" "^3^" *)
let mkdll out _implib files opts = Printf.sprintf "%s %s %s %s" "gcc -arch x86_64 -bundle -flat_namespace -undefined suppress -o" out opts files;;

(* ### How to build a static library *)
(* MKLIB=ar rc "^1^" "^2^"; ranlib "^1^" *)
let mklib out files opts = Printf.sprintf "ar rc %s %s %s; ranlib %s" out opts files out;;
let arch = "amd64";;
let model = "default";;
let system = "macosx";;
let nativecc = "gcc -arch x86_64";;
let nativecccompopts = " -D_FILE_OFFSET_BITS=64 -D_REENTRANT";;
let nativeccprofopts = " -D_FILE_OFFSET_BITS=64 -D_REENTRANT";;
let nativecclinkopts = "";;
let nativeccrpath = "";;
let nativecclibs = " -lm ";;
let asflags = "";;
let aspp = "gcc";;
let asppflags = "-c -arch x86_64 -DSYS_"^system;;
let asppprofflags = "-DPROFILING";;
let profiling = "prof";;
let dynlinkopts = "";;
let otherlibraries = "unix str num dynlink bigarray systhreads threads graph dbm";;
let debugger = "ocamldebugger";;
let cc_profile = "-pg";;
let systhread_support = true;;
let partialld = "ld -r -arch x86_64";;
let dllcccompopts = "";;
let o = "o";;
let a = "a";;
let ext_obj = ".o";;
let ext_asm = ".s";;
let ext_lib = ".a";;
let ext_dll = ".so";;
let extralibs = "";;
let ccomptype = "cc";;
let toolchain = "cc";;
