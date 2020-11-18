/*------------------------------------------------------------------------------
*	Guide:	01-KERNEL
*	File:	ex01 / common.h
*	Title:	Всякие удобные константы, типы и функции
* ------------------------------------------------------------------------------
*	Description:
* ----------------------------------------------------------------------------*/


#ifndef COMMON_H
#define COMMON_H

// Указанная размерность характерна только для архитектуры x86
// Подробнее про типы данных: https://metanit.com/cpp/c/2.3.php

typedef unsigned int	u32;	// беззнаковое целое число размером 32 бита
typedef 		 int	s32; 	// целое число 32 бита со знаком
typedef unsigned short	u16;	// и т.д.
typedef 		 short	s16;
typedef unsigned char	u8;
typedef 		 char	s8;

void	memcpy(u8 *src, u8 *dest, u32 bytes);

#endif
