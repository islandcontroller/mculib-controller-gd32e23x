/*!****************************************************************************
 * @file
 * system_gd32e23x.c
 *
 * @brief
 * Early system initialisation
 *
 * @date  02.01.2026
 ******************************************************************************/

/*- Header files -------------------------------------------------------------*/
#include <stdbool.h>
#include "gd32e23x.h"
#include "system_gd32e23x.h"


/*- Compiler options ---------------------------------------------------------*/
#pragma GCC push_options
#pragma GCC optimize("Oz")


/*- Global variables ---------------------------------------------------------*/
/*! Calculated SYSCLK frequency in Hz                                         */
volatile uint32_t SystemCoreClock;


/*- Prototypes ---------------------------------------------------------------*/
static uint32_t ulCalcPllBaseClk(uint32_t ulCfgR);


/*- Public interface ---------------------------------------------------------*/
/*!*****************************************************************************
 * @brief
 * Early system init
 *
 * Configures relocateable interrupt vector table and initialises minimum-
 * config for clock tree.
 *
 * @date  02.01.2026
 ******************************************************************************/
void SystemInit(void)
{
  // Configure vector table
  SCB->VTOR = VECT_TAB_OFFSET & SCB_VTOR_TBLOFF_Msk;

  // Enable HSI and switch SYSCLK to it
  RCU_CTL0 |= RCU_CTL0_IRC8MEN;
  while ((RCU_CTL0 & RCU_CTL0_IRC8MSTB) == 0uL);
  RCU_CFG0 &= ~RCU_CFG0_SCS;
  while ((RCU_CFG0 & RCU_CFG0_SCSS) != 0uL);
  RCU_CTL0 = RCU_CTL0_IRC8MEN;
  RCU_CFG0 = 0uL;

  // Switch ADC to internal RC oscillator and stop
  RCU_CTL1 = 0uL;
  RCU_CFG2 = 0uL;

  // Disable interrupts and clear interrupt flags
  RCU_INT = RCU_INT_IRC40KSTBIC | RCU_INT_LXTALSTBIC | RCU_INT_IRC8MSTBIC | \
            RCU_INT_HXTALSTBIC | RCU_INT_PLLSTBIC | RCU_INT_IRC28MSTBIC;

  // Initialise system clock frequency to HSI value
  SystemCoreClock = IRC8M_VALUE;
}

/*!*****************************************************************************
 * @brief
 * Calculate HCLK from current configuration
 *
 * @date  02.01.2026
 ******************************************************************************/
void SystemCoreClockUpdate(void)
{
  uint32_t ulCfgR = RCU_CFG0;
  uint32_t ulBaseClk;

  // Determine SYSCLK base clock
  switch (ulCfgR & RCU_CFG0_SCSS)
  {
    case (0x0uL << 2): ulBaseClk = IRC8M_VALUE; break; // IRC8M
    case (0x1uL << 2): ulBaseClk = HXTAL_VALUE; break; // HXTAL
    case (0x2uL << 2): ulBaseClk = ulCalcPllBaseClk(ulCfgR); break; // PLL
    default:
      // Invalid config
      ulBaseClk = IRC8M_VALUE;
  }

  // Apply HCLK prescaler
  uint32_t ulPreEN  = ((ulCfgR >> 7) & 0x1uL); // AHBPSC[3] Prescaler enable
  uint32_t ulPreDbl = ((ulCfgR >> 6) & 0x1uL); // AHBPSC[2] Double divider
  uint32_t ulPreShf = ((ulCfgR >> 4) & 0x3uL); // AHBPSC[1:0] Divider shift
  SystemCoreClock = ulBaseClk >> (ulPreEN * ((ulPreShf + 1uL) << ulPreDbl));
}


/*- Private functions --------------------------------------------------------*/
/*!*****************************************************************************
 * @brief
 * Determine SYSCLK base clock frequency for PLL configuration
 *
 * @param[in] ulCfgR  Cached CFG0 register value
 * @return  (uint32_t)  Base clock frequency in Hz
 * @date  02.01.2026
*******************************************************************************/
static uint32_t ulCalcPllBaseClk(uint32_t ulCfgR)
{
  uint32_t ulInputFreq;
  uint32_t ulMul = ((((ulCfgR >> 27) & 0x1uL) << 4) | ((ulCfgR >> 18) & 0xFuL)) + 2uL; // PLLMF[4:0] + 2

  if (!(ulCfgR & RCU_CFG0_PLLSEL))
  {
    // IRC8M/2 selected as PLL clock source
    ulInputFreq = IRC8M_VALUE / 2uL;
  }
  else
  {
    // HXTAL selected as PLL clock source. Calculate input after PREDIV
    uint32_t ulDiv = (RCU_CFG1 & RCU_CFG1_PREDV) + 1uL;
    ulInputFreq = HXTAL_VALUE / ulDiv;
  }

  return ulInputFreq * ulMul;
}

/*- Restore compiler options -------------------------------------------------*/
#pragma GCC pop_options
