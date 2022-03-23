2d_palette_path .\config\custom_sketches
bom_format .\config\bom_icub.fmt
default_ext_ref_scope skeleton_model
default_scene_filename .\config\render_scene\IIT_default_scene.scn
dialog_translation no
display shadewithedges
display_annotations no
display_axes NO
display_axis_tags no
display_coord_sys NO
display_coord_sys_tags no
display_plane_tags YES
display_planes no
display_point_tags no
display_points no
drawing_setup_file .\config\std_fmt.dtl
dwg_unicode_conversion_language english
ecad_comp_naming_convention ecad_alt_name
ecad_export_cuts_as_holes no
ecad_export_holes_as_cuts yes
export_profiles_step .\config\def_profile.dep_step
format_setup_file .\config\std_fmt.dtl
freeze_failed_assy_comp yes
frt_enabled yes
help_translation no
hole_file_resolution replace_with_external
hole_parameter_file_path .\config
info_output_mode choose
intf2d_out_enhanced_ents none
intf3d_out_configure_export yes
make_parameters_from_fmt_tables yes
mapkey $F12 %save_minimal_model_tree;%run_drawing_script;~;\
mapkey(continued) %load_drawing_mapkey;%clean-up;%open_drawing_mapkey;
mapkey clean-up @SYSTEMpowershell -command "& {& 'Remove-Item' \
mapkey(continued) ".\\public\\config\\macros_mapkeys\\open_drawing\\model_tree.txt"}"\;\
mapkey(continued) "& {& 'Remove-Item' \
mapkey(continued) ".\\public\\config\\macros_mapkeys\\open_drawing\\open_drawing_mapkey.pro"}";
mapkey d @MAPKEY_NAMEmapkey for edit definition;@MAPKEY_LABELedit definition;\
mapkey(continued) ~ Command `ProCmdRedefine`;
mapkey e @MAPKEY_NAMEmapkey to edit the definition of features;\
mapkey(continued) @MAPKEY_LABELedit definition;\
mapkey(continued) ~ Command `ProCmdL05Edit@PopupMenuGraphicWinStack`;
mapkey f @MAPKEY_LABELFRONT VIEW;\
mapkey(continued) ~ Command `ProCmdNamedViewsGalSelect`  `FRONT`;
mapkey load_drawing_mapkey ~ Select `main_dlg_cur` `appl_casc`;\
mapkey(continued) ~ Close `main_dlg_cur` `appl_casc`;~ Command `ProCmdRibbonOptionsDlg` ;\
mapkey(continued) ~ Select `ribbon_options_dialog` `PageSwitcherPageList` 1 `ConfigLayout`;\
mapkey(continued) ~ Select `ribbon_options_dialog` `ConfigLayout.ImportExportBtn`;\
mapkey(continued) ~ Close `ribbon_options_dialog` `ConfigLayout.ImportExportBtn`;\
mapkey(continued) ~ Activate `ribbon_options_dialog` `ConfigLayout.Open`;\
mapkey(continued) ~ Activate `file_open` `Current Dir`;\
mapkey(continued) ~ Update `file_open` `Inputname` \
mapkey(continued) `public\\config\\macros_mapkeys\\open_drawing\\open_drawing_mapkey.pro`;\
mapkey(continued) ~ Command `ProFileSelPushOpen_Standard@context_dlg_open_cmd` ;\
mapkey(continued) ~ Activate `ribbon_options_dialog` `OkPshBtn`;\
mapkey(continued) ~ FocusIn `UITools Msg Dialog Future` `no`;\
mapkey(continued) ~ Activate `UITools Msg Dialog Future` `no`;
mapkey m @MAPKEY_LABELmass_properties;\
mapkey(continued) ~ Activate `main_dlg_cur` `page_Analysis_control_btn` 1;\
mapkey(continued) ~ Command `ProCmdNaModelProperties`;
mapkey q @MAPKEY_NAMEmapkey to measure the distance between surfaces;\
mapkey(continued) @MAPKEY_LABELmeasure surface distance;~ Command `ProCmdNaMeasureDistance` ;\
mapkey(continued) ~ Select `main_dlg_cur` `Sst_bar.filter_list` 1 `10`;\
mapkey(continued) ~ Command `ProCmdSelFilterSet` 90;
mapkey r @MAPKEY_LABELRIGHT VIEW;\
mapkey(continued) ~ Command `ProCmdNamedViewsGalSelect`  `RIGHT`;
mapkey run_drawing_script @SYSTEMpowershell -File \
mapkey(continued) .\\public\\config\\macros_mapkeys\\open_drawing\\drawing.ps1;
mapkey s @MAPKEY_NAMEmapkey for editing sketches;@MAPKEY_LABELedit sketch;\
mapkey(continued) ~ Command `ProCmdRedefine` ;\
mapkey(continued) ~ Activate `main_dlg_cur` `chkbn.revolve_1_placement.0` 1;\
mapkey(continued) ~ Activate `revolve_1_placement.0.0` `PH.Sketch`;\
mapkey(continued) ~ Activate `main_dlg_cur` `chkbn.extrev_1_placement.0` 1;\
mapkey(continued) ~ Activate `extrev_1_placement.0.0` `PH.Sketch`;\
mapkey(continued) ~ Activate `main_dlg_cur` `chkbn.plrib_settings.0` 1;\
mapkey(continued) ~ Activate `plrib_settings.1.0` `PH.sketchrepresentator_btn`;\
mapkey(continued) ~ Activate `main_dlg_cur` `maindashInst0.Sketch`;
mapkey save_minimal_model_tree ~ Command `ProCmdMdlTreeRetrieve` ;\
mapkey(continued) ~ Trail `UI Desktop` `UI Desktop` `DLG_PREVIEW_POST` `file_open`;\
mapkey(continued) ~ Activate `file_open` `Current Dir`;\
mapkey(continued) ~ Update `file_open` `Inputname` \
mapkey(continued) `public\\config\\macros_mapkeys\\open_drawing\\minimal_tree.cfg`;\
mapkey(continued) ~ Activate `file_open` `Inputname`;~ Select `main_dlg_cur` `appl_casc`;\
mapkey(continued) ~ Command `ProCmdMdlTreeSaveAsText`;\
mapkey(continued) ~ Update `inputname` `InpName` \
mapkey(continued) `public\\config\\macros_mapkeys\\open_drawing\\model_tree.txt`;\
mapkey(continued) ~ Activate `inputname` `InpName`;~ Command `ProCmdMdlTreeRetrieve` ;\
mapkey(continued) ~ Trail `UI Desktop` `UI Desktop` `DLG_PREVIEW_POST` `file_open`;\
mapkey(continued) ~ Activate `file_open` `Current Dir`;\
mapkey(continued) ~ Update `file_open` `Inputname` `public\\config\\tree.cfg`;\
mapkey(continued) ~ Activate `file_open` `Inputname`;
mapkey t @MAPKEY_LABELTOP VIEW;~ Command `ProCmdNamedViewsGalSelect`  `TOP`;
mapkey w @MAPKEY_LABELselect parent;\
mapkey(continued) ~ Timer `UI Desktop` `UI Desktop` `popupMenuRMBTimerCB`;\
mapkey(continued) ~ Close `rmb_popup` `PopupMenu`;~ Activate `rmb_popup` `Selobj_parent`;
mapkey z @MAPKEY_NAMEopen parameters window;@MAPKEY_LABELparameters;\
mapkey(continued) ~ Command `ProCmdMmParams`;
mass_property_calculate automatic
mdl_tree_cfg_file .\config\tree.cfg
menu_show_instances no
menu_translation no
modelcheck_dir .\config\modelcheck
msg_translation no
multiple_skeletons_allowed yes
nmgr_outdated_mp do_not_show
parenthesize_ref_dim yes
pdf_linecap round
pdf_linejoin round
pdf_use_pentable yes
pen_table_file .\config\pen_table.pnt
pro_dtl_setup_dir .\config\
pro_format_dir .\config\proe_drawing_formats
pro_material_dir .\config\materials
pro_surface_finish_dir .\config\symbols\surf_finish
pro_symbol_dir .\config\symbols
pro_table_dir .\config\tables
pro_unit_length unit_mm
pro_unit_mass unit_kilogram
pro_unit_sys mmns
provide_pick_message_always yes
regen_solid_before_save yes
remember_replaced_components no
rename_drawings_with_object both
save_dialog_for_existing_models yes
save_instance_accelerator none
search_area_for_comp_interfaces 99
search_path_file $CREO_COMMON_FILES\ifx\parts\prolibrary\search.pro
search_path_file .\config\search_path.pro
search_path_file .\config\search_path_custom.pro
shade_with CURVES
show_preview_default keep
sim_run_out_dir .\output_dir
sim_run_tmp_dir .\output_dir
sketcher_starts_in_2d yes
spin_center_display no
start_model_dir .\config\standard_files
system_colors_file .\config\syscol.scl
template_boardpart .\config\standard_files\start_part_ecad.prt
template_designasm .\config\standard_files\start_asm.asm.1
template_drawing $PRO_DIRECTORY\templates\a3_drawing.drw
template_new_ecadasm .\config\standard_files\start_asm_ecad.asm
template_sheetmetalpart .\config\standard_files\sheetmetal_start_part.prt.1
template_solidpart .\config\standard_files\start_part.prt.1
todays_date_note_format %dd-%Mmm-%yy
tol_display yes
tolerance_standard iso
trail_dir .\config\trail
weld_ui_standard iso
