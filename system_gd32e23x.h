/*!****************************************************************************
 * @file
 * system_gd32e23x.h
 *
 * @brief
 * Early system initialisation
 *
 * @date  02.01.2026
 ******************************************************************************/

#ifndef SYSTEM_GD32E23X_H_
#define SYSTEM_GD32E23X_H_

/*- Header files -------------------------------------------------------------*/
#include <stdint.h>


/*- Global variables ---------------------------------------------------------*/
/*! Calculated SYSCLK frequency in Hz                                         */
extern volatile uint32_t SystemCoreClock;


/*- Public interface ---------------------------------------------------------*/
void SystemInit(void);
void SystemCoreClockUpdate(void);

#endif // SYSTEM_GD32E23X_H_

