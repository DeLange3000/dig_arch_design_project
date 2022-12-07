/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_187(char*, char *);
extern void execute_185(char*, char *);
extern void execute_186(char*, char *);
extern void execute_28(char*, char *);
extern void execute_32(char*, char *);
extern void execute_80(char*, char *);
extern void execute_81(char*, char *);
extern void execute_82(char*, char *);
extern void execute_83(char*, char *);
extern void execute_90(char*, char *);
extern void execute_96(char*, char *);
extern void execute_102(char*, char *);
extern void execute_108(char*, char *);
extern void execute_115(char*, char *);
extern void execute_121(char*, char *);
extern void execute_127(char*, char *);
extern void execute_133(char*, char *);
extern void execute_140(char*, char *);
extern void execute_146(char*, char *);
extern void execute_152(char*, char *);
extern void execute_158(char*, char *);
extern void execute_165(char*, char *);
extern void execute_171(char*, char *);
extern void execute_177(char*, char *);
extern void execute_183(char*, char *);
extern void execute_87(char*, char *);
extern void execute_89(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_2(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[30] = {(funcp)execute_187, (funcp)execute_185, (funcp)execute_186, (funcp)execute_28, (funcp)execute_32, (funcp)execute_80, (funcp)execute_81, (funcp)execute_82, (funcp)execute_83, (funcp)execute_90, (funcp)execute_96, (funcp)execute_102, (funcp)execute_108, (funcp)execute_115, (funcp)execute_121, (funcp)execute_127, (funcp)execute_133, (funcp)execute_140, (funcp)execute_146, (funcp)execute_152, (funcp)execute_158, (funcp)execute_165, (funcp)execute_171, (funcp)execute_177, (funcp)execute_183, (funcp)execute_87, (funcp)execute_89, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_2};
const int NumRelocateId= 30;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/full_encoding_tb_behav/xsim.reloc",  (void **)funcTab, 30);
	iki_vhdl_file_variable_register(dp + 10880);
	iki_vhdl_file_variable_register(dp + 10936);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/full_encoding_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/full_encoding_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/full_encoding_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/full_encoding_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/full_encoding_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
