#include "zombie.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Tile spr_zombie_00: 10x20 pixels, 5x20 bytes.
const u8 spr_zombie_00[5 * 20] = {
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xe4, 0xcc, 0xd8, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0x8c, 0xcc, 0x4c, 0xf0,
	0xf0, 0x8c, 0xcc, 0x4c, 0xf0,
	0xf0, 0xe4, 0xcc, 0xd8, 0xf0,
	0xf0, 0xf0, 0x3c, 0xf0, 0xf0,
	0xf0, 0xa0, 0x3c, 0x5a, 0xf0,
	0xf0, 0x14, 0x3c, 0x2d, 0xf0,
	0xf0, 0x9c, 0x3c, 0x6c, 0xf0,
	0xf0, 0x9c, 0x3c, 0x6c, 0xf0,
	0xf0, 0x88, 0x3c, 0x6c, 0xf0,
	0xf0, 0x88, 0x3c, 0x4e, 0xf0,
	0xf0, 0xa0, 0x2d, 0x5a, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xa0, 0xf0, 0x50, 0xf0
};

// Tile spr_zombie_01: 10x20 pixels, 5x20 bytes.
const u8 spr_zombie_01[5 * 20] = {
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xe4, 0xcc, 0xd8, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xe4, 0xcc, 0xd8, 0xf0,
	0xf0, 0xf0, 0x3c, 0xf0, 0xf0,
	0xf0, 0xa0, 0x3c, 0x5a, 0xf0,
	0xf0, 0x14, 0x3c, 0x2d, 0xf0,
	0xf0, 0x9c, 0x3c, 0x6c, 0xf0,
	0xf0, 0x9c, 0x3c, 0x6c, 0xf0,
	0xf0, 0x88, 0x3c, 0x6c, 0xf0,
	0xf0, 0x88, 0x3c, 0x4e, 0xf0,
	0xf0, 0xa0, 0x2d, 0x5a, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xa0, 0xf0, 0x50, 0xf0
};

// Tile spr_zombie_02: 10x20 pixels, 5x20 bytes.
const u8 spr_zombie_02[5 * 20] = {
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xf0, 0xcc, 0xcc, 0xf0,
	0xf0, 0xe4, 0xcc, 0xcc, 0xd8,
	0xf0, 0xe4, 0xcc, 0xcc, 0xd8,
	0xf0, 0xe4, 0xcc, 0xcc, 0xd8,
	0xf0, 0xe4, 0x4c, 0xcc, 0xd8,
	0xf0, 0xe4, 0x4c, 0xcc, 0xd8,
	0xf0, 0xf0, 0xcc, 0xcc, 0xf0,
	0xf0, 0xf0, 0xb4, 0x78, 0xf0,
	0xf0, 0xf0, 0x14, 0x2d, 0xf0,
	0xf0, 0xf0, 0x3c, 0x3c, 0xf0,
	0xf0, 0xf0, 0x3c, 0x9c, 0xf0,
	0xf0, 0xf0, 0x3c, 0x9c, 0xf0,
	0xf0, 0xf0, 0x14, 0x9c, 0xf0,
	0xf0, 0xf0, 0x14, 0x8d, 0xf0,
	0xf0, 0xf0, 0x14, 0x0f, 0xf0,
	0xf0, 0xf0, 0xf0, 0xd8, 0xf0,
	0xf0, 0xf0, 0xf0, 0xd8, 0xf0,
	0xf0, 0xf0, 0xf0, 0xd8, 0xf0,
	0xf0, 0xf0, 0xf0, 0x50, 0xf0
};

// Tile spr_zombie_03: 10x20 pixels, 5x20 bytes.
const u8 spr_zombie_03[5 * 20] = {
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xcc, 0xcc, 0xf0, 0xf0,
	0xe4, 0xcc, 0xcc, 0xd8, 0xf0,
	0xe4, 0xcc, 0xcc, 0xd8, 0xf0,
	0xe4, 0xcc, 0xcc, 0xd8, 0xf0,
	0xe4, 0xcc, 0x8c, 0xd8, 0xf0,
	0xe4, 0xcc, 0x8c, 0xd8, 0xf0,
	0xf0, 0xcc, 0xcc, 0xf0, 0xf0,
	0xf0, 0xb4, 0x78, 0xf0, 0xf0,
	0xf0, 0x14, 0x2d, 0xf0, 0xf0,
	0xf0, 0x3c, 0x3c, 0xf0, 0xf0,
	0xf0, 0x6c, 0x3c, 0xf0, 0xf0,
	0xf0, 0x6c, 0x3c, 0xf0, 0xf0,
	0xf0, 0x44, 0x3c, 0xf0, 0xf0,
	0xf0, 0x44, 0x2d, 0xf0, 0xf0,
	0xf0, 0x14, 0x0f, 0xf0, 0xf0,
	0xf0, 0xe4, 0xf0, 0xf0, 0xf0,
	0xf0, 0xe4, 0xf0, 0xf0, 0xf0,
	0xf0, 0xe4, 0xf0, 0xf0, 0xf0,
	0xf0, 0xa0, 0xf0, 0xf0, 0xf0
};

