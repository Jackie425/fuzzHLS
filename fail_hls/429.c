/*
 * This is a RANDOMLY GENERATED PROGRAM.
 *
 * Generator: csmith 2.4.0
 * Git version: 0ec6f1b
 * Options:   --no-packed-struct --no-embedded-assigns --no-argc --max-funcs 5 --max-block-depth 2 --max-array-dim 3 --max-expr-complexity 2 --probability-configuration ../fuzzHLS_probabilities
 * Seed:      3810179999
 */

#include "csmith.h"


static long __undefined;

/* --- Struct/Union Declarations --- */
/* --- GLOBAL VARIABLES --- */
static uint32_t g_5[6] = {0x715F0ED1L,0x3A11C157L,0x715F0ED1L,0x715F0ED1L,0x3A11C157L,0x715F0ED1L};
static int32_t g_10 = 0xD711E7BFL;


/* --- FORWARD DECLARATIONS --- */
static uint32_t  func_1(void);


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
/* 
 * reads : g_5 g_10
 * writes: g_5 g_10
 */
static uint32_t  func_1(void)
{ /* block id: 0 */
    int16_t l_2[1][4] = {{(-2L),(-2L),(-2L),(-2L)}};
    int32_t l_3 = 0xC90A35F3L;
    int32_t l_4 = 0x402E31D8L;
    int i, j;
    g_5[0]++;
    l_4 &= ((safe_lshift_func_uint8_t_u_u(l_3, 5)) != g_5[0]);
    g_10 ^= l_4;
    return g_5[0];
}




/* ---------------------------------------- */
int hls_top(void)
{
    int i;
    int print_hash_value = 0;
    platform_main_begin();
    crc32_gentab();
    func_1();
    for (i = 0; i < 6; i++)
    {
        transparent_crc(g_5[i], "g_5[i]", print_hash_value);
        if (print_hash_value) printf("index = [%d]\n", i);

    }
    transparent_crc(g_10, "g_10", print_hash_value);
    return (crc32_context ^ 0xFFFFFFFFUL);
}

/************************ statistics *************************
XXX max struct depth: 0
breakdown:
   depth: 0, occurrence: 5
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

XXX times a non-volatile is read: 4
XXX times a non-volatile is write: 3
XXX times a volatile is read: 0
XXX    times read thru a pointer: 0
XXX times a volatile is write: 0
XXX    times written thru a pointer: 0
XXX times a volatile is available for access: 0
XXX percentage of non-volatile access: 100

XXX forward jumps: 0
XXX backward jumps: 0

XXX stmts: 4
XXX max block depth: 0
breakdown:
   depth: 0, occurrence: 4

XXX percentage a fresh-made variable is used: 50
XXX percentage an existing variable is used: 50
XXX total OOB instances added: 0
********************* end of statistics **********************/

