let builtin_exceptions = [|
  "Out_of_memory";
  "Sys_error";
  "Failure";
  "Invalid_argument";
  "End_of_file";
  "Division_by_zero";
  "Not_found";
  "Match_failure";
  "Stack_overflow";
  "Sys_blocked_io";
  "Assert_failure";
  "Undefined_recursive_module"
|]
let builtin_primitives = [|
  "caml_alloc_dummy";
  "caml_alloc_dummy_float";
  "caml_update_dummy";
  "caml_array_get_addr";
  "caml_array_get_float";
  "caml_array_get";
  "caml_array_set_addr";
  "caml_array_set_float";
  "caml_array_set";
  "caml_array_unsafe_get_float";
  "caml_array_unsafe_get";
  "caml_array_unsafe_set_addr";
  "caml_array_unsafe_set_float";
  "caml_array_unsafe_set";
  "caml_make_vect";
  "caml_make_array";
  "caml_compare";
  "caml_equal";
  "caml_notequal";
  "caml_lessthan";
  "caml_lessequal";
  "caml_greaterthan";
  "caml_greaterequal";
  "caml_output_value";
  "caml_output_value_to_string";
  "caml_output_value_to_buffer";
  "caml_format_float";
  "caml_float_of_string";
  "caml_int_of_float";
  "caml_float_of_int";
  "caml_neg_float";
  "caml_abs_float";
  "caml_add_float";
  "caml_sub_float";
  "caml_mul_float";
  "caml_div_float";
  "caml_exp_float";
  "caml_floor_float";
  "caml_fmod_float";
  "caml_frexp_float";
  "caml_ldexp_float";
  "caml_log_float";
  "caml_log10_float";
  "caml_modf_float";
  "caml_sqrt_float";
  "caml_power_float";
  "caml_sin_float";
  "caml_sinh_float";
  "caml_cos_float";
  "caml_cosh_float";
  "caml_tan_float";
  "caml_tanh_float";
  "caml_asin_float";
  "caml_acos_float";
  "caml_atan_float";
  "caml_atan2_float";
  "caml_ceil_float";
  "caml_eq_float";
  "caml_neq_float";
  "caml_le_float";
  "caml_lt_float";
  "caml_ge_float";
  "caml_gt_float";
  "caml_float_compare";
  "caml_classify_float";
  "caml_gc_stat";
  "caml_gc_quick_stat";
  "caml_gc_counters";
  "caml_gc_get";
  "caml_gc_set";
  "caml_gc_minor";
  "caml_gc_major";
  "caml_gc_full_major";
  "caml_gc_major_slice";
  "caml_gc_compaction";
  "caml_hash_univ_param";
  "caml_input_value";
  "caml_input_value_from_string";
  "caml_marshal_data_size";
  "caml_int_compare";
  "caml_int_of_string";
  "caml_format_int";
  "caml_int32_neg";
  "caml_int32_add";
  "caml_int32_sub";
  "caml_int32_mul";
  "caml_int32_div";
  "caml_int32_mod";
  "caml_int32_and";
  "caml_int32_or";
  "caml_int32_xor";
  "caml_int32_shift_left";
  "caml_int32_shift_right";
  "caml_int32_shift_right_unsigned";
  "caml_int32_of_int";
  "caml_int32_to_int";
  "caml_int32_of_float";
  "caml_int32_to_float";
  "caml_int32_compare";
  "caml_int32_format";
  "caml_int32_of_string";
  "caml_int32_bits_of_float";
  "caml_int32_float_of_bits";
  "caml_int64_neg";
  "caml_int64_add";
  "caml_int64_sub";
  "caml_int64_mul";
  "caml_int64_div";
  "caml_int64_mod";
  "caml_int64_and";
  "caml_int64_or";
  "caml_int64_xor";
  "caml_int64_shift_left";
  "caml_int64_shift_right";
  "caml_int64_shift_right_unsigned";
  "caml_int64_of_int";
  "caml_int64_to_int";
  "caml_int64_of_float";
  "caml_int64_to_float";
  "caml_int64_of_int32";
  "caml_int64_to_int32";
  "caml_int64_of_nativeint";
  "caml_int64_to_nativeint";
  "caml_int64_compare";
  "caml_int64_format";
  "caml_int64_of_string";
  "caml_int64_bits_of_float";
  "caml_int64_float_of_bits";
  "caml_nativeint_neg";
  "caml_nativeint_add";
  "caml_nativeint_sub";
  "caml_nativeint_mul";
  "caml_nativeint_div";
  "caml_nativeint_mod";
  "caml_nativeint_and";
  "caml_nativeint_or";
  "caml_nativeint_xor";
  "caml_nativeint_shift_left";
  "caml_nativeint_shift_right";
  "caml_nativeint_shift_right_unsigned";
  "caml_nativeint_of_int";
  "caml_nativeint_to_int";
  "caml_nativeint_of_float";
  "caml_nativeint_to_float";
  "caml_nativeint_of_int32";
  "caml_nativeint_to_int32";
  "caml_nativeint_compare";
  "caml_nativeint_format";
  "caml_nativeint_of_string";
  "caml_ml_open_descriptor_in";
  "caml_ml_open_descriptor_out";
  "caml_ml_out_channels_list";
  "caml_channel_descriptor";
  "caml_ml_close_channel";
  "caml_ml_channel_size";
  "caml_ml_channel_size_64";
  "caml_ml_set_binary_mode";
  "caml_ml_flush_partial";
  "caml_ml_flush";
  "caml_ml_output_char";
  "caml_ml_output_int";
  "caml_ml_output_partial";
  "caml_ml_output";
  "caml_ml_seek_out";
  "caml_ml_seek_out_64";
  "caml_ml_pos_out";
  "caml_ml_pos_out_64";
  "caml_ml_input_char";
  "caml_ml_input_int";
  "caml_ml_input";
  "caml_ml_seek_in";
  "caml_ml_seek_in_64";
  "caml_ml_pos_in";
  "caml_ml_pos_in_64";
  "caml_ml_input_scan_line";
  "caml_lex_engine";
  "caml_new_lex_engine";
  "caml_md5_string";
  "caml_md5_chan";
  "caml_get_global_data";
  "caml_get_section_table";
  "caml_reify_bytecode";
  "caml_realloc_global";
  "caml_get_current_environment";
  "caml_invoke_traced_function";
  "caml_static_alloc";
  "caml_static_free";
  "caml_static_release_bytecode";
  "caml_static_resize";
  "caml_obj_is_block";
  "caml_obj_tag";
  "caml_obj_set_tag";
  "caml_obj_block";
  "caml_obj_dup";
  "caml_obj_truncate";
  "caml_lazy_follow_forward";
  "caml_lazy_make_forward";
  "caml_get_public_method";
  "caml_parse_engine";
  "caml_install_signal_handler";
  "caml_ml_string_length";
  "caml_create_string";
  "caml_string_get";
  "caml_string_set";
  "caml_string_equal";
  "caml_string_notequal";
  "caml_string_compare";
  "caml_string_lessthan";
  "caml_string_lessequal";
  "caml_string_greaterthan";
  "caml_string_greaterequal";
  "caml_blit_string";
  "caml_fill_string";
  "caml_is_printable";
  "caml_bitvect_test";
  "caml_sys_exit";
  "caml_sys_open";
  "caml_sys_close";
  "caml_sys_file_exists";
  "caml_sys_is_directory";
  "caml_sys_remove";
  "caml_sys_rename";
  "caml_sys_chdir";
  "caml_sys_getcwd";
  "caml_sys_getenv";
  "caml_sys_get_argv";
  "caml_sys_system_command";
  "caml_sys_time";
  "caml_sys_random_seed";
  "caml_sys_get_config";
  "caml_sys_read_directory";
  "caml_terminfo_setup";
  "caml_terminfo_backup";
  "caml_terminfo_standout";
  "caml_terminfo_resume";
  "caml_register_named_value";
  "caml_weak_create";
  "caml_weak_set";
  "caml_weak_get";
  "caml_weak_get_copy";
  "caml_weak_check";
  "caml_weak_blit";
  "caml_final_register";
  "caml_final_release";
  "caml_ensure_stack_capacity";
  "caml_dynlink_open_lib";
  "caml_dynlink_close_lib";
  "caml_dynlink_lookup_symbol";
  "caml_dynlink_add_primitive";
  "caml_dynlink_get_current_libs"
|]
