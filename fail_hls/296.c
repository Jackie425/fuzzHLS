/*
 * This is a RANDOMLY GENERATED PROGRAM.
 *
 * Generator: csmith 2.4.0
 * Git version: 0ec6f1b
 * Options:   --no-packed-struct --no-embedded-assigns --no-argc --max-funcs 5 --max-block-depth 2 --max-array-dim 3 --max-expr-complexity 2 --probability-configuration ../fuzzHLS_probabilities
 * Seed:      1357475767
 */

#include "csmith.h"


static long __undefined;

/* --- Struct/Union Declarations --- */
/* --- GLOBAL VARIABLES --- */
static volatile uint8_t g_4[5] = {0x50L,0x50L,0x50L,0x50L,0x50L};
static uint16_t g_5 = 65535UL;
static volatile uint32_t g_8 = 0xCA9D6923L;/* VOLATILE GLOBAL g_8 */
static int16_t g_11 = 0xCB3AL;


/* --- FORWARD DECLARATIONS --- */
static uint32_t  func_1(void);


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
/* 
 * reads : g_4 g_5 g_8
 * writes: g_5 g_8 g_11
 */
static uint32_t  func_1(void)
{ /* block id: 0 */
    int32_t l_6 = (-2L);
    int32_t l_7 = 0xD00693E9L;
    g_5 &= ((safe_lshift_func_uint16_t_u_u(0xC809L, 10)) == g_4[4]);
    g_8--;
    g_11 = 0x5CBCEF05L;
    return g_5;
}




/* ---------------------------------------- */
int hls_top(void)
{
    int i;
    int print_hash_value = 0;
    platform_main_begin();
    crc32_gentab();
    func_1();
    for (i = 0; i < 5; i++)
    {
        transparent_crc(g_4[i], "g_4[i]", print_hash_value);
        if (print_hash_value) printf("index = [%d]\n", i);

    }
    transparent_crc(g_5, "g_5", print_hash_value);
    transparent_crc(g_8, "g_8", print_hash_value);
    transparent_crc(g_11, "g_11", print_hash_value);
    return (crc32_context ^ 0xFFFFFFFFUL);
}

/************************ statistics *************************
XXX max struct depth: 0
breakdown:
   depth: 0, occurrence: 6
XXX total union variables: 0

XXX non-zero bitfields defined in structs: 0
XXX zero bitfields defined in structs: 0
XXX const bitfields defined in structs: 0
XXX volatile bitfields defined in structs: 0
XXX structs with bitfields in the program: 0
breakdown:
XXX full-bitfields structs in the program: 0
breakdown:
XXX times a bitfields struct's address is taken: 0
XXX times a bitfields struct on LHS: 0
XXX times a bitfields struct on RHS: 0
XXX times a single bitfield on LHS: 0
XXX times a single bitfield on RHS: 0

XXX max expression depth: 3
breakdown:
   depth: 1, occurrence: 6
   depth: 3, occurrence: 1

XXX total number of pointers: 0

XXX times a non-volatile is read: 1
XXX times a non-volatile is write: 2
XXX times a volatile is read: 1
XXX    times read thru a pointer: 0
XXX times a volatile is write: 1
XXX    times written thru a pointer: 0
XXX times a volatile is available for access: 3
XXX percentage of non-volatile access: 60

XXX forward jumps: 0
XXX backward jumps: 0

XXX stmts: 4
XXX max block depth: 0
breakdown:
   depth: 0, occurrence: 4

XXX percentage a fresh-made variable is used: 85.7
XXX percentage an existing variable is used: 14.3
XXX total OOB instances added: 0
********************* end of statistics **********************/

