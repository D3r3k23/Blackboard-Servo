
#ifndef SERVO_H
#define SERVO_H

#include "stdint.h"


#define SERVO_CTRL(n) *(((uint32_t*) 0x43C00000) + n - 1) // n: 1 - 4


void servo_init(void);

void servo_en(int n);

void servo_dis(int n);

void servo_set_angle(int n, uint8_t angle);

void servo_set_speed(int n, uint8_t speed);


#endif // SERVO_H
