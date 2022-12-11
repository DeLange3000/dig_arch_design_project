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
extern void execute_207(char*, char *);
extern void execute_42(char*, char *);
extern void execute_205(char*, char *);
extern void execute_206(char*, char *);
extern void execute_202(char*, char *);
extern void execute_203(char*, char *);
extern void execute_204(char*, char *);
extern void execute_45(char*, char *);
extern void execute_49(char*, char *);
extern void execute_97(char*, char *);
extern void execute_98(char*, char *);
extern void execute_99(char*, char *);
extern void execute_100(char*, char *);
extern void execute_107(char*, char *);
extern void execute_113(char*, char *);
extern void execute_119(char*, char *);
extern void execute_125(char*, char *);
extern void execute_132(char*, char *);
extern void execute_138(char*, char *);
extern void execute_144(char*, char *);
extern void execute_150(char*, char *);
extern void execute_157(char*, char *);
extern void execute_163(char*, char *);
extern void execute_169(char*, char *);
extern void execute_175(char*, char *);
extern void execute_182(char*, char *);
extern void execute_188(char*, char *);
extern void execute_194(char*, char *);
extern void execute_200(char*, char *);
extern void execute_104(char*, char *);
extern void execute_106(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[33] = {(funcp)execute_207, (funcp)execute_42, (funcp)execute_205, (funcp)execute_206, (funcp)execute_202, (funcp)execute_203, (funcp)execute_204, (funcp)execute_45, (funcp)execute_49, (funcp)execute_97, (funcp)execute_98, (funcp)execute_99, (funcp)execute_100, (funcp)execute_107, (funcp)execute_113, (funcp)execute_119, (funcp)execute_125, (funcp)execute_132, (funcp)execute_138, (funcp)execute_144, (funcp)execute_150, (funcp)execute_157, (funcp)execute_163, (funcp)execute_169, (funcp)execute_175, (funcp)execute_182, (funcp)execute_188, (funcp)execute_194, (funcp)execute_200, (funcp)execute_104, (funcp)execute_106, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback};
const int NumRelocateId= 33;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/top_model_sim_tb_behav/xsim.reloc",  (void **)funcTab, 33);
	iki_vhdl_file_variable_register(dp + 14704);
	iki_vhdl_file_variable_register(dp + 14760);


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
