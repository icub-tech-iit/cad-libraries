! Demonstration Configuration file for ModelCHECK version 2000i2
! This file is to be used with the ModelCHECK wheel Pro/ENGINEER demo parts.
! Updated 02/02/00
!
! E     Check the item.  If not succeed, report as an error
! W     Check the item.  If not succeed, report as a warning
! N     Do not check the item.
! Y     Check the item.  If not succeed, do not report err or warn
!
! "I" = Interactive
! "B" = Batch
! "R" = Regeneration
! "S" = Save

! ----------------------------------------------------------------
#            Options           "I"     "B"     "R"     "S"     "M"
! ----------------------------------------------------------------

! ----------------------------------------------------------------
# Options                   (Y/N/E/W)        (N/E/W)
#                                   (Y/N/E/W)        (N/E/W)
! ----------------------------------------------------------------

# PART REPORT CONFIGURATION 
STARTCHECK           YNEW       E       E       N       W       Y 
PARAMCHECK           YNEW       E       E       N       W       Y
PARAM_SPELL          YNEW       N       N       N       N       N
PARAM_RENAME         YNEW       W       W       N       Y       Y
MODEL_NAME           YNEW       E       E       N       W       Y
REG_FEATURES         YN         Y       Y       N       N       Y
IMPORT_FEAT          YN         Y       Y       N       N       Y
NAMED_FEAT           YN         Y       Y       N       N       Y
SUP_FEATURES         YNEW       Y       W       N       W       Y
REGEN_ERRS           YNEW       E       N       N       N       Y
IGNORE_FEAT          YN         Y       Y       N       Y       Y
ROUND_CHILD          YNEW       E       E       E       E       Y
EARLY_ROUND          EENN       E       E       N       N       Y
CHAMFER_CHILD        YNEW       E       E       E       E       Y
DRAFT_CHILD          YNEW       W       W       W       W       Y
EARLY_DRAFT          YNEW       N       N       N       N       Y
SMALL_CLYSRF         YNEW       E       E       N       W       Y
GEOM_CHECKS          YNEW       E       E       N       E       Y
BURIED_FEAT          YNEW       E       E       E       E       Y
MERGE_FEAT           YNEW       Y       Y       N       Y       Y
COSMETIC_FEAT        YNEW       Y       Y       N       N       Y
SHORT_EDGES          YNEW       N       N       N       N       Y
SHARP_EDGES          YNEW       N       N       N       N       Y
SRF_EDGES            YNEW       N       N       N       N       Y
HOLE_DIAMS           YNEW       N       N       N       N       Y
DRAFT_ANGLES         YNEW       N       N       N       N       Y
CYL_CUT_SLOTS        YNEW       N       W       N       W       Y
PLANE_CHILD          YNEW       Y       Y       N       N       Y
PLANE_PARENT         YNEW       Y       Y       N       N       Y
SHTMTL_UNBENDS       YNEW       E       E       N       E       Y
SHTMTL_FLAT          YNEW       E       E       N       N       Y
SHTMTL_BENDTAB       YNEW       E       E       N       E       Y
SHTMTL_THICK         YNEW       E       N       N       E       N
SHTMTL_YFACTOR       YN         Y       Y       N       N       Y
EXT_REF_INFO         YNEW       Y       W       W       W       Y
RELATION_ERRS        YNEW       W       E       E       E       Y
RELATION_COMM        YNEW       N       N       N       N       N
RELATION_MULT        YNEW       W       W       W       W       Y
RELATION_MISS        YNEW       N       N       N       N       N
LAYER_ITEMS          YNEW       Y       Y       N       W       Y
LAYER_STATUS         YNEW       Y       W       N       W       Y
LAYER_PLACE          YNEW       W       W       N       W       Y
LAYER_MOVE           YNEW       W       Y       N       N       Y
LAYER_DISPSTAT       YNEW       W       W       N       W       Y
GEOMETRIC_TOL        YN         Y       Y       N       N       Y
FT_DEF_VALS          YNEW       E       E       N       N       Y
FT_STD_PARMS         YNEW       N       N       N       N       N
FILE_SIZE            YN         Y       Y       N       N       Y
MEMORY_SPACE         YN         Y       Y       N       N       Y
INSTANCE_NAME        YNEW       N       N       N       N       N
FAMILY_INFO          YN         Y       Y       N       N       Y
DEF_DENSITY          YNEW       N       N       N       N       N
ACCURACY_INFO        YNEW       W       W       N       W       Y
OVERALL_SIZE         YN         Y       Y       N       N       Y
SLA_INFO             YNEW       N       N       N       N       N
MATERIAL_INFO        YNEW       N       N       N       N       N
UNITS_LENGTH         YNEW       Y       Y       N       N       Y
UNITS_MASS           YNEW       Y       Y       N       N       Y
DEFAULT_CHILD        YN         Y       Y       N       N       Y
FREEFORM             YN         Y       Y       N       N       Y
RELATION_INFO        YN         Y       Y       N       N       Y
UDF_INFO             YN         Y       Y       N       N       Y
DATUM_RENAME         YNEW       W       W       N       N       Y
DTM_PLANE_INFO       YN         Y       Y       N       N       Y
DTM_CSYS_INFO        YN         Y       Y       N       N       Y
DTM_POINT_INFO       YN         Y       Y       N       N       Y
DTM_CURVE_INFO       YN         Y       Y       N       N       Y
DTM_AXES_INFO        YN         Y       Y       N       N       Y
VIEW_INFO            YN         Y       Y       N       N       Y
LAYER_INFO           YN         Y       Y       N       N       Y 
PARAM_INFO           YN         Y       Y       N       N       Y
XSEC_INFO            YN         Y       Y       N       N       Y
LAYOUT_INFO          YN         Y       Y       N       N       Y
MINMAXTOL_INFO       YN         Y       Y       N       N       Y
LOW_TOLERANCE        YNEW       Y       Y       N       N       Y
RULECHECK_INFO       YN         N       N       N       N       Y
RC_INCOMPLETED       YNEW       N       N       N       N       Y
PARAM_NOTE_UNACC     YNEW       E       W       N       N       Y
PARAM_NOTE_REQ       YNEW       E       W       N       N       Y
EARLY_CHAMFER        YNEW       W       W       N       W       Y
EXTRA_LAYERS         YNEW       N       N       N       N       Y
EXTRA_PARAMS         YNEW       N       N       N       N       Y
INSERT_MODE          YNEW       E       W       N       W       Y
INCOMPLETE_FEAT      YNEW       E       W       N       W       Y
ADD_CHK_PARAM        YN         Y       Y       N       N       Y
MODEL_NAME_STR       YN         Y       Y       N       N       Y
REGEN_WRNS           YNEW       W       N       N       N       Y
FEATURE_INFO         YN         Y       Y       N       N       N
LAYER_ITEM_STD       YNEW       N       N       N       N       Y
DUPLICATE_MODELS     YNEW       W       W       W       W       Y
PRO_VERSION          YNEW       E       E       W       W       Y
CYL_DIAMS            YNEW       Y       Y       N       N       N
EARLY_COSMETIC       YNEW       N       N       N       N       N
EDGE_REFERENCES      YNEW       E       E       E       E       Y
SIMPREP_NAME         YNEW       N       N       N       N       N
SIMPREP_INFO         YN         Y       Y       N       N       N

