/*
 * STM32_0 과제 2: PC13 버튼으로 PB0 외부 LED의 점멸 간격을 변경합니다.
 * 과제 1은 아래 LED_ece2_* 심볼을 사용하도록 바꾸고 같은 코드로 확인합니다.
 */
#include "ece2_474.h"
#include "main.h"

void ece2_474_init(void)
{
    /* STM32_0은 폴링 실습이므로 별도 주변장치 시작이 필요하지 않습니다. */
}

void polling_routine(void)
{
    static uint32_t last_ms = 0;
    static GPIO_PinState led_state = GPIO_PIN_RESET;
    const uint32_t now_ms = HAL_GetTick();

    if ((uint32_t)(now_ms - last_ms) >= 1000U)
    {
        last_ms = now_ms;
        led_state = (led_state == GPIO_PIN_RESET) ? GPIO_PIN_SET : GPIO_PIN_RESET;
        HAL_GPIO_WritePin(LED_ece2_GPIO_Port, LED_ece2_Pin, led_state);
    }
}

/* STM32_0 실습은 폴링 방식입니다. 자동 생성된 콜백 연결은 유지합니다. */
static void button_isr_p7(void) { }
static void tim6_isr_p4(void) { }
static void uart2_isr_p6(void) { }
static void uart3_isr_p5(void) { }
static void gpio_in_pullup_isr_p8_ece2(void) { }
static void gpio_in_pulldown_isr_p9_ece2(void) { }

void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
    if (GPIO_Pin == BUTTON_ece2_Pin)
    {
        button_isr_p7();
    }
    else if (GPIO_Pin == GPIO_IN_PULLUP_ece2_Pin)
    {
        gpio_in_pullup_isr_p8_ece2();
    }
    else if (GPIO_Pin == GPIO_IN_PULLDOWN_ece2_Pin)
    {
        gpio_in_pulldown_isr_p9_ece2();
    }
}

void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
    if (htim->Instance == TIM6)
    {
        tim6_isr_p4();
    }
}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)
{
    if (huart->Instance == USART2)
    {
        uart2_isr_p6();
    }
    else if (huart->Instance == USART3)
    {
        uart3_isr_p5();
    }
}
