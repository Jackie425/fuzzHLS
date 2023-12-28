int checksum_hercules = 0;/*
 * This is a RANDOMLY GENERATED PROGRAM.
 *
 * Generator: csmith 2.4.0
 * Git version: 0ec6f1b
 * Options:   --no-packed-struct --no-compound-assignment --no-embedded-assigns --no-argc --max-funcs 5 --max-block-depth 2 --max-array-dim 3 --max-expr-complexity 2 --probability-configuration ../fuzzHLS_probabilities
 * Seed:      1782386379
 */

#include "csmith.h"


static long __undefined;

/* --- Struct/Union Declarations --- */
/* --- GLOBAL VARIABLES --- */
static int16_t g_6 = 1L;
static int16_t g_19 = 1L;
static int32_t g_28 = 0L;


/* --- FORWARD DECLARATIONS --- */
static uint16_t  func_1(void);
static const uint16_t  func_2(uint32_t  p_3, uint64_t  p_4);
static uint32_t  func_8(int16_t  p_9);
static int32_t  func_10(uint16_t  p_11, uint64_t  p_12, const int64_t  p_13, uint32_t  p_14);


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
/* 
 * reads : g_6 g_19 g_28
 * writes: g_19 g_28
 */
static uint16_t  func_1(void)
{ /* block id: 0 */
    uint64_t l_5 = 0x9351F20002526041LL;
    int32_t l_21 = 4L;
    uint32_t l_29 = 8UL;
    if ((func_2(l_5, g_6) >= g_6))
    { /* block id: 4 */
        int32_t l_22 = 0xD95FF79FL;
        l_21 = ((func_8(l_5) == 1UL) || g_19);
       checksum_hercules += l_21 ;
        l_21 = 0x7CCE45D7L;
       checksum_hercules += l_21 ;
        l_22 = 0L;
       checksum_hercules += l_22 ;
    }
    else
    { /* block id: 18 */
        int16_t l_27 = (-9L);
        g_28 = (((safe_add_func_uint32_t_u_u((g_19 , g_19), l_27)) , g_19) == 0UL);
       checksum_hercules += g_28 ;
        l_21 = 3L;
       checksum_hercules += l_21 ;
        l_21 = g_28;
       checksum_hercules += l_21 ;
    }
    return l_29;
}


/* ------------------------------------------ */
/* 
 * reads : g_6
 * writes:
 */
static const uint16_t  func_2(uint32_t  p_3, uint64_t  p_4)
{ /* block id: 1 */
    uint32_t l_7 = 0x2A8358BDL;
    l_7 = g_6;
       checksum_hercules += l_7 ;
    return l_7;
}


/* ------------------------------------------ */
/* 
 * reads : g_6
 * writes: g_19
 */
static uint32_t  func_8(int16_t  p_9)
{ /* block id: 5 */
    uint32_t l_15 = 0xC7B7F609L;
    uint32_t l_20 = 0x20B50F6BL;
    l_20 = func_10(g_6, l_15, g_6, l_15);
       checksum_hercules += l_20 ;
    return l_15;
}


/* ------------------------------------------ */
/* 
 * reads : g_6
 * writes: g_19
 */
static int32_t  func_10(uint16_t  p_11, uint64_t  p_12, const int64_t  p_13, uint32_t  p_14)
{ /* block id: 6 */
    int8_t l_16 = 1L;
    if (p_14)
    { /* block id: 7 */
        uint16_t l_17 = 65529UL;
        l_17 = l_16;
       checksum_hercules += l_17 ;
    }
    else
    { /* block id: 9 */
        int32_t l_18 = 0x6753F3ACL;
        g_19 = (func_2(l_18, g_6) > l_16);
       checksum_hercules += g_19 ;
    }
    return l_16;
}




/* ---------------------------------------- */
int hls_top(void)
{
    int print_hash_value = 0;
    platform_main_begin();
    crc32_gentab();
    func_1();
    transparent_crc(g_6, "g_6", print_hash_value);
    transparent_crc(g_19, "g_19", print_hash_value);
    transparent_crc(g_28, "g_28", print_hash_value);
    return (crc32_context ^ 0xFFFFFFFFUL)+ checksum_hercules;
}

/************************ statistics *************************
XXX max struct depth: 0
breakdown:
   depth: 0, occurrence: 14
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

XXX max expression depth: 5
breakdown:
   depth: 1, occurrence: 21
   depth: 4, occurrence: 3
   depth: 5, occurrence: 2

XXX total number of pointers: 0

XXX times a non-volatile is read: 24
XXX times a non-volatile is write: 10
XXX times a volatile is read: 0
XXX    times read thru a pointer: 0
XXX times a volatile is write: 0
XXX    times written thru a pointer: 0
XXX times a volatile is available for access: 0
XXX percentage of non-volatile access: 100

XXX forward jumps: 0
XXX backward jumps: 0

XXX stmts: 16
XXX max block depth: 1
breakdown:
   depth: 0, occurrence: 8
   depth: 1, occurrence: 8

XXX percentage a fresh-made variable is used: 41.2
XXX percentage an existing variable is used: 58.8
XXX total OOB instances added: 0
********************* end of statistics **********************/

