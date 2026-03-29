/*!****************************************************************************
 * @file
 * linker_script_gd32e23xxb.ld
 *
 * @brief
 * Device specific linker script for GD32E23xxB application code
 *
 * @date  11.11.2025
 ******************************************************************************/

/* Stack and heap memory size definitions                                     */
__min_heap_size = 0;                /* Minimum required heap size             */
__stack_size = 1024;                /* Reserved stack size                    */ 

/* Memories definition                                                        */
MEMORY
{
  FLASH     (rx)  : ORIGIN = 0x08000000, LENGTH = 128K
  RAM       (xrw) : ORIGIN = 0x20000000, LENGTH = 16K
}

/* Include common definitions                                                 */
INCLUDE linker_script_common.ld