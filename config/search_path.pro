﻿!
!   Default iCub CAD configuration file
!
!   created by: Luca Fiorio
!
!   Version History
!   XX    YYYY/MM/DD   Author    Description
!   01    2019/09/23   savoldi   start migration to github
!   02    2019/10/20   fiorio    add "temporary paths" section
!   03    2019/11/25   savoldi   migration to mechatronics of all ELTR folder
!   04    2020/09/28   savoldi   added eletronics-PCA
!   05    2020/10/23   savoldi   modification paths for migration new repository
!   06    2021/04/27   savoldi   added heatsink
!   07    2022/01/27   savoldi   added deprecated drawing format
!   08    2022/02/09   protopapa added tool folder
!   09    2022/04/28   Savoldi   added electronic board to cad-mechanics + added titles
!   010    2022/07/13   Salvi    added ergocub
!   011    2022/04/28   Savoldi  Removed the folders of the electronic boards in mechatronics
!   012	   2022/11/24  protopapa added lower arm path (but wondering if it is worth to manually fill this list anymore)
!   013    2023/08/01   Savoldi  Added "ic_020_elect_board_group" and "FT_Sensor_fake" for ergocub 2 arm setup
!   014    2024/08/07   Savoldi  Added folders for battery pack in cad-mechanics
!
!
! ----------------------Libraries parts-----------------------------------------
!
search_path ".\libraries\commercials"
search_path ".\libraries\custom"
!search_path ".\libraries\electronics\"
search_path ".\libraries\electronics\board_components"
search_path ".\libraries\electronics\commercial_boards"
search_path ".\libraries\motors_and_gearboxes"
search_path ".\libraries\electronics\plug_components"
search_path ".\libraries\electronics\panel_components"
search_path ".\libraries\fasteners"
!
!
! ----------------------drawing format-----------------------------------------
!
search_path ".\config\proe_drawing_formats\deprecate_df"
!
!
! ----------------------all mechanical projects-----------------------------------------
!
search_path ".\..\cad-mechanics\projects"
search_path ".\..\cad-mechanics\projects\cer"
search_path ".\..\cad-mechanics\projects\cer\cer_005_hand"
search_path ".\..\cad-mechanics\projects\cer\cer_008_shoulders"
search_path ".\..\cad-mechanics\projects\cer\cer_009_wrist"
search_path ".\..\cad-mechanics\projects\cer\cer_010_torso_tripod"
search_path ".\..\cad-mechanics\projects\cer\cer_011_mobile_base"
search_path ".\..\cad-mechanics\projects\cer\cer_015_chest"
search_path ".\..\cad-mechanics\projects\cer\cer_016_upperarm"
search_path ".\..\cad-mechanics\projects\cer\cer_018_head"
search_path ".\..\cad-mechanics\projects\cer\cer_019_mobile_base_mk2"
search_path ".\..\cad-mechanics\projects\cer\cer_020_torso_tripod_mk2"
search_path ".\..\cad-mechanics\projects\cer\cer_021_covers"
search_path ".\..\cad-mechanics\projects\cer\cer_023_shoulders_mk2"
search_path ".\..\cad-mechanics\projects\cer\cer_025_upperarm_mk2"
search_path ".\..\cad-mechanics\projects\cer\cer_027_hands_mk2"
search_path ".\..\cad-mechanics\projects\cer\cer_028_chest_mk2"
search_path ".\..\cad-mechanics\projects\cer\cer_029_covers_mk2"
search_path ".\..\cad-mechanics\projects\cer\cer_030_head_mk3"
search_path ".\..\cad-mechanics\projects\cer\cer_031_head_mk4_obsolete"
search_path ".\..\cad-mechanics\projects\cer\cer_ergomorphing"
search_path ".\..\cad-mechanics\projects\icub"
search_path ".\..\cad-mechanics\projects\icub\common"
search_path ".\..\cad-mechanics\projects\icub\common\ic_002_standard_head"
search_path ".\..\cad-mechanics\projects\icub\common\ic_006_talking_eth_kit"
search_path ".\..\cad-mechanics\projects\icub\common\ic_009_talking_eth"
search_path ".\..\cad-mechanics\projects\icub\common\ic_010_shipping_rack"
search_path ".\..\cad-mechanics\projects\icub\common\ic_011_Neuro_STD"
search_path ".\..\cad-mechanics\projects\icub\common\ic_013_STD_iCub3_head"
search_path ".\..\cad-mechanics\projects\icub\common\ic_016_blink_head"
search_path ".\..\cad-mechanics\projects\icub\common\ic_020_elect_board_group"
search_path ".\..\cad-mechanics\projects\icub\common\FT_Sensor_fake"
search_path ".\..\cad-mechanics\projects\icub\common\ic_032_4khead"
!
search_path ".\..\cad-mechanics\projects\icub\icub1_icub2"
!
search_path ".\..\cad-mechanics\projects\icub\icub3"
!
search_path ".\..\cad-mechanics\projects\ergocub"
!
search_path ".\..\cad-mechanics\projects\icub\koroibot"
!
search_path ".\..\cad-mechanics\projects\simulation_model"
search_path ".\..\cad-mechanics\projects\simulation_model\head"
search_path ".\..\cad-mechanics\projects\simulation_model\icub3"
search_path ".\..\cad-mechanics\projects\simulation_model\ergocub_1-0"
search_path ".\..\cad-mechanics\projects\simulation_model\ergocub_1-x"
search_path ".\..\cad-mechanics\projects\simulation_model\cer"
!
search_path ".\..\cad-mechanics\projects\tools"
!
! ----------------------Custom electronic boards-----------------------------------------
!
!
search_path ".\..\cad-mechanics\projects\electronics\elect_old-school"
search_path ".\..\cad-mechanics\projects\electronics\electronic_boards"
!
search_path ".\..\libraries\electronics\custom_boards"
search_path ".\..\libraries\electronics\custom_boards\eletronics-boards"
search_path ".\..\libraries\electronics\custom_boards\eletronics-PCA"
!
search_path ".\..\cad-mechanics\projects\electronics\batteries"
!
! The following path will go to die
search_path ".\..\mechatronics\project\obsolete_boards"
!
! ---------------------- Common parts-----------------------------------------
!
search_path ".\..\cad-mechanics\projects\common"
search_path ".\..\cad-mechanics\projects\common\ic_001_ft45"
search_path ".\..\cad-mechanics\projects\common\ic_005_ft58"
search_path ".\..\cad-mechanics\projects\common\ic_007_ft45_M3"
search_path ".\..\cad-mechanics\projects\common\ic_008_ft45_M4"
search_path ".\..\cad-mechanics\projects\common\ic_014_ergoCub_head"
search_path ".\..\cad-mechanics\projects\common\ic_016_custom_fasteners"
search_path ".\..\cad-mechanics\projects\common\ic_021_lower_arm"
search_path ".\..\cad-mechanics\projects\common\ic_027_heatsinks"
search_path ".\..\cad-mechanics\projects\common\ic_032_4khead"
search_path ".\..\cad-mechanics\projects\common\ic_033_headedge"
!
!
! ------------------ all gadgets for the robots --------------------------------
!
search_path ".\..\cad-mechanics\projects\gadgets"
search_path ".\..\cad-mechanics\projects\gadgets\rc_090_stand"
search_path ".\..\cad-mechanics\projects\gadgets\rc_090_stand\stand-rounded"
search_path ".\..\cad-mechanics\projects\gadgets\rc_090_stand\stand_icub1_2"
search_path ".\..\cad-mechanics\projects\gadgets\rc_090_stand\stand_for_upperbody"
search_path ".\..\cad-mechanics\projects\gadgets\rc_090_stand\stand_icub3"
search_path ".\..\cad-mechanics\projects\gadgets\ic_002_FTSensor58_mounting_tool"
search_path ".\..\cad-mechanics\projects\gadgets\ig_001_FTSensor45_mounting_tool"
search_path ".\..\cad-mechanics\projects\gadgets\ig_012_stand_safety_protection"
search_path ".\..\cad-mechanics\projects\gadgets\ig_017_r1_arm_test_setup"
!


