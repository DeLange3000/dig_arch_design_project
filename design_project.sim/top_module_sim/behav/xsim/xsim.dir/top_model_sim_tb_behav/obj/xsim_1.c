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
extern void execute_201(char*, char *);
extern void execute_196(char*, char *);
extern void execute_193(char*, char *);
extern void execute_194(char*, char *);
extern void execute_195(char*, char *);
extern void execute_36(char*, char *);
extern void execute_40(char*, char *);
extern void execute_88(char*, char *);
extern void execute_89(char*, char *);
extern void execute_90(char*, char *);
extern void execute_91(char*, char *);
extern void execute_98(char*, char *);
extern void execute_104(char*, char *);
extern void execute_110(char*, char *);
extern void execute_116(char*, char *);
extern void execute_123(char*, char *);
extern void execute_129(char*, char *);
extern void execute_135(char*, char *);
extern void execute_141(char*, char *);
extern void execute_148(char*, char *);
extern void execute_154(char*, char *);
extern void execute_160(char*, char *);
extern void execute_166(char*, char *);
extern void execute_173(char*, char *);
extern void execute_179(char*, char *);
extern void execute_185(char*, char *);
extern void execute_191(char*, char *);
extern void execute_95(char*, char *);
extern void execute_97(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[31] = {(funcp)execute_201, (funcp)execute_196, (funcp)execute_193, (funcp)execute_194, (funcp)execute_195, (funcp)execute_36, (funcp)execute_40, (funcp)execute_88, (funcp)execute_89, (funcp)execute_90, (funcp)execute_91, (funcp)execute_98, (funcp)execute_104, (funcp)execute_110, (funcp)execute_116, (funcp)execute_123, (funcp)execute_129, (funcp)execute_135, (funcp)execute_141, (funcp)execute_148, (funcp)execute_154, (funcp)execute_160, (funcp)execute_166, (funcp)execute_173, (funcp)execute_179, (funcp)execute_185, (funcp)execute_191, (funcp)execute_95, (funcp)execute_97, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback};
const int NumRelocateId= 31;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/top_model_sim_tb_behav/xsim.reloc",  (void **)funcTab, 31);
	iki_vhdl_file_variable_register(dp + 13272);
	iki_vhdl_file_variable_register(dp + 13328);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/top_model_sim_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/top_model_sim_tb_behav/xsim.reloc");
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
    iki_set_sv_type_file_path_name("xsim.dir/top_model_sim_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/top_model_sim_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/top_model_sim_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
