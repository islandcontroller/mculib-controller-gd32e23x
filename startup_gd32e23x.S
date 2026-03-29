.include "Core/startup_cm23.s"

.syntax unified
.cpu cortex-m23
.fpu softvfp
.thumb

/******************************************************************************
 * _vector_base
 * Interrupt Vector Table
 ******************************************************************************/
.section  .isr_vector, "a", %progbits
.balign 4
.globl  _vector_base
_vector_base:
  /* Main stack pointer                                                       */
  .word _estack
  /* Internal interrupts                                                      */
  .word _start
  .word NMI_Handler
  .word HardFault_Handler
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word SVC_Handler
  .word 0
  .word 0
  .word PendSV_Handler
  .word SysTick_Handler
  /* External Interrupts                                                      */
  .word WWDGT_IRQHandler
  .word LVD_IRQHandler
  .word RTC_IRQHandler
  .word FMC_IRQHandler
  .word RCU_IRQHandler
  .word EXTI0_1_IRQHandler
  .word EXTI2_3_IRQHandler
  .word EXTI4_15_IRQHandler
  .word 0
  .word DMA_Channel0_IRQHandler
  .word DMA_Channel1_2_IRQHandler
  .word DMA_Channel3_4_IRQHandler
  .word ADC_CMP_IRQHandler
  .word TIMER0_BRK_UP_TRG_COM_IRQHandler
  .word TIMER0_Channel_IRQHandler
  .word 0
  .word TIMER2_IRQHandler
  .word TIMER5_IRQHandler
  .word 0
  .word TIMER13_IRQHandler
  .word TIMER14_IRQHandler
  .word TIMER15_IRQHandler
  .word TIMER16_IRQHandler
  .word I2C0_EV_IRQHandler
  .word I2C1_EV_IRQHandler
  .word SPI0_IRQHandler
  .word SPI1_IRQHandler
  .word USART0_IRQHandler
  .word USART1_IRQHandler
  .word 0
  .word 0
  .word 0
  .word I2C0_ER_IRQHandler
  .word 0
  .word I2C1_ER_IRQHandler

/* Weak definitions of interrupt handlers in .text                            */
.section  .text.vector_handler, "ax", %progbits
.weak NMI_Handler
.weak HardFault_Handler
.weak SVC_Handler
.weak PendSV_Handler
.weak SysTick_Handler
.weak WWDGT_IRQHandler
.weak LVD_IRQHandler
.weak RTC_IRQHandler
.weak FMC_IRQHandler
.weak RCU_IRQHandler
.weak EXTI0_1_IRQHandler
.weak EXTI2_3_IRQHandler
.weak EXTI4_15_IRQHandler
.weak DMA_Channel0_IRQHandler
.weak DMA_Channel1_2_IRQHandler
.weak DMA_Channel3_4_IRQHandler
.weak ADC_CMP_IRQHandler
.weak TIMER0_BRK_UP_TRG_COM_IRQHandler
.weak TIMER0_Channel_IRQHandler
.weak TIMER2_IRQHandler
.weak TIMER5_IRQHandler
.weak TIMER13_IRQHandler
.weak TIMER14_IRQHandler
.weak TIMER15_IRQHandler
.weak TIMER16_IRQHandler
.weak I2C0_EV_IRQHandler
.weak I2C1_EV_IRQHandler
.weak SPI0_IRQHandler
.weak SPI1_IRQHandler
.weak USART0_IRQHandler
.weak USART1_IRQHandler
.weak I2C0_ER_IRQHandler
.weak I2C1_ER_IRQHandler

/* Default to generic handler if not implemented                              */
.thumb_set NMI_Handler, Default_Handler
.thumb_set HardFault_Handler, Default_Handler
.thumb_set SVC_Handler, Default_Handler
.thumb_set PendSV_Handler, Default_Handler
.thumb_set SysTick_Handler, Default_Handler
.thumb_set WWDGT_IRQHandler, Default_Handler
.thumb_set LVD_IRQHandler, Default_Handler
.thumb_set RTC_IRQHandler, Default_Handler
.thumb_set FMC_IRQHandler, Default_Handler
.thumb_set RCU_IRQHandler, Default_Handler
.thumb_set EXTI0_1_IRQHandler, Default_Handler
.thumb_set EXTI2_3_IRQHandler, Default_Handler
.thumb_set EXTI4_15_IRQHandler, Default_Handler
.thumb_set DMA_Channel0_IRQHandler, Default_Handler
.thumb_set DMA_Channel1_2_IRQHandler, Default_Handler
.thumb_set DMA_Channel3_4_IRQHandler, Default_Handler
.thumb_set ADC_CMP_IRQHandler, Default_Handler
.thumb_set TIMER0_BRK_UP_TRG_COM_IRQHandler, Default_Handler
.thumb_set TIMER0_Channel_IRQHandler, Default_Handler
.thumb_set TIMER2_IRQHandler, Default_Handler
.thumb_set TIMER5_IRQHandler, Default_Handler
.thumb_set TIMER13_IRQHandler, Default_Handler
.thumb_set TIMER14_IRQHandler, Default_Handler
.thumb_set TIMER15_IRQHandler, Default_Handler
.thumb_set TIMER16_IRQHandler, Default_Handler
.thumb_set I2C0_EV_IRQHandler, Default_Handler
.thumb_set I2C1_EV_IRQHandler, Default_Handler
.thumb_set SPI0_IRQHandler, Default_Handler
.thumb_set SPI1_IRQHandler, Default_Handler
.thumb_set USART0_IRQHandler, Default_Handler
.thumb_set USART1_IRQHandler, Default_Handler
.thumb_set I2C0_ER_IRQHandler, Default_Handler
.thumb_set I2C1_ER_IRQHandler, Default_Handler


/******************************************************************************
 * Default_Handler
 * Default interrupt handler for unimplemented interrupts
 ******************************************************************************/
.section  .text.Default_Handler
.balign 4
.globl  Default_Handler
.type   Default_Handler, %function
Default_Handler:
  b     Default_Handler
