
#include "servo.h"


void delay(int x)
    { for (int i = 0; i < 2000000 * x; i++); }


int main(void)
{
    servo_init();
    delay(10);
  
    servo_en(1);
    servo_set_speed(1, 8);
  
    while(1)
    {
        servo_set_angle(1, 0);
        delay(5);
        servo_set_angle(1, 180);
        delay(5);
    }

    return 0;
}