# DRAWING REPORT CONFIGURATION
DRAWING_NAME         YNEW       W       W       N       W       Y
UNUSED_MODELS        YNEW       E       E       N       E       Y
FORMAT_NAME          YNEW       N       N       N       N       N
ERASED_VIEWS         YNEW       W       W       N       W       Y
BOUND_INFO           YNEW       E       E       N       E       Y
OVERLAP_INFO         YNEW       W       E       N       E       Y
REGEN_DIMS           YNEW       E       E       N       E       Y
PARAMS_EXIST         YNEW       N       N       N       N       Y
PARAMS_USED          YNEW       N       N       N       N       N
DRAFT_GEOM           YNEW       E       E       N       E       Y
TITLE_INFO           YNEW       N       N       N       N       N
NOTE_INFO            YN         Y       Y       N       N       Y
NOTE_SPELL           YNEW       E       E       N       E       Y
DIM_OVERWRITE        YNEW       E       E       N       E       Y
SHEET_SIZE_INFO      YN         Y       Y       N       N       Y
SYMBOL_INFO          YN         Y       Y       N       N       Y
#STD_SYMBOLS         YNEW       E       E       N       E       Y
STD_DTL_SETUP        YNEW       N       N       N       N       N
DRAWING_LAYERS       YNEW       W       E       N       W       Y
NOTE_FONT            YNEW       N       N       N       N       N
NOTE_HEIGHT          YNEW       N       N       N       N       N
MODELS_USED          YN         Y       Y       Y       N       Y
TABLE_CELLS          YNEW       N       N       N       N       N
NOTE_UNACCEPT        YNEW       E       E       Y       N       Y
DRAWING_GTOLS        YNEW       E       Y       N       N       Y
NUM_DRAW_SHEETS      YNEW       N       N       N       N       N
UNUSED_SHEETS        YNEW       E       E       N       N       N
IGNORE_SHEETS        YN         N       N       N       N       N

# ASSEMBLY REPORT CONFIGURATION
NUM_COMPONENTS       YN         Y       Y       Y       Y       Y
UNQ_COMPONENTS       YN         Y       Y       Y       Y       Y
SUP_COMPONENTS       YNEW       E       E       W       W       Y
GEN_COMPONENTS       YNEW       E       E       N       W       Y
FRZ_COMPONENTS       YNEW       E       E       N       W       Y
MIS_COMPONENTS       YNEW       E       E       N       W       Y
ASM_FEATURES         YN         Y       Y       N       N       Y
GLOBAL_INTF          YNEW       N       N       N       N       N
ASM_BOM              YN         Y       Y       N       N       Y
BULK_ITEMS           YNEW       Y       Y       N       N       N
PACK_COMPONENTS      YNEW       E       E       W       W       Y
