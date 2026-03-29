/*!****************************************************************************
 * @file
 * linker_script_gd32e23xx6.ld
 *
 * @brief
 * Device specific linker script for GD32E23xx6 application code
 *
 * @date  11.11.2025
 ******************************************************************************/

/* Stack and heap memory size definitions                                     */
__min_heap_size = 0;                /* Minimum required heap size             */
__stack_size = 1024;                /* Reserved stack size                    */ 

/* Memories definition                                                        */
MEMORY
{
  FLASH     (rx)  : ORIGIN = 0x08000000, LENGTH = 32K
  RAM       (xrw) : ORIGIN = 0x20000000, LENGTH = 6K
}

/* Include common definitions                                                 */
INCLUDE linker_script_common.ld