// Tile spr_zombie_04: 10x20 pixels, 5x20 bytes.
const u8 spr_zombie_04[5 * 20] = {
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xe4, 0xcc, 0xd8, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0x8c, 0xcc, 0x4c, 0xf0,
	0xf0, 0x8c, 0xcc, 0x4c, 0xf0,
	0xf0, 0xe4, 0xcc, 0xd8, 0xf0,
	0xf0, 0xf0, 0x3c, 0xf0, 0xf0,
	0xf0, 0xa0, 0x3c, 0x5a, 0xf0,
	0xf0, 0x14, 0x3c, 0x2d, 0xf0,
	0xf0, 0x9c, 0x3c, 0x6c, 0xf0,
	0xf0, 0x9c, 0x3c, 0x6c, 0xf0,
	0xf0, 0x88, 0x3c, 0x6c, 0xf0,
	0xf0, 0x88, 0x3c, 0x4e, 0xf0,
	0xf0, 0xa0, 0x2d, 0x5a, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xa0, 0xf0, 0x50, 0xf0
};

// Tile spr_zombie_05: 10x20 pixels, 5x20 bytes.
const u8 spr_zombie_05[5 * 20] = {
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xe4, 0xcc, 0xd8, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xe4, 0xcc, 0xd8, 0xf0,
	0xf0, 0xf0, 0x3c, 0xf0, 0xf0,
	0xf0, 0xa0, 0x3c, 0x5a, 0xf0,
	0xf0, 0x14, 0x3c, 0x2d, 0xf0,
	0xf0, 0x9c, 0x3c, 0x6c, 0xf0,
	0xf0, 0x9c, 0x3c, 0x6c, 0xf0,
	0xf0, 0x88, 0x3c, 0x6c, 0xf0,
	0xf0, 0x88, 0x3c, 0x4e, 0xf0,
	0xf0, 0xa0, 0x2d, 0x5a, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xa0, 0xf0, 0x50, 0xf0
};

// Tile spr_zombie_06: 10x20 pixels, 5x20 bytes.
const u8 spr_zombie_06[5 * 20] = {
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xf0, 0xcc, 0xcc, 0xf0,
	0xf0, 0xe4, 0xcc, 0xcc, 0xd8,
	0xf0, 0xe4, 0xcc, 0xcc, 0xd8,
	0xf0, 0xe4, 0xcc, 0xcc, 0xd8,
	0xf0, 0xe4, 0x4c, 0xcc, 0xd8,
	0xf0, 0xe4, 0x4c, 0xcc, 0xd8,
	0xf0, 0xf0, 0xcc, 0xcc, 0xf0,
	0xf0, 0xf0, 0xb4, 0x78, 0xf0,
	0xf0, 0xf0, 0x14, 0x2d, 0xf0,
	0xf0, 0xf0, 0x3c, 0x3c, 0xf0,
	0xf0, 0xf0, 0x3c, 0x9c, 0xf0,
	0xf0, 0xf0, 0x3c, 0x9c, 0xf0,
	0xf0, 0xf0, 0x14, 0x9c, 0xf0,
	0xf0, 0xf0, 0x14, 0x8d, 0xf0,
	0xf0, 0xf0, 0x14, 0x0f, 0xf0,
	0xf0, 0xf0, 0xf0, 0xd8, 0xf0,
	0xf0, 0xf0, 0xf0, 0xd8, 0xf0,
	0xf0, 0xf0, 0xf0, 0x50, 0xf0
};

// Tile spr_zombie_07: 10x20 pixels, 5x20 bytes.
const u8 spr_zombie_07[5 * 20] = {
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xcc, 0xcc, 0xf0, 0xf0,
	0xe4, 0xcc, 0xcc, 0xd8, 0xf0,
	0xe4, 0xcc, 0xcc, 0xd8, 0xf0,
	0xe4, 0xcc, 0xcc, 0xd8, 0xf0,
	0xe4, 0xcc, 0x8c, 0xd8, 0xf0,
	0xe4, 0xcc, 0x8c, 0xd8, 0xf0,
	0xf0, 0xcc, 0xcc, 0xf0, 0xf0,
	0xf0, 0xb4, 0x78, 0xf0, 0xf0,
	0xf0, 0x14, 0x2d, 0xf0, 0xf0,
	0xf0, 0x3c, 0x3c, 0xf0, 0xf0,
	0xf0, 0x6c, 0x3c, 0xf0, 0xf0,
	0xf0, 0x6c, 0x3c, 0xf0, 0xf0,
	0xf0, 0x44, 0x3c, 0xf0, 0xf0,
	0xf0, 0x44, 0x2d, 0xf0, 0xf0,
	0xf0, 0x14, 0x0f, 0xf0, 0xf0,
	0xf0, 0xe4, 0xf0, 0xf0, 0xf0,
	0xf0, 0xe4, 0xf0, 0xf0, 0xf0,
	0xf0, 0xa0, 0xf0, 0xf0, 0xf0
};

