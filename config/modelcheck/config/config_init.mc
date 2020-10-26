! iCubTech PTC Creo ModelCHECK INITIALIZATION file.
! This file is to initialize MC. It is read only once.
!
!  Rev.| Author               | Description                             | Date        |
!  0   | Maggiolo (DEDAGROUP) | First Emission                          | 07 Jan 2020 |
!  1   | Fiorio (IIT)         | Refactored to use ModelCHECK for CAD CI | 01 Sep 2020 |
!
! "I" = Interactive
! "B" = Batch
! "R" = Regeneration
! "S" = Save

! ----------------------------------------------------------
#            Options           "I"     "B"     "R"     "S"
! ----------------------------------------------------------

# Auto add/upd parameter MC_CONFIG to model with current mc config used
ADD_CONFIG_PARM	YN	Y	Y	Y	Y

# Auto add/upd parameter MODEL_CHECK to model with current date as it's value
ADD_DATE_PARM	YN	Y	Y	Y	Y

# Auto add/upd parameter MC_ERRORS to model with number of errors found in model
ADD_ERR_PARM	YN	Y	Y	Y	Y

# Auto add/upd parameter MC_MODE to model with current mode MC was run
ADD_MODE_PARM	YN	Y	Y	Y	Y

# Enable/Disable ModelUPDATE parameter added to the model
ADD_MU_STAMP	YN	Y

# Duplicate models - Automatically add dup model info to text file
#   Y - always add model info
#   N - Never add model info
#   D - add model info but Don't overwrite existing info
#   A - always Ask the user whether to add AND whether to overwrite
ADD_DUP_INFO_AUTO	YNDA	N	N	N	Y

# Allow width of applet to be modified (min=350 max=650)
APPLET_WIDTH	450

# Asyncronous port for ModelCHECK server to use
ASYNC_PORT	3001

# ASSEMBLY batch mode - run TOP only (N) or ALL LEVELS (Y)
ASM_BATCH_ALL	YN	Y

# Config select Mode - Automatic (Y) or Load Config menu option (N)
#  or Ask User at start of Pro/E session (A)
CNFG_SELECT_AUTO	YNA	N

#Set the time format
DATE_PARAM_GMT_FORMAT	YN	Y	Y	Y	Y

# Enable/Disable ModelUPDATE parameter designated
DESIGNATE_MU_STAMP	YN	N

# Directory ModelCHECK will write reports
DIR_REPORT	./output_dir

# Directory ModelCHECK will write metrics flat file
DIR_METRICS ./output_dir

# Directory ModelCHECK will read shape indexing files
DIR_MC_DUP_READ	C:\Demos\Creo\ModelCheck\ModelCHECK_Data\config\mc_dup_read

# Directory ModelCHECK will write shape indexing files
DIR_MC_DUP_WRITE	C:\Demos\Creo\ModelCheck\ModelCHECK_Data\config\mc_dup_write

# Run MC on all drawing sheets (Y) or current only (N)
DRW_SHEET_ALL	YN	Y	Y	Y	Y

# Number of days to save html and xml files in DIR_REPORT
HTML_MAX_DAYS	1

# Highlight Color (Red,Yellow,White,Blue,Grey,Magenta,Cyan,Green,Brown)
HIGHLIGHT_COLOR	Red
PARENT_HI_COLOR	Blue

# Runs the GeomIntegrityCHECK utility along with Creo ModelCHECK in all the Creo ModelCHECK operating modes
MC_VDA_RUN	YN	Y	Y	N	N

# Enable ModelCHECK Y=enable, N=disable, A=Ask user
MC_ENABLE	YNA	Y

# View ModelCHECK Report Y=applet reports, N=html reports w/applet buttons,
#   S=standalone java executable
MODE_VIEW	YNS	Y

# Enable/Disable ModelCHECK in specific modes
MODE_RUN	YN	Y	Y	N	N

# Automatically update errors in models when run in BATCH
MODE_UPDATE	YN	Y	N	N	N

# Enable/Disable ModelCHECK metrics in specific modes
MC_METRICS	YN	Y	Y	Y	Y

# Allows to add parameter in ModelCHECK report without specifying any value.
MC_ENABLE_EMPTY_PARAM  YN   Y

# Enable/Disable ModelUpdate
MU_ENABLED	YN	Y

# Enable/Disable regenerating of model with ModelUPDATE
MU_REGENERATE	YN	Y

# Interactive SAVE MODE - pre (Y) or post (N)?
SAVE_MC_PRE	YN	N

# Enable/Disable saving of model after performing ModelUPDATE
SAVE_MU	YN	N

# Enable/Disable ModelUpdate  for Skeleton parts
UPDATE_SKELETON	YN	N

# Enable/Disable ModelUpdate  for Sheetmetal parts
UPDATE_SHEETMETAL	YN	N

# Enable/Disable ModelUpdate  for Interchange Assembly
UPDATE_INTER_ASM	YN	N

# PROGRAM NAMES
PROGRAM	proe
NETSCAPE	netscape
