// Attack input
if (keyboard_check_pressed(ord("A")) && !attacking) {
    attacking = true;
    attack_timer = attack_cooldown;

    switch (facing) {
        case "left":  sprite_index = spr_main_attack_left; break;
        case "right": sprite_index = spr_main_attack_right; break;
        case "up":    sprite_index = spr_main_attack_up; break;
        case "down":  sprite_index = spr_main_attack_down; break;
    }

    // Check for enemies in front
    var range = 32; // pixels in front of the player
    var tx = x;
    var ty = y;

    switch (facing) {
        case "left":  tx -= range; break;
        case "right": tx += range; break;
        case "up":    ty -= range; break;
        case "down":  ty += range; break;
    }

    var target = instance_place(tx, ty, obj_enemy);
    if (target != noone) {
        with (target) {
            instance_destroy();
        }
    }
}

// Handle attack cooldown
if (attacking) {
    attack_timer -= 1;
    if (attack_timer <= 0) {
        attacking = false;
    }
}

// Only allow movement if not attacking
if (!attacking) {
    var move_x = 0;
    var move_y = 0;

    if (keyboard_check(vk_left)) {
        move_x = -move_speed;
        facing = "left";
        sprite_index = spr_main_left;
    }
    else if (keyboard_check(vk_right)) {
        move_x = move_speed;
        facing = "right";
        sprite_index = spr_main_right;
    }

    if (keyboard_check(vk_up)) {
        move_y = -move_speed;
        facing = "up";
        sprite_index = spr_main_up;
    }
    else if (keyboard_check(vk_down)) {
        move_y = move_speed;
        facing = "down";
        sprite_index = spr_main_down;
    }

    x += move_x;
    y += move_y;

    // Idle if not moving
    if (move_x == 0 && move_y == 0) {
        switch (facing) {
            case "left":  sprite_index = spr_main_idle_left; break;
            case "right": sprite_index = spr_main_idle_right; break;
            case "up":    sprite_index = spr_main_idle_up; break;
            case "down":  sprite_index = spr_main_idle_down; break;
        }
    }
}