// Tile spr_zombie_08: 10x20 pixels, 5x20 bytes.
const u8 spr_zombie_08[5 * 20] = {
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xe4, 0xcc, 0xd8, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0x8c, 0xcc, 0x4c, 0xf0,
	0xf0, 0x8c, 0xcc, 0x4c, 0xf0,
	0xf0, 0xe4, 0xcc, 0xd8, 0xf0,
	0xf0, 0xf0, 0x3c, 0xf0, 0xf0,
	0xf0, 0xa0, 0x3c, 0x5a, 0xf0,
	0xf0, 0x14, 0x3c, 0x2d, 0xf0,
	0xf0, 0x9c, 0x3c, 0x6c, 0xf0,
	0xf0, 0x9c, 0x3c, 0x6c, 0xf0,
	0xf0, 0xa0, 0x3c, 0x78, 0xf0,
	0xf0, 0xa0, 0x3c, 0x5a, 0xf0,
	0xf0, 0xa0, 0x2d, 0x5a, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xa0, 0xf0, 0x50, 0xf0
};

// Tile spr_zombie_09: 10x20 pixels, 5x20 bytes.
const u8 spr_zombie_09[5 * 20] = {
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xe4, 0xcc, 0xd8, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xcc, 0xcc, 0xcc, 0xf0,
	0xf0, 0xe4, 0xcc, 0xd8, 0xf0,
	0xf0, 0xf0, 0x3c, 0xf0, 0xf0,
	0xf0, 0xa0, 0x3c, 0x5a, 0xf0,
	0xf0, 0x14, 0x3c, 0x2d, 0xf0,
	0xf0, 0x9c, 0x3c, 0x6c, 0xf0,
	0xf0, 0x9c, 0x3c, 0x6c, 0xf0,
	0xf0, 0xa0, 0x3c, 0x78, 0xf0,
	0xf0, 0xa0, 0x3c, 0x5a, 0xf0,
	0xf0, 0xa0, 0x2d, 0x5a, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xe4, 0xf0, 0xd8, 0xf0,
	0xf0, 0xa0, 0xf0, 0x50, 0xf0
};

// Tile spr_zombie_10: 10x20 pixels, 5x20 bytes.
const u8 spr_zombie_10[5 * 20] = {
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xf0, 0xcc, 0xcc, 0xf0,
	0xf0, 0xe4, 0xcc, 0xcc, 0xd8,
	0xf0, 0xe4, 0xcc, 0xcc, 0xd8,
	0xf0, 0xe4, 0xcc, 0xcc, 0xd8,
	0xf0, 0xe4, 0x4c, 0xcc, 0xd8,
	0xf0, 0xe4, 0x4c, 0xcc, 0xd8,
	0xf0, 0xf0, 0xcc, 0xcc, 0xf0,
	0xf0, 0xf0, 0xb4, 0x78, 0xf0,
	0xf0, 0xf0, 0x14, 0x2d, 0xf0,
	0xf0, 0xf0, 0x3c, 0x3c, 0xf0,
	0xf0, 0xe4, 0xcc, 0x9c, 0xf0,
	0xf0, 0xf0, 0x3c, 0x3c, 0xf0,
	0xf0, 0xf0, 0x14, 0x3c, 0xf0,
	0xf0, 0xf0, 0x14, 0x2d, 0xf0,
	0xf0, 0xf0, 0x14, 0x0f, 0xf0,
	0xf0, 0xf0, 0xf0, 0xd8, 0xf0,
	0xf0, 0xf0, 0xf0, 0xd8, 0xf0,
	0xf0, 0xf0, 0xf0, 0xd8, 0xf0,
	0xf0, 0xf0, 0xf0, 0x50, 0xf0
};

// Tile spr_zombie_11: 10x20 pixels, 5x20 bytes.
const u8 spr_zombie_11[5 * 20] = {
	0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
	0xf0, 0xcc, 0xcc, 0xf0, 0xf0,
	0xe4, 0xcc, 0xcc, 0xd8, 0xf0,
	0xe4, 0xcc, 0xcc, 0xd8, 0xf0,
	0xe4, 0xcc, 0xcc, 0xd8, 0xf0,
	0xe4, 0xcc, 0x8c, 0xd8, 0xf0,
	0xe4, 0xcc, 0x8c, 0xd8, 0xf0,
	0xf0, 0xcc, 0xcc, 0xf0, 0xf0,
	0xf0, 0xb4, 0x78, 0xf0, 0xf0,
	0xf0, 0x14, 0x2d, 0xf0, 0xf0,
	0xf0, 0x3c, 0x3c, 0xf0, 0xf0,
	0xf0, 0x6c, 0xcc, 0xd8, 0xf0,
	0xf0, 0x3c, 0x3c, 0xf0, 0xf0,
	0xf0, 0x14, 0x3c, 0xf0, 0xf0,
	0xf0, 0x14, 0x2d, 0xf0, 0xf0,
	0xf0, 0x14, 0x0f, 0xf0, 0xf0,
	0xf0, 0xe4, 0xf0, 0xf0, 0xf0,
	0xf0, 0xe4, 0xf0, 0xf0, 0xf0,
	0xf0, 0xe4, 0xf0, 0xf0, 0xf0,
	0xf0, 0xa0, 0xf0, 0xf0, 0xf0
};

