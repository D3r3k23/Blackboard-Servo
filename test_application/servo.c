
#include "servo.h"


void servo_init(void)
{
    for (int i = 1; i <= 4; i++)
    {
        servo_dis(i);
        servo_set_angle(i, 90);
        servo_set_speed(i, 0);
    }
}

void servo_en(int n)
{
    SERVO_CTRL(n) |= 0b1;
}

void servo_dis(int n)
{
    SERVO_CTRL(n) &= ~0b1;
}

void servo_set_angle(int n, uint8_t angle)
{
    static uint8_t s_angle = 90;
    
    if (0 <= angle && angle <= 180)
        s_angle = angle;
  
    SERVO_CTRL(n) &= ~(0xFF << 1);
    SERVO_CTRL(n) |= (s_angle & 0xFF) << 1;
}

void servo_set_speed(int n, uint8_t speed)
{
    static uint8_t s_speed = 5;
    
    if (0 <= speed && speed <= 10)
        s_speed = speed;
  
    SERVO_CTRL(n) &= ~(0xF << 9);
    SERVO_CTRL(n) |= (s_speed & 0xF) << 9;
    
}